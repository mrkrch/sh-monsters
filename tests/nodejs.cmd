0</* :
@echo off
  setlocal
    set "i=0"
    for %%i in (%*) do set /a "i+=1"
    if %i% lss 1 echo:An argument is required.&goto:eof
    echo:Start
    2>nul node "%~f0" %*
    echo:End
  endlocal
exit /b */0;

process.argv.slice(2).forEach(function(val) {
  console.log(val);
});
