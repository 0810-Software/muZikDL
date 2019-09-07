@echo off
echo Welcome! Preparing setup script...
title MuZikDL Online Installation Script
set randtmp=%temp%\M0810SetupTemp\%random%\
md "%randtmp%"
cd "%randtmp%"


cls
echo Retrieving necessary files...
powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://github.com/Marnix0810/muZikDL/raw/master/bin/Installer-only/7z1900-extra.exe', '7z1900-extra.exe') }"
powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://github.com/Marnix0810/muZikDL/archive/master.zip', 'MuZikDL.zip') }"

cls
echo Unpacking necessary files...
start /wait "" "7z1900-extra.exe" -o"%randtmp%" -y && echo 7za is ready to use 

cls
echo Unpacking MuZikDL files...
set appdir=C:\Users\marni\AppData\Local\Programs\Marnix0810\muZikDL
7za X MuZikDL.zip -o"%appdir%" -y

cls
echo installing Microsoft Visual C++ 2010 Redistributable Package...
start /wait "" "%appdir%\muZikDL-master\bin\Installer-only\vcredist_x86.exe" /install /quiet

cls
echo Creating shortcuts...
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%HOMEDRIVE%\Users\Public\Desktop\MuZikDL.lnk');$s.TargetPath='%appdir%\muZikDL-master\MuZikDL.cmd';$s.Save()"
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%appdata%\Microsoft\Windows\Start Menu\Programs\MuZikDL.lnk');$s.TargetPath='%appdir%\muZikDL-master\MuZikDL.cmd';$s.Save()"
setx path "%PATH%;%appdir%"

cls
echo Cleaning up installer files...
del /q /s "%randtmp%*"
del /q /s "%appdir%\muZikDL-master\bin\Installer-only\*"
cd "%~dp0"
rd /s /q "%appdir%\muZikDL-master\bin\Installer-only\"
rd /s /q "%randtmp%"

cls
Echo the installation of MuZikDL is finished.
start /min "" "https://github.com/Marnix0810/muZikDL/blob/master/LICENSE"
start cmd /c "%appdir%\muZikDL-master\MuZikDL.cmd"
exit