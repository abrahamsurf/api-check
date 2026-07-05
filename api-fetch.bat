@echo off
setlocal enabledelayedexpansion

:: ==========================================================
:: api-fetch.bat - GET an API endpoint, save formatted JSON
:: ==========================================================


echo ===============================================
echo   API Response Fetcher and JSON Formatter v1.0
echo   Author: 
echo ===============================================
echo.


:: ---- Get URL from argument, or prompt if not provided ----
set "API_URL=%~1"

if "%API_URL%"=="" (
    set /p "API_URL=Enter API URL: "
)

if "%API_URL%"=="" (
    echo ERROR: No URL entered. Exiting.
    exit /b 1
)

:: ---- Config ----
set "AUTH_HEADER=Authorization: Bearer YOUR_TOKEN_HERE"
set "USER_AGENT=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36 Edg/125.0.0.0"
set "RAW_FILE=%TEMP%\api_response_raw.json"
set "OUTPUT_FILE=%CD%\api_response.json"
set "TIMEOUT=10"

echo.
echo Requesting: %API_URL%
echo.

:: ---- Make the request (saves raw/compact JSON to temp file) ----
curl -s -S -m %TIMEOUT% ^
    -H "Accept: application/json" ^
    -H "%AUTH_HEADER%" ^
    -A "%USER_AGENT%" ^
    -o "%RAW_FILE%" ^
    -w "HTTP_STATUS:%%{http_code}\n" ^
    "%API_URL%"

if errorlevel 1 (
    echo ERROR: curl request failed.
    exit /b 1
)

if not exist "%RAW_FILE%" (
    echo ERROR: No response saved.
    exit /b 1
)

:: ---- Reformat JSON into readable/indented form and save to OUTPUT_FILE ----
powershell -NoProfile -Command ^
    "try { " ^
    "$j = Get-Content -Raw '%RAW_FILE%' | ConvertFrom-Json; " ^
    "$j | ConvertTo-Json -Depth 10 | Set-Content -Encoding UTF8 '%OUTPUT_FILE%'; " ^
    "Write-Output 'Formatted JSON saved successfully.' " ^
    "} catch { " ^
    "Write-Output 'ERROR: Response is not valid JSON - saving raw content instead.'; " ^
    "Copy-Item '%RAW_FILE%' '%OUTPUT_FILE%' -Force " ^
    "}"

echo.
echo ---- Formatted Response (%OUTPUT_FILE%) ----
type "%OUTPUT_FILE%"
echo.
echo -----------------------

:: ---- Parse and display key fields (generic - shows whatever exists) ----
echo.
echo ---- Parsed Fields ----
powershell -NoProfile -Command ^
    "try { $j = Get-Content -Raw '%OUTPUT_FILE%' | ConvertFrom-Json; " ^
    "$j.PSObject.Properties | ForEach-Object { Write-Output ($_.Name + ': ' + $_.Value) } } " ^
    "catch { Write-Output 'ERROR: Could not parse fields' }"

del "%RAW_FILE%" >nul 2>&1
endlocal