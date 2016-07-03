@echo off
  call:env
  setlocal
    call:which kd
    if /i "%mod%" equ "" (
      echo:Debugging tools has not been found.
      goto:eof
    )
    if /i "%~1" equ "" (
      echo:Target module has not been specified.
      goto:eof
    )
    set "mod=" % rem : clear module data
    call:which %~1
    if /i "%mod%" equ "" (
      echo:Specified module does not exist.
      goto:eof
    )
    kd -z "%mod%" -r -snc
  endlocal
exit /b

:env
  setlocal
    call:which kd
    if /i "%mod%" equ "" (
      for /f "delims=" %%i in (
        'dir "%allusersprofile%\windbg.lnk" /s/b'
      ) do (
        if /i "%%i" equ "" (
          echo:Could not find debugging tools path.
          goto:eof
        )
        for /f "delims=" %%j in (
          'find "\" ^<"%%i"^|findstr /erc:".exe"'
        ) do set "dbg=%%j"
      )
    ) else ( goto:eof )
    set "path=%path%;%dbg:\windbg.exe=%"
  endlocal&set "path=%path%"
exit /b

:which
  for %%i in (.EXE;.COM;.DLL;.SYS;.CPL) do (
    for %%j in (%1%%i) do (
      if exist "%%~$PATH:j" set "mod=%%~$PATH:j"
    )
  )
exit /b
