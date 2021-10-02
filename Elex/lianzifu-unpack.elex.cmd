@ECHO OFF
VERIFY OTHER 2>NUL
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
IF "%ERRORLEVEL%"=="0" GOTO BEGIN
ECHO.
ECHO This script requires command extensions and
ECHO delayed environment variable expansion [NT].
ECHO.
IF NOT "%1"=="--no-prompt" PAUSE
EXIT
:BEGIN
REM 'run as admin' and UNC paths require manually switching into the directory
PUSHD "%~dp0"

SET LIANZIFU_ARGS=--read-ini "data/ini/loc.ini"
REM load id name map files if present
FOR %%B IN ("%~dpn0*.csv") DO (
  ECHO # found idmap file ^(%%~nxB^)
  SET LIANZIFU_ARGS=!LIANZIFU_ARGS! --read-map "%%~nxB"
)
REM read (old) full string table if present
REM (to include Korean strings if kor.str is missing)
FOR %%B IN (data/compiled/localization/?_strings.bin) DO (
  ECHO # found full table ^(data/compiled/localization/%%~nxB^)
  SET LIANZIFU_ARGS=!LIANZIFU_ARGS! --read-bin "data/compiled/localization/%%~nxB"
)
REM read (new) language specific string tables if present
FOR %%L IN (de en fr it sp pl ru cz ch kor) DO (
  IF EXIST "data/compiled/localization/%%L.str" (
    ECHO # found lang table ^(data/compiled/localization/%%L.str^)
    SET LIANZIFU_ARGS=!LIANZIFU_ARGS! --read-bin "data/compiled/localization/%%L.str"
  )
)

IF NOT "%1"=="--no-prompt" (
  ECHO.
  ECHO Existing data/raw/strings/*.csv will be overridden!
  ECHO -----  press [Ctrl+C] to cancel this script  -----
  ECHO.
  PAUSE
)

ECHO running lianzifu...
lianzifu.exe %LIANZIFU_ARGS% --save-csv --exit 1> "%~dpn0.log" 2>&1

SET /A EXITCODE="%ERRORLEVEL%"
IF NOT "%EXITCODE%"=="0" (
  TYPE "%~dpn0.log"
  IF NOT "%1"=="--no-prompt" PAUSE
)
POPD
ENDLOCAL && EXIT /B %EXITCODE%
