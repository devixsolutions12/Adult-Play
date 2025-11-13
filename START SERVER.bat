@echo off
title Adult Play Web Server
color 0A
cd /d "%~dp0"
echo.
echo ========================================
echo   Starting Adult Play Web Server
echo   Port: 8080
echo ========================================
echo.
powershell -ExecutionPolicy Bypass -File "simple-server.ps1"
pause
