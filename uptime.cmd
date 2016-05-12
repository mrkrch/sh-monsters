@echo off
  setlocal enabledelayedexpansion
    for %%i in (lodctr.exe) do (
      if not exist "%%~$PATH:i" (
        echo:Could not retrieve system up time.
        goto:eof
      )
    )
    set "pc=%tmp%\perf.tmp" % rem : performance counters list
    lodctr /s:%pc%
    call:findlocalestr 2   object
    call:findlocalestr 674 counter
    for /f delims^=^"^ tokens^=3 %%i in (
      'typeperf "%object%%counter%" -sc 1 ^| findstr /rc:":"'
    ) do 2>nul set /a "s=%%i" % rem : total seconds
    set /a "ss=s%%60", "s/=60", "mm=s%%60", "s/=60", "hh=s%%24", "dd=s/24"
    for %%i in (%hh% %mm% %ss%) do (
      if %%i lss 10 (set "t=!t!0%%i:") else (set "t=!t!%%i:")
    )
    echo:%dd%.%t:~,-1%
    del /f /q "%pc%"
  endlocal
exit /b

:findlocalestr
for /f "tokens=2 delims==" %%i in (
  'find "%~1=" "%pc%" ^| findstr /brc:"%~1="'
) do set "%2=\%%i"
exit /b
