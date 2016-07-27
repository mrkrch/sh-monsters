###sh-monsters
Various command line scenarios and tips.

#####Useful macros
######*Note: be sure that _NT_SYMBOL_PATH varibale is defined and debugging tools directory stored into PATH.*
```
[powershell.exe]
    dt=kd -z C:\Windows\System32\$1.dll -c "dt $1!_$2 $3;q" -r | sls -Pattern '\A\s+'
    sizeof=kd -z C:\Windows\System32\$1.dll -c "?? sizeof($1!_$2);? @`$exp;q" -r | sls -Pattern 'eval'
    hex='0x{0:X}' -f $1
    macro=doskey /exename=powershell.exe /macros


[cmd.exe]
    dt=kd -z C:\Windows\System32\$1.dll -c "dt $1!_$2 $3;q" | findstr /brc:" "
    sizeof=kd -z C:\Windows\System32\$1.dll -c "?? sizeof($1!_$2);? @$exp;q" | findstr /birc:"eval"
    hex=cmd /c exit /b $1&cmd /v/c echo 0x!=exitcode!
    macro=doskey /macros
```
