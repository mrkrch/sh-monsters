@echo off
  setlocal enabledelayedexpansion
    set "i=0" % rem : number of arguments
    for %%i in (%*) do set /a "i+=1"
    if !i! neq 2 goto:man
    :: checking dependencies
    for %%i in (curl openssl sqlite3) do (
      for %%j in (%%i.exe) do if not exist "%%~$PATH:j" (
        echo:%%i has not been found.
        goto:eof
      )
    )
    :: checking existence of vtkey.db
    set "db=%~dp0vtkey.db"
    if not exist "%db%" (
      echo:VirusTotal's public keys database has not been found.
      goto:eof
    )
    :: parsing arguments
    echo:%~1|>nul findstr /irc:"[-|/][d|f|h|i|u]"&&(
      set "par=%~1" % rem : action pointer
      set "par=!par:~1,1!" % rem : remove delimiter
      set "url=https://www.virustotal.com/vtapi/v2/%%/report"
      :: get random api key
      set "sql=SELECT key FROM vtkey ORDER BY RANDOM() LIMIT 1;"
      for /f %%i in ('echo !sql! ^| sqlite3 "%db%"') do (
        rem set "key=apikey=%%i"
        set "arg=-s --url !url! -d apikey=%%i -d"
      )
      if "!par!" equ "d" curl -G !arg:%%=domain! domain=%2
      if "!par!" equ "f" (
        if not exist "%~2" (
          echo:%~2 has not been found.
          goto:eof
        )
        for /f %%i in ('openssl dgst -r -sha256 "%~2"') do (
          curl -X POST !arg:%%=file! resource=%%i
        )
      )
      if "!par!" equ "h" curl -X POST !arg:%%=file! resource=%~2
      if "!par!" equ "i" curl -G !arg:%%=ip-address! ip=%~2
      if "!par!" equ "u" curl -X POST !arg:%%=url! resource=%~2
    )||goto:man
  endlocal
exit /b

:man
  for %%i in (
    "%~n0 - getting VirusTotal report"
    "Usage: %~n0 [-d|-f|-h|-i|-u] <resource>"
    "   -d  domain"
    "   -f  file"
    "   -h  hash (of file)"
    "   -i  IP address"
    "   -u  URL"
    ""
    "Related links:"
    "   https://curl.haxx.se/"
    "   https://curl.haxx.se/docs/caextract.html"
    "   https://www.openssl.org/"
    "   https://sqlite.org/"
    "   https://virustotal.com/"
  ) do echo:%%~i
exit /b
