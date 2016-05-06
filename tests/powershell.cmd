<# :
  @echo off
    setlocal
      set "i=0"
      for %%i in (%*) do set /a "i+=1"
      if %i% lss 1 echo:An argument is required.&goto:eof
      echo:Start
      powershell /noprofile /executionpolicy bypass^
      "&{[ScriptBlock]::Create((gc '%~f0') -join [Char]10).Invoke(@(&{$args}%*))}"
      echo:End
    endlocal
  exit /b
#>
$args | ForEach-Object {$_}
