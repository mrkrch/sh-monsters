@echo off
  for /f "tokens=2 delims=][." %%i in ('ver') do (
    for /f "tokens=2" %%j in ("%%i") do (
      if %%j lss 6 (
        echo:This requires Vista or above.
        goto:eof
      )
    )
  )
  setlocal enabledelayedexpansion
    set "i=0"
    for %%i in (%*) do set /a "i+=1"
    if !i! neq 1 goto:man
    
    set "arg=%~1"
    if "!arg:~0,1!" neq "-" if "!arg:~0,1!" neq "/" goto:man
    if /i "!arg:~1!" equ "mount" (
      call:secureinput "User"
      echo.
      call:secureinput "Pass"
      echo.
      net use * https://webdav.yandex.com !pass!^
      /user:!user!@yandex.ru /persistent:yes
      goto:eof
    )
    if /i "!arg:~1!" equ "unmount" (
      for /f "tokens=1" %%i in (
        'net use ^| findstr /irc:"yandex"'
      ) do net use %%i /delete
      goto:eof
    )
    goto:man
  endlocal
exit /b

:man
  for %%i in (
    "Usage: %~n0 [action]"
    "Where <action> is one of the next:"
    "   mount or unmount"
    ""
    "Example 1:"
    "   C:\bin> %~n0 -mount"
    ""
    "Note that while entering a user name and"
    "password both values are not displayed on"
    "the screen."
    ""
    "Example 2:"
    "   C:\bin> %~n0 -unmount"
  ) do echo:%%~i
exit /b

:secureinput
  <nul set /p "%~1=%~1: "
  for /f %%i in (
    '"prompt;$H&for %%i in (1) do rem"'
  ) do set "$=%%i"
  :repeat
    set "c="
    for /f "delims=" %%i in (
      '2^>nul xcopy /l /w "%~f0" "%~f0"'
    ) do if not defined c set "c=%%i"
    set "c=%c:~-1%"
    if not defined c goto:end
    if !$! equ !c! (
      <nul set /p "=!$! !$!"
      set "c="
      if defined %~1 set "%~1=!%~1:~0,-1!"
    ) else <nul set /p "="
    if not defined %~1 (
      set "%~1=!c!"
    ) else for /f delims^=^ eol^= %%i in ("!%~1!") do (
      set "%~1=%%i!c!"
    )
    goto:repeat
  :end
exit /b
