@echo off
color 97
echo ENTER MUSIC URLs followed by control+z^&enter on blank line: 
echo:
TYPE CON >>"%~dp0..\data\downloadlist.txt"
xcopy "%~dp0..\Scripts\jsort.bat" "%~dp0"
type "%~dp0..\data\downloadlist.txt" > "%~dp0downloadlist.txt"
call jsort.bat downloadlist.txt /u >downloadlist.txt.new
del "%~dp0downloadlist.txt"
type downloadlist.txt.new > "%~dp0..\data\downloadlist.txt"
del "%~dp0downloadlist.txt.new"
del jsort.bat
start cmd /c "%~dp0..\MuZikDL.cmd"