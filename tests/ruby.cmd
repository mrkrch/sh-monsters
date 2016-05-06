@echo off
  setlocal
    set "i=0"
    for %%i in (%*) do set /a "i+=1"
    if %i% lss 1 echo:An argument is required.&goto:eof
    echo:Start
    2>nul ruby -x "%~f0" %*
    echo:End
  endlocal
exit /b
#!ruby
ARGV.each do |i| puts i;end
