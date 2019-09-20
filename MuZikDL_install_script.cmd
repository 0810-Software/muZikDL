:: If you see this file in your browser instead of downloading it, just use control+s on this page to force a download.





@echo off
color f0
title NOTE
echo NOTE:
echo:
echo ========================================================
echo:
echo MuZikDL is not in a full consumer-ready phase yet (but I am coming up with stuff that might change that soon enough!). It will not (yet) be as nice and polite to you as I would wish it to be.
echo:
echo:
echo remember you are installing a beta version of muZikDL.
echo The outcome might not be as good as expected.
echo:
echo ========================================================
pause

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
set appdirp=C:\Users\marni\AppData\Local\Programs\Marnix0810
7za X MuZikDL.zip -o"%appdirp%" -y
ren "%appdirp%\muZikDL-master" muZikDL

cls
echo installing Microsoft Visual C++ 2010 Redistributable Package...
start /wait "" "%appdir%\bin\Installer-only\vcredist_x86.exe" /install /quiet

cls
echo Creating shortcuts...
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%HOMEDRIVE%\Users\Public\Desktop\MuZikDL.lnk');$s.TargetPath='%appdir%\MuZikDL.cmd';$s.Save()"
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%appdata%\Microsoft\Windows\Start Menu\Programs\MuZikDL.lnk');$s.TargetPath='%appdir%\MuZikDL.cmd';$s.Save()"
setx path "%PATH%;%appdir%"

cls
echo Cleaning up installer files...
del /q /s "%randtmp%*"
del /q /s "%appdir%\bin\Installer-only\*"
del /q /s "%appdir%\%~nx0"
del /q /s "%appdir%\docs\*"
cd "%~dp0"
rd /s /q "%appdir%\docs"
rd /s /q "%appdir%\bin\Installer-only\"
rd /s /q "%randtmp%"
cls
Echo the installation of MuZikDL is finished.
start /min "" "https://marnix0810.github.io/muZikDL/License"
start cmd /c "%appdir%\MuZikDL.cmd"
exit