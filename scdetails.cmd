@goto:start
  Geting VirusTotal report for a file.
  Dependencies:
      curl.exe     - https://github.com/curl/curl
      jq.exe       - https://github.com/stedolan/jq
      sigcheck.exe - https://live.sysinternals.com/
  Notes:
      https://curl.haxx.se/ca/cacert.pem
:start
@echo off
  setlocal enabledelayedexpansion
    set "i=0"
    for %%i in (%*) do set "i+=1"
    if %i% neq 1 if not exist "%~f1" (
      echo:Probably index out of range or file not found.
      goto:eof
    )
    for /f "delims=" %%i in (
      'sigcheck -nobanner -h -v "%~f1"^
       ^| findstr /ir /c:"sha256" /c:"vt link"'
    ) do (
      echo:%%i|>nul findstr /irc:"sha256"&&(
        set "sum=%%i"
        for /f "tokens=2" %%j in ("!sum!") do set "sum=%%j"
      )||(
        set "lnk=%%i"
        for /f "tokens=3" %%j in ("!lnk!") do set "lnk=%%j"
      )
    )
    if /i "!lnk!" equ "n/a" (
      set /p "a=The file has not been scanned. Scan? (y/n) "
      if /i "!a!" equ "n" goto:eof
      sigcheck -nobanner -vs "%~f1"&goto:eof
    )
    curl --cacert C:\ca\cacert.pem --ssl -s -X POST^
    "https://www.virustotal.com/vtapi/v2/file/report"^
    --form apikey="4e3202fdbe953d628f650229af5b3eb49cd46b2d3bfe5546ae3c5fa48b554e0c"^
    --form resource="!sum!" | jq ".scans"
  endlocal
exit /b
