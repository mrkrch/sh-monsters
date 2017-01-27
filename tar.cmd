@echo off
  setlocal enabledelayedexpansion
    set "i=0" % rem : only two parameters should be specified
    for %%i in (%*) do set /a "i+=1"
    if !i! neq 2 goto:man
    echo:%~1|>nul findstr /irc:"[lx]"&&(
      set "arc=%2" % rem : get full path and name for an archive
      for /f "delims=" %%i in ("!arc!") do (
        set "fp=%%~fi"&set "fn=%%~nxi"
      )
    )||goto:man
    :: check that specified file does exist
    if not exist "!fp!" echo:=^>err (file not found^)&goto:eof
    :: construct destination folder name, check extension(s)
    set "i=0" % rem : chunks number of the name
    for %%i in ("!fn:.=";"!") do set "arr.!i!=%%~i"&set /a "i+=1"
    set /a "y=!i!-2", "x=!i!-1"
    for /f "tokens=2 delims==" %%i in ('set arr.!x!') do (
      echo:%%i|>nul findstr /i "bz2 gz lzma tar xz"&&(
        set arr.!y!|>nul findstr /irc:"\=tar"&&(
          7za x "!fp!" -so | 7za %~1 -si -ttar -bd
        )||7za %~1 "!fp!" -t%%i -bd
      )||echo:=^>err (unknown extension^)
    )
  endlocal
exit /b

:man
  for %%i in (
    "%~n0 v1.01 - extracts files from tarballs"
    "Dependencies: 7za.exe"
    ""
    "Usage: %~n0 [l|x] <tarball>"
    "   l  print files list in tarball"
    "   x  extract files from tarball"
    ""
    ".e.g.: %~n0 x \src\curl-7.52.1.tar.lzma"
    ""
    "Suffixes:"
    "   .tar.bz2 | .tar.gz | .tar.lzma | .tar.xz"
  ) do echo:%%~i
exit /b
