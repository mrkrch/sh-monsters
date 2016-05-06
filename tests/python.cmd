1>2# : ^
'''
@echo off
  setlocal
    set "i=0"
    for %%i in (%*) do set /a "i+=1"
    if %i% lss 1 echo:An arguments is required.&goto:eof
    echo:Start
    2>nul python3.4m "%~f0" %*
    echo:End
  endlocal
exit /b
'''
from sys import argv
for i in range(1, len(argv)): print(i)
