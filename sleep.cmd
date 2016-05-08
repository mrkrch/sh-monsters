@echo off
  setlocal enabledelayedexpansion
    set "i=0" % rem : only one argument should be specified
    for %%i in (%*) do set /a "i+=1"
    if %i% neq 1 goto:man
    
    (echo:%~1|>nul findstr /xrc:"[0-9].*")&&(
      if %~1 equ 0 goto:man
      set /a "s=%~1/2+1"
      w32tm /stripchart /computer:localhost /period:1^
        /dataonly /samples:!s!>nul
    )||(
      :man
      echo:Usage: %~n0 ^<seconds^>
    )
  endlocal
exit /b
