# Simple HTTP Server - Guaranteed to work
$port = 8080
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not $root) { $root = Get-Location }

Set-Location $root

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Adult Play Web Server" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Port: $port" -ForegroundColor Yellow
Write-Host "Root: $root" -ForegroundColor Yellow
Write-Host ""

# Verify files
$indexPath = Join-Path $root "index.html"
if (-not (Test-Path $indexPath)) {
    Write-Host "ERROR: index.html not found!" -ForegroundColor Red
    Write-Host "Current directory: $(Get-Location)" -ForegroundColor Red
    Write-Host "Files:" -ForegroundColor Red
    Get-ChildItem | Format-Table
    pause
    exit
}

Write-Host "Files found:" -ForegroundColor Green
Get-ChildItem -File | Select-Object Name | Format-Table
Write-Host ""

# MIME types
$mimeTypes = @{
    '.html' = 'text/html; charset=utf-8'
    '.css'  = 'text/css; charset=utf-8'
    '.js'   = 'application/javascript; charset=utf-8'
    '.apk'  = 'application/vnd.android.package-archive'
    '.png'  = 'image/png'
    '.jpg'  = 'image/jpeg'
    '.jpeg' = 'image/jpeg'
    '.svg'  = 'image/svg+xml'
}

# Create listener
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")

try {
    $listener.Start()
    Write-Host "Server started on http://localhost:$port" -ForegroundColor Green
    Write-Host "Opening Chrome..." -ForegroundColor Cyan
    Start-Sleep -Seconds 1
    Start-Process "chrome.exe" -ArgumentList "http://localhost:$port"
    Write-Host ""
    Write-Host "Press Ctrl+C to stop" -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response
        
        $urlPath = $request.Url.LocalPath
        if ($urlPath -eq "/" -or $urlPath -eq "") {
            $urlPath = "/index.html"
        }
        
        # Build file path
        $filePath = $urlPath.TrimStart('/')
        $filePath = $filePath.Replace('/', '\')
        $fullPath = Join-Path $root $filePath
        $fullPath = [System.IO.Path]::GetFullPath($fullPath)
        
        Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] $($request.HttpMethod) $urlPath" -NoNewline
        
        if (Test-Path $fullPath -PathType Leaf) {
            try {
                $content = [System.IO.File]::ReadAllBytes($fullPath)
                $response.ContentLength64 = $content.Length
                
                $ext = [System.IO.Path]::GetExtension($fullPath).ToLower()
                $contentType = if ($mimeTypes.ContainsKey($ext)) { 
                    $mimeTypes[$ext] 
                } else { 
                    "application/octet-stream" 
                }
                $response.ContentType = $contentType
                
                $response.StatusCode = 200
                $response.OutputStream.Write($content, 0, $content.Length)
                Write-Host " - 200 OK" -ForegroundColor Green
            } catch {
                $response.StatusCode = 500
                $response.Close()
                Write-Host " - 500 ERROR: $_" -ForegroundColor Red
                continue
            }
        } else {
            $response.StatusCode = 404
            $html = @"
<!DOCTYPE html>
<html>
<head><title>404 Not Found</title></head>
<body style="font-family: Arial; padding: 40px;">
<h1>404 Not Found</h1>
<p><strong>Requested:</strong> $urlPath</p>
<p><strong>Looking for:</strong> $fullPath</p>
<p><strong>Root directory:</strong> $root</p>
<hr>
<h3>Available files:</h3>
<ul>
$((Get-ChildItem $root -File | ForEach-Object { "<li>$($_.Name)</li>" }) -join "`n")
</ul>
</body>
</html>
"@
            $bytes = [System.Text.Encoding]::UTF8.GetBytes($html)
            $response.ContentType = "text/html; charset=utf-8"
            $response.ContentLength64 = $bytes.Length
            $response.OutputStream.Write($bytes, 0, $bytes.Length)
            Write-Host " - 404 NOT FOUND" -ForegroundColor Red
            Write-Host "   Looking for: $fullPath" -ForegroundColor Red
        }
        
        $response.Close()
    }
} catch {
    Write-Host ""
    Write-Host "ERROR: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Stack trace:" -ForegroundColor Red
    Write-Host $_.ScriptStackTrace -ForegroundColor Red
    pause
} finally {
    if ($listener.IsListening) {
        $listener.Stop()
    }
}

