# PowerShell script to upload website to GitHub
# Run this from the website folder

Write-Host "=== Uploading Website to GitHub ===" -ForegroundColor Cyan
Write-Host ""

# Check if git is installed
try {
    $gitVersion = git --version
    Write-Host "Git found: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Git is not installed!" -ForegroundColor Red
    Write-Host "Please install Git from: https://git-scm.com/download/win" -ForegroundColor Yellow
    Write-Host "Or use the GitHub web interface instead." -ForegroundColor Yellow
    pause
    exit
}

# Initialize git repository
Write-Host "Initializing git repository..." -ForegroundColor Yellow
git init

# Add all files
Write-Host "Adding all files..." -ForegroundColor Yellow
git add .

# Commit files
Write-Host "Committing files..." -ForegroundColor Yellow
git commit -m "Add website files for Vercel deployment"

# Set main branch
Write-Host "Setting main branch..." -ForegroundColor Yellow
git branch -M main

# Add remote (if not exists)
Write-Host "Adding GitHub remote..." -ForegroundColor Yellow
$remoteExists = git remote get-url origin 2>$null
if ($LASTEXITCODE -ne 0) {
    git remote add origin https://github.com/devixsolutions12/Adult-Play.git
    Write-Host "Remote added successfully" -ForegroundColor Green
} else {
    Write-Host "Remote already exists, updating..." -ForegroundColor Yellow
    git remote set-url origin https://github.com/devixsolutions12/Adult-Play.git
}

# Push to GitHub
Write-Host ""
Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
Write-Host "You may need to enter your GitHub credentials" -ForegroundColor Cyan
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "SUCCESS! Files uploaded to GitHub!" -ForegroundColor Green
    Write-Host "Repository: https://github.com/devixsolutions12/Adult-Play" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Next step: Go to https://vercel.com and import this repository" -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "ERROR: Failed to push to GitHub" -ForegroundColor Red
    Write-Host "Please check your GitHub credentials or use the web interface" -ForegroundColor Yellow
}

pause

