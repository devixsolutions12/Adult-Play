# Simple HTTP Server for Website
$port = 8000

# Get the script directory
if ($PSScriptRoot) {
    $root = $PSScriptRoot
} else {
    $root = Split-Path -Parent $MyInvocation.MyCommand.Path
    if (-not $root) {
        $root = Get-Location
    }
}

# Ensure we're in the website directory
Set-Location $root

Write-Host "Starting web server on http://localhost:$port" -ForegroundColor Green
Write-Host "Website root: $root" -ForegroundColor Cyan
Write-Host ""

# Verify index.html exists
if (-not (Test-Path (Join-Path $root "index.html"))) {
    Write-Host "ERROR: index.html not found in $root" -ForegroundColor Red
    Write-Host "Files in directory:" -ForegroundColor Yellow
    Get-ChildItem $root | Select-Object Name | Format-Table
    pause
    exit
}

Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host ""

# Create HTTP listener
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")

try {
    $listener.Start()
    Write-Host "Server started successfully!" -ForegroundColor Green
    Write-Host "Opening browser..." -ForegroundColor Cyan
    Start-Sleep -Seconds 1
    Start-Process "http://localhost:$port"
    
    # MIME type mapping
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
    
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response
        
        $localPath = $request.Url.LocalPath
        if ($localPath -eq "/" -or $localPath -eq "") {
            $localPath = "/index.html"
        }
        
        # Normalize path - remove leading slash and convert to Windows path
        $relativePath = $localPath.TrimStart('/').Replace('/', [System.IO.Path]::DirectorySeparatorChar)
        $filePath = Join-Path $root $relativePath
        
        # Normalize the file path
        $filePath = [System.IO.Path]::GetFullPath($filePath)
        $rootNormalized = [System.IO.Path]::GetFullPath($root)
        
        # Security check - ensure file is within root directory
        if (-not $filePath.StartsWith($rootNormalized, [System.StringComparison]::OrdinalIgnoreCase)) {
            $response.StatusCode = 403
            $forbidden = [System.Text.Encoding]::UTF8.GetBytes("403 Forbidden")
            $response.OutputStream.Write($forbidden, 0, $forbidden.Length)
            Write-Host "$($request.HttpMethod) $localPath - 403 (Security)" -ForegroundColor Red
            $response.Close()
            continue
        }
        
        if (Test-Path $filePath -PathType Leaf) {
            try {
                $content = [System.IO.File]::ReadAllBytes($filePath)
                $response.ContentLength64 = $content.Length
                
                $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
                $contentType = if ($mimeTypes.ContainsKey($ext)) { $mimeTypes[$ext] } else { "application/octet-stream" }
                $response.ContentType = $contentType
                
                $response.OutputStream.Write($content, 0, $content.Length)
                Write-Host "$($request.HttpMethod) $localPath - 200 OK" -ForegroundColor Green
            } catch {
                $response.StatusCode = 500
                $errorMsg = [System.Text.Encoding]::UTF8.GetBytes("500 Internal Server Error")
                $response.OutputStream.Write($errorMsg, 0, $errorMsg.Length)
                Write-Host "$($request.HttpMethod) $localPath - 500 Error: $_" -ForegroundColor Red
            }
        } else {
            $response.StatusCode = 404
            $notFoundHtml = @"
<!DOCTYPE html>
<html>
<head><title>404 Not Found</title></head>
<body>
<h1>404 Not Found</h1>
<p>The requested file was not found on this server.</p>
<p>Requested: $localPath</p>
<p>Looking in: $root</p>
</body>
</html>
"@
            $notFound = [System.Text.Encoding]::UTF8.GetBytes($notFoundHtml)
            $response.ContentType = "text/html; charset=utf-8"
            $response.OutputStream.Write($notFound, 0, $notFound.Length)
            Write-Host "$($request.HttpMethod) $localPath - 404 (File: $filePath)" -ForegroundColor Red
        }
        
        $response.Close()
    }
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Alternative: Install Python and run: python -m http.server 8000" -ForegroundColor Yellow
    pause
} finally {
    if ($listener.IsListening) {
        $listener.Stop()
    }
}

