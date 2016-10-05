@echo off
  setlocal enabledelayedexpansion
    set "hklm=HKLM" % rem : common folders
    set "hkcu=HKCU" % rem : personal folders
    set "key=\Software\Microsoft\Windows\CurrentVersion"
    set "key=%key%\Explorer\Shell Folders"
    
    set "i=0" % rem : array index
    call:getnames %hklm% %i%
    call:getnames %hkcu% %i%
    
    set "i=0" % rem : number of parameters
    for %%i in (%*) do set /a "i+=1"
    if !i! neq 1 goto:man
    
    set "i=0" % rem : number of possible matches
    for /f "tokens=1,* delims==" %%i in (
      'set arr ^| findstr /irc:"=%~1"'
    ) do (
      set "map=!map!%%~j..."
      set /a "i+=1"
    )
    set "map=!map:~,-3!"
    if /i "!map!" equ "~,-3" goto:man
    if !i! neq 1 echo !map!&goto:eof
    rundll32 shell32.dll,ShellExec_RunDLL "shell:!map:.=!"
  endlocal
exit /b

:getnames
  set "i=%2"
  for /f "tokens=1,2" %%i in (
    'reg query "%1!key!" ^| findstr /irc:"reg_sz"'
  ) do (
    if /i "%%j" equ "reg_sz" (
      set "arr.!i!=%%i"
    ) else (
      set "arr.!i!=%%i %%j"
    )
    set /a "i+=1"
  )
exit /b

:man
  set "map=" % rem : flush wrong pattern
  for %%i in (
    "%~n0 v1.00 - jumper to the shell folders"
    "Usage: %~n0 [path name]"
    ""
    "Example 1:"
    "   C:\> %~n0 d"
    "This command opens Desktop folder."
    ""
    "Example 2:"
    "   C:\> %~n0 ``common p''"
    "Jumps to Common Programs folder."
    ""
    "The next paths are available on this system:"
  ) do echo:%%~i
  for /f "tokens=1,* delims==" %%i in ('set arr') do (
    set "map=!map!%%j..."
  )
  echo !map:~,-3!
exit /b
