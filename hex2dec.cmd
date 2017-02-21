@echo off
  if /i "%~1" equ "" if not defined run goto:box
  setlocal enabledelayedexpansion
    set "i=0"
    for %%i in (%*) do set /a "i+=1"
    if "!i!" neq "1" goto:err
    
    2>&1 echo:%~1|>nul findstr /irc:"[a-f,x]"&&(
      2>nul (set /a "nil=0%~1"||set /a "nil=0x%~1")&&echo:!nil!||goto:err
    )||(
      echo:%~1|>nul findstr /irc:"[g-w,y,z]"&&goto:err
      cmd /c exit /b %~1& echo 0x!=exitcode!
    )
  endlocal
exit /b

:err
  echo:=^>err
exit /b

:box
  for %%i in (
    "%~n0 v5.23 - converts hex to decimal and vice versa"
    "[Enter .c to clear output data or .q to exit]"
    ""
  ) do echo:%%~i
  setlocal
    set "run=true"
    :repeat
      set /p "i=>>> "
      cmd /c "%~f0" %i%
      if /i "%i%" equ ".c" cls
      if /i "%i%" equ ".q" goto:eof
      goto:repeat
  endlocal
exit /b
