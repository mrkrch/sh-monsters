###sh-monsters
Various command line scenarios and tips.

#####Useful macros
######*Note: be sure that _NT_SYMBOL_PATH varibale is defined and debugging tools directory stored into PATH.*
```
[cmd.exe]
    dt=kd -z C:\Windows\System32\$1.dll -c "dt $1!_$2;q" | sed '/^0:000/,/^quit:/!d;//d'
```
