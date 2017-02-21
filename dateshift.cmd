@echo off
  setlocal
    call:dateshift 1 day
    echo:Tomorrow  : %day%
    call:dateshift 1 day past
    echo:Yesterday : %day%
  endlocal
exit /b

:dateshift
  set "s=mshta vbscript:Execute("CreateObject("
  set "s=%s%""Scripting.FileSystemObject"")"
  set "s=%s%.GetStandardStream(1).Write("
  set ^"e=):Close"^)"
  set "op=+"
  if /i "%~3" equ "past" set "op=-"
  for /f %%# in ('%s% Date%op%%1 %e%') do set "%2=%%#"
exit /b
