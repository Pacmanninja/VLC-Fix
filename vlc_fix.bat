@echo off
setlocal EnableExtensions

rem Find VLC's installer-recorded location, regardless of drive or custom folder.
set "VLC_DIR="

rem Standard 64-bit uninstall registry location.
for /f "tokens=2,*" %%A in ('
    reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\VLC media player" /v "InstallLocation" 2^>nul ^| find /i "InstallLocation"
') do set "VLC_DIR=%%B"

rem 32-bit VLC on a 64-bit Windows system.
if not defined VLC_DIR (
    for /f "tokens=2,*" %%A in ('
        reg query "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\VLC media player" /v "InstallLocation" 2^>nul ^| find /i "InstallLocation"
    ') do set "VLC_DIR=%%B"
)

if not defined VLC_DIR (
    echo ERROR: Could not find VLC's installation folder in the registry.
    echo.
    echo This can happen if VLC is a portable/manual installation
    echo rather than an installer-based installation.
    pause
    exit /b 1
)

rem Remove a possible trailing slash from InstallLocation.
if "%VLC_DIR:~-1%"=="\" set "VLC_DIR=%VLC_DIR:~0,-1%"

set "VLC_EXE=%VLC_DIR%\vlc.exe"

if not exist "%VLC_EXE%" (
    echo ERROR: Registry reported this VLC folder:
    echo "%VLC_DIR%"
    echo.
    echo But vlc.exe was not found there.
    pause
    exit /b 1
)

echo VLC found at:
echo "%VLC_EXE%"
echo.
echo Resetting VLC configuration and plugin cache...
echo This removes your VLC preferences and custom settings.
echo.

"%VLC_EXE%" --reset-plugins-cache vlc://quit
set "EXITCODE=%ERRORLEVEL%"

echo.
if "%EXITCODE%"=="0" (
    echo VLC reset command completed.
) else (
    echo VLC returned exit code %EXITCODE%.
)

pause
exit /b %EXITCODE%
