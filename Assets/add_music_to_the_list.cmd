@echo off
title muZikDL - Add music to the download list
color 97
cd /d "%~dp0"
md %appdata%\Marnix0810\MuZikDL\
echo ENTER MUSIC URLs followed by control+z^&enter on blank line: 
echo:
TYPE CON >> "%appdata%\Marnix0810\MuZikDL\downloadlist.txt"
xcopy /y "%~dp0..\Scripts\jsort.bat" "%~dp0"
type "%appdata%\Marnix0810\MuZikDL\downloadlist.txt" > "%~dp0downloadlist.txt"
call jsort.bat downloadlist.txt /u >downloadlist.txt.new
del "%~dp0downloadlist.txt"
type downloadlist.txt.new > "%appdata%\Marnix0810\MuZikDL\downloadlist.txt"
del "%~dp0downloadlist.txt.new"
del jsort.bat
start cmd /c "%~dp0..\MuZikDL.cmd"