###sh-monsters
Various command line scenarios and tips.

#####Useful macros
######*Note: be sure that _NT_SYMBOL_PATH varibale is defined and debugging tools directory stored into PATH.*
```
[powershell.exe]
    dt=kd -z C:\Windows\System32\$1.dll -c "dt $1!_$2 $3;q" -r | sls -Pattern '\A\s+'
    sizeof=kd -z C:\Windows\System32\$1.dll -c "?? sizeof($1!_$2);? @`$exp;q" -r | sls -Pattern 'eval'


[cmd.exe]
    dt=kd -z C:\Windows\System32\$1.dll -c "dt $1!_$2 $3;q" | sed '/^0:000/,/^quit:/!d;//d'
    sizeof=kd -z C:\Windows\system32\$1.dll -c "?? sizeof($1!_$2);? @$exp;q" | findstr /birc:"eval"
```
