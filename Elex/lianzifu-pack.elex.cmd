@ECHO OFF
ECHO Packing Elex (Windows 64-bit) string table...

CD /D "%~dp0"
lianzifu.exe ^
--read-ini "data/ini/loc.ini" ^
--read-csv ^
--save-bin x64 7 "data/compiled/localization/en.str" ^
--exit 1> "%~dpn0.log" 2>&1

IF ERRORLEVEL 1 (
TYPE "%~dpn0.log"
PAUSE
)