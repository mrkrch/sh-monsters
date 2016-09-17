:: --[[
  @echo off
    setlocal
      set "i=0"
      for %%i in (%*) do set /a "i+=1"
      if %i% lss 1 echo:An argument is required.&goto:eof
      echo:Start
      2>nul lua.exe "%~f0" %*
      echo:End
    endlocal
  exit /b
--]]
set ::
for i, j in ipairs(arg) do print(j) end
