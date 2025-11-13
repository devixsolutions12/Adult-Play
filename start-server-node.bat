@echo off
echo Starting web server on http://localhost:8000
echo.
echo Press Ctrl+C to stop the server
echo.
cd /d "%~dp0"
npx http-server . -p 8000 -o
pause

