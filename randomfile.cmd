@echo off
  setlocal enabledelayedexpansion
    call:rndstring 10 uppercase
    call:rndextension
    2>nul cd.>%str%%ext%
  endlocal
exit /b

:rndextension
  set "i=0" % rem : array indexator
  for /f "tokens=1 delims==" %%i in ('assoc') do (
    set "ext.!i!=%%i" % rem : filling array
    set /a "i+=1"
  )
  :retry
    set /a "r=!random!%%!i!"
    if !r! gtr !i! goto:retry
  set "ext=!ext.%r%!"
exit /b

:rndstring
  set "map=abcdefghijklmnopqrstuvwxyz0123456789"
  set "i=1"  % rem : string length counter
  rem if it requires to generate more than one
  rem string then previous !str! should be deleted
  set "str="
  :repeat
    set /a "r=!random!%%36"
    set "str=!str!!map:~%r%,1!" % rem : filling
    if !i! neq %~1 set /a "i+=1"&goto:repeat
  if "%~2" equ "uppercase" (
    for /f "tokens=3 delims=:" %%i in (
      '2^>^&1 find "" ":!str!"'
    ) do set "str=%%i"
  )
exit /b
