@echo off
title preparing muZikDL for first usage.
cls
echo installing Microsoft Visual C++ 2010 Redistributable Package...
start /wait "" "%~dp0bin\vcredist_x86.exe" /install /quiet
:d
cls
echo All done!
