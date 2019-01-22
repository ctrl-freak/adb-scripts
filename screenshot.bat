@echo off

if [%1]==[/?] goto usage

for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /format:list') do @set datetime=%%I
set datetime=%datetime:~0,8%-%datetime:~8,6%
set filename=screen_%datetime%.png

adb -d shell screencap -p /sdcard/%filename%
adb -d pull /sdcard/%filename%
adb -d shell rm /sdcard/%filename%
goto :eof

:usage
echo Takes screenshots via ADB and pulls them to a file with the current time.
echo.
echo Usage: %0 [filename]
exit /B 1