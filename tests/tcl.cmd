::set comment {
  @echo off
    setlocal
      set "i=0"
      for %%i in (%*) do set /a "i+=1"
      if %i% lss 1 echo:An argument is required.&goto:eof
      echo:Start
      2>nul tclsh86t "%~f0" %*
      echo:End
    endlocal
  exit /b
}
foreach arg $argv { puts $arg }
