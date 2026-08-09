@echo off
setlocal EnableExtensions
setlocal DisableDelayedExpansion

:: Set window size and title
mode 76, 30
title  SI Menu

:: Detect ANSI / VT support (Windows 10 1511+)
set _NCS=0
for /f "tokens=4-5 delims=. " %%i in ('ver') do (
    if %%i GEQ 10 if %%j GEQ 0 set _NCS=1
)

:: Build ESC character for ANSI color codes
for /f %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

set "_Green=32"
set "_White=37"
set "_Cyan=36"
set "_Yellow=33"

goto :MainMenu

::========================================================================
:MainMenu
cls
color 07
title  SI Menu

echo:
echo:
echo:       ___________________________________________________________
echo:
call :PrintColor %_Cyan%  "             SI Menu"
echo:       ___________________________________________________________
echo:
call :PrintColor %_Green% "             [1] Intune Autopilot Enrollment"
echo:
call :PrintColor %_Green% "             [2] Rename Computer Request via TG"
echo:
call :PrintColor %_Green% "             [3] No Sleep (PS)"
echo:
call :PrintColor %_Green% "             [4] No Sleep (Edge)"
echo:       ___________________________________________________________
echo:
echo:             [0] Exit
echo:       ___________________________________________________________
echo:
call :PrintColor %_Yellow% "         Choose an option using your keyboard [1,2,3,4,0] :"

choice /C:12340 /N
set _erl=%errorlevel%

if %_erl%==5 exit /b
if %_erl%==4 setlocal & call :RunNoSleepWeb & endlocal & goto :MainMenu
if %_erl%==3 setlocal & call :RunNoSleep    & endlocal & goto :MainMenu
if %_erl%==2 setlocal & call :RunRename     & endlocal & goto :MainMenu
if %_erl%==1 setlocal & call :RunAutopilot  & endlocal & goto :MainMenu

goto :MainMenu

::========================================================================
:RunAutopilot
cls
echo:
call :PrintColor %_Cyan% "  [*] Starting Intune Autopilot Enrollment..."
echo:
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://leonchanyc.github.io/shioobe/ | iex"
echo:
call :PrintColor %_Yellow% "  Press any key to return to menu..."
pause >nul
exit /b

::========================================================================
:RunRename
cls
echo:
call :PrintColor %_Cyan% "  [*] Starting Rename Computer..."
echo:
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://leonchanyc.github.io/shirename/ | iex"
echo:
call :PrintColor %_Yellow% "  Press any key to return to menu..."
pause >nul
exit /b

::========================================================================
:RunNoSleep
cls
echo:
call :PrintColor %_Cyan% "  [*] Starting No Sleep..."
echo:
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://leonchanyc.github.io/nosleepps/index.html | iex"
echo:
call :PrintColor %_Yellow% "  Press any key to return to menu..."
pause >nul
exit /b

::========================================================================
:RunNoSleepWeb
cls
echo:
call :PrintColor %_Cyan% "  [*] Opening No Sleep (Web) in Edge..."
echo:
start "" msedge "https://nosleep.page"
echo:
call :PrintColor %_Yellow% "  Press any key to return to menu..."
pause >nul
exit /b

::========================================================================
:PrintColor
:: Usage: call :PrintColor <color_code> "text"
if not "%_NCS%"=="1" goto :PrintColor_plain
setlocal EnableDelayedExpansion
echo !ESC![%~1m%~2!ESC![0m
endlocal
exit /b
:PrintColor_plain
echo %~2
exit /b
