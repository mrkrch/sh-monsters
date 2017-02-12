###sh-monsters
Various command line scenarios and tips.

#####Useful macros
######*Note: be sure that _NT_SYMBOL_PATH varibale is defined and tools directories stored into PATH.*
```
[cmd.exe]
    dt=kd -z C:\Windows\System32\$1.dll -c "dt $1!_$2 $3;q" | findstr /brc:" "
    sizeof=kd -z C:\Windows\System32\$1.dll -c "?? sizeof($1!_$2);? @$exp;q" | findstr /birc:"eval"
    x=kd -z C:\Windows\System32\$1.dll -c "x $1!$2;q" | findstr /birc:"[0-9a-f]* $1"
    h=doskey /history | findstr /nirc:"[0-9a-z]" | more
    hex=cmd /c exit /b $1&cmd /v/c echo 0x!=exitcode!
    p=for %i in ("%path:;=";"%") do @echo:%~i
    macro=doskey /macros
    which=for %i in (%pathext%;.DLL;.CPL;.MSC) do @for %j in ($1%i) do @if exist "%~$PATH:j" @echo:%~$PATH:j
```
