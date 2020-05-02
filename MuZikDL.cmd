@echo off
title muZikDL
if not exist "%appdata%\Marnix0810\MuZikDL\downloadlist.txt" (
echo no files in download qeue.
start cmd /c "%~dp0Scripts\add_music_to_the_list.cmd"
exit
)
title muZikDL - Download processor
md "%~dp0tmp"
cd /d "%~dp0tmp"
copy "%appdata%\Marnix0810\MuZikDL\downloadlist.txt" "%~dp0tmp" /y
del "%appdata%\Marnix0810\MuZikDL\downloadlist.txt"
cls
for /r %%F in (downloadlist.txt) do if %%~zF==0 (
del /f /q downloadlist.txt
echo no files in download qeue.
start cmd /c "%~dp0Scripts\add_music_to_the_list.cmd"
goto bye
)
:dl
echo list of downloads:
type downloadlist.txt
cls
call "%~dp0bin\youtube-dl.exe" --batch-file downloadlist.txt --extract-audio --audio-format mp3 -k || (
call "%~dp0bin\youtube-dl.exe" --rm-cache-dir
cls
echo there has been an error downloading this list.
echo Press a key to retry or close to stop trying.
echo If you wait for some time, it might help.
pause
goto dl
)
del "%tmp%\Marnix0810\MuZikDL\output\*" /S /Q
rd /S /Q "%tmp%\Marnix0810\MuZikDL\output\"
md "%tmp%\Marnix0810\MuZikDL\output\Audio"
md "%tmp%\Marnix0810\MuZikDL\output\Video"
del /f /q downloadlist.txt
del /f /q *.temp.*
move /y *.mp4 "%tmp%\Marnix0810\MuZikDL\output\Video"
move /y *.webm "%tmp%\Marnix0810\MuZikDL\output\Video"
move /y *.mkv "%tmp%\Marnix0810\MuZikDL\output\Video"
move /y *.mp3 "%tmp%\Marnix0810\MuZikDL\output\Audio"
del /f /q *.*
echo done
start explorer "%tmp%\Marnix0810\MuZikDL\output"
:bye
cd /d "%~dp0"
rd "%~dp0tmp"
exit
