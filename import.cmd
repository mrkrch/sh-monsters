@echo off
  setlocal enabledelayedexpansion
    set "i=0" % rem : number of parameters
    for %%i in (%*) do set /a "i+=1"
    if "!i!" neq "2" goto:man
    
    echo:%~1|>nul findstr /irc:"^[-|/][a|r]$"&&(
      set "par=%~1" % rem : add or remove parameter
      if "!par:~1,1!" equ "a" (
        for /f "tokens=1,* delims==" %%i in (
          'findstr /birc:"%~2=" "%~f0"'
        ) do (
          set "c=%%j" % rem : macro or commands
          if "!c:~0,1!" equ ":" goto%%j
          doskey %%i=%%j
        )
      )
      if "!par:~1,1!" equ "r" (doskey %~2=)
    )||(
      :man
      for %%i in (
        "Usage: %~n0 [-a|-r] <macro>"
        "  -a  add macro"
        "  -r  remove macro"
        ""
        "Next macro has been defined:"
      ) do echo:%%~i
      for /f "delims==" %%i in (
        'findstr /birc:"[a-z].*=" "%~f0"'
      ) do <nul set /p "=%%i "
    )
  endlocal
exit /b

:macro
alias=doskey /macros:all
bash=:cyg_bash
csc=:dotnet_csharp
fxcop=:LocateFxCopPath
dt=:dbg_dt
h=doskey /history | findstr /nirc:"[0-9a-z]" | more
ilasm=:dotnet_ilasm
j=explorer /n,$*
jsc=:dotnet_jscriptnet
list=:dbg_list
lock=rundll32 user32.dll,LockWorkStation
ping=ping -n 10000 $1 | findstr /irc:"ttl"
ps=:dbg_ps
run=rundll32 shell32.dll,ShellExec_RunDLL $*
sizeof=:dbg_sizeof
sleep=rundll32 powrprof.dll,SetSuspendState Sleep
vbc=:dotnet_vbnet
wget=:cyg_wget
which=for %i in (%pathext%;.DLL;.CPL;.MSC) do @for %j in ($1%i) do @if exist "%~$PATH:j" @echo:%~$PATH:j

:LocateCygwinPath
  set "key=HKLM\SOFTWARE\Cygwin\Setup"
  :cygrepeat
    for /f "tokens=2,*" %%i in (
      '2^>nul reg query %key% ^| findstr /irc:"rootdir"'
    ) do set "root=%%~j"
    if "%root%" equ "" if "%key:~2,2%" equ "LM" (
      set "key=%key:LM=CU%"&goto:cygrepeat
    ) else if "%root%" equ "" goto:eof
    set "root=%root%\bin"
    if "%1" equ "bash" (
      doskey %1=start "Bash" "%root%\bash.exe" --login -i
    )
    if "%1" equ "wget" (
      if exist "%root%\wget.exe" doskey %1="%root%\wget.exe" $*
    )
exit /b

:LocateDebuggingTools
  for /f "delims=" %%i in (
    '2^>nul dir /b/s "%allusersprofile%\windbg.lnk"'
  ) do set "lnk=%%~i"
  if "%lnk%" equ "" goto:eof
  for /f "delims=" %%i in (
    'find "\" ^< "%lnk%"^|findstr /irc:"^[a-z].*exe$"'
  ) do set "kd=%%~i"
  set "kd=%kd:windbg=kd%"
  if "%1" equ "dt" (
    doskey %1="%kd%" -z "%comspec:cmd.exe=%$1.dll" -c "dt $1^!_$2 $3;q" -r -snc ^| findstr /brc:" "
  )
  if "%1" equ "list" (
    doskey %1="%kd:kd=list%" $*
  )
  if "%1" equ "ps" (
    doskey %1="%kd:kd=tlist%" -t
  )
  if "%1" equ "sizeof" (
    doskey %1="%kd%" -z "%comspec:cmd.exe=%$1.dll" -c "?? sizeof($1^!_$2);? @$exp;q" ^| findstr /birc:"eval"
  )
exit /b

:LocateDotNetFramework
  set "key=HKLM\SOFTWARE\Microsoft\.NETFramework"
  for /f "tokens=2,*" %%i in (
    '2^>nul reg query %key% /v InstallRoot'
  ) do (
    if "%%j" equ "" goto:eof
    for /f %%k in ('2^>nul dir /ad/b %%j') do (
      if exist "%%j%%k\%1.exe" (
        doskey %1="%%j%%k\%1.exe" /nologo $*
      )
    )
  )
exit /b

:LocateFxCopPath
  2>nul 1>nul assoc .fxcop||goto:eof
  for /f "tokens=2 delims==" %%i in (
    'assoc .fxcop'
  ) do (
    for /f delims^=^"^ tokens^=2 %%j in (
      'ftype %%i'
    ) do set "fxcop=%%j"
  )
  set "fxcop=%fxcop:.exe=Cmd.exe%"
  shift
  doskey %1="%fxcop%" /c /q /f:$1
exit /b

:cyg_bash
  call:LocateCygwinPath bash
exit /b

:cyg_wget
  call:LocateCygwinPath wget
exit /b

:dbg_dt
  call:LocateDebuggingTools dt
exit /b

:dbg_list
  call:LocateDebuggingTools list
exit /b

:dbg_ps
  call:LocateDebuggingTools ps
exit /b

:dbg_sizeof
  call:LocateDebuggingTools sizeof
exit /b

:dotnet_csharp
  call:LocateDotNetFramework csc
exit /b

:dotnet_ilasm
  call:LocateDotNetFramework ilasm
exit /b

:dotnet_jscriptnet
  call:LocateDotNetFramework jsc
exit /b

:dotnet_vbnet
  call:LocateDotNetFramework vbc
exit /b
