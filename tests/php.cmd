:<?php /*
@echo off
  setlocal
    set "i=0"
    for %%i in (%*) do set /a "i+=1"
    if %i% lss 1 echo:An argument is required.&goto:eof
    echo:Start
    2>nul php "%~f0" %*
    echo:End
  endlocal
exit /b
*/
echo "\r";

foreach (array_slice($argv, 1, count($argv)) as $i) echo "$i\n";
?>
