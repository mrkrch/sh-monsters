@echo off
  for %%i in (certutil.exe) do (
    if not exist "%%~$PATH:i" goto:err
  )
  setlocal enabledelayedexpansion
    set "i=0"
    for %%i in (%*) do set /a "i+=1"
    if !i! equ 1 (
      call:sum "%~1"
      goto:eof
    )
    if !i! equ 2 (
      call:sum "%~1" "%~2"
      goto:eof
    )
    goto:man
  endlocal
exit /b

:err
  echo:Certutil has not been found.
exit /b

:man
  for %%i in (
    "Usage: %~n0 file [algorithm]"
    ""
    "Default algorithm is sha256."
    "Supported algorithms are md2, md4, md5,"
    "sha1, sha256, sha384 and sha512."
    ""
    "Note: this one was written and tested"
    "on Windows 7."
  ) do echo:%%~i
exit /b

:sum
  if not exist "%~1" goto:man
  if "%~2" equ "" (
    set "alg=SHA256"
  ) else (
    for /f "tokens=2 delims=:" %%i in (
      '2^>^&1 find "" %~2'
    ) do set "alg=%%i"
  )
  set "alg=!alg: =!"
  for /f "skip=1 delims=" %%i in (
    'certutil -hashfile "%~1" !alg!^
    ^| findstr /virc:"certutil"'
  ) do set "hash=%%i"
  if /i "!hash!" equ "" (
    echo:=^>err
  ) else (echo !hash: =!)
exit /b
