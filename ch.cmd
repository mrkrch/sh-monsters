@echo off
  setlocal enabledelayedexpansion
    set "i=0"
    for %%i in (%*) do set /a "i+=1"
    if !i! neq 1 goto:man
    
    set "map=CMD;CS;JS;JSN;HTA;LUA;PHP;PL;PS1;PY;RB;SH;TCL;VBN;VBS;WSF"
    call:toUpper %1
    for %%i in (!map!) do if /i "!$!" equ "%%i" set "#=%%i"
    if /i "!#!" equ "" goto:man
    
    set "i=0"
    for /f "tokens=1 delims=:" %%i in (
      'findstr /bn ":!#! :eof_!#!" "%~f0"'
    ) do set "arr.!i!=%%i"&set /a "i+=1"
    set /a "arr.0=arr.0+1", "arr.1=arr.1-1"
    
    3<"%~f0" (
      for /l %%i in (1, 1, !arr.1!) do (
        set /p s=<&3
        if %%i geq !arr.0! echo:!s!
        set "s="
      )
    )>source.cmd
  endlocal
exit /b

:toUpper
  for /f "tokens=2 delims=." %%i in (
    '2^>^&1 find /v "" .%1'
  ) do set "$=%%i"
exit /b

:man
  for %%i in (
    "%~n0 v2.05"
    "Copyright (C) 2015-2016 greg zakharov"
    ""
    "Usage: %~n0 [extension]"
    "Where 'extension' is one of the follow:"
    "   cmd - pure cmd template"
    "   cs  - CMD\CSharp template"
    "   js  - CMD\JavaScript (MS JScript or NodeJS)"
    "   jsn - CMD\JScript.NET template"
    "   hta - CMD\HTA template"
    "   lua - CMD\Lua template"
    "   php - CMD\PHP template"
    "   pl  - CMD\Perl template"
    "   ps1 - CMD\PowerShell template"
    "   py  - CMD\Python template"
    "   rb  - CMD\Ruby template"
    "   sh  - CMD\Bash template"
    "   tcl - CMD\Tcl template"
    "   vbn - CMD\VB.NET template"
    "   vbs - CMD\VBscript template"
    "   wsf - CMD\WSF template"
  ) do echo:%%~i
exit /b

:CMD
@echo off
  setlocal enabledelayedexpansion
  endlocal
exit /b
:eof_CMD

:CS
/* 2>nul
@echo off
  setlocal enabledelayedexpansion
    set "key=HKLM\SOFTWARE\Microsoft\.NETFramework"
    for /f "tokens=3" %%i in (
      '2^>nul reg query %key% /v InstallRoot'
    ) do set "root=%%i"
    if /i "%root%" equ "" echo:Could not find .NET root.
    for /f %%i in ('dir /ad /b "%root%v*"') do (
      set "path=%root%%%i;!path!"
    )
    for %%i in (csc.exe) do (
      if exist "%%~$PATH:i" set "csc=%%~$PATH:i"
    )
    set "arg=/nologo /t:exe /out:app.exe /optimize+"
    set "arg=%arg% /debug:pdbonly /define:CODE_ANALYSIS"
    %csc% %arg% "%~f0"
    app.exe
  endlocal
exit /b
*/

using System;

internal sealed class Program {
  static void Clear() {
    Console.CursorTop = Console.CursorTop - 1;
    Console.Write(new String(' ', Console.BufferWidth));
    Console.CursorTop = Console.CursorTop - 2;
  }
  
  static void Main() {
    Clear();
    /* place your code here */
  }
}
:eof_CS

:JS
0</* :
@echo off
  setlocal
    rem 2>nul node "%~f0" %*
    cscript /nologo /e:jscript "%~f0" %*
  endlocal
exit /b */0;
// place your code here
:eof_JS

:JSN
@set @js=0 /*
  @echo off
    set @js=
    setlocal enabledelayedexpansion
      set "key=HKLM\SOFTWARE\Microsoft\.NETFramework"
      for /f "tokens=3" %%i in (
        '2^>nul reg query %key% /v InstallRoot'
      ) do set "root=%%i"
      if /i "%root%" equ "" echo:Could not find .NET root.
      for /f %%i in ('dir /ad /b "%root%v*"') do (
        set "path=%root%%%i;!path!"
      )
      for %%i in (jsc.exe) do (
        if exist "%%~$PATH:i" set "jsc=%%~$PATH:i"
      )
      set "arg=/nologo /t:exe /out:app.exe /debug+ "%~f0""
      %jsc% %arg%
      app.exe
    endlocal
  exit /b
*/
// place your code here
:eof_JSN

:HTA
<!-- :
  @start mshta "%~f0"&exit /b
-->
<html>
  <head>
    <title></title>
    <meta name="author" content="" />
    <hta:application id=""
         applicationname=""
         border="thin"
         contextmenu="no"
         maximizebutton="no"
         minimizebutton="no"
         scroll="no"
         singleinstance="yes"
         sysmenu="yes"
         version="1.0" />
  </head>
  <body>
  </body>
</html>
:eof_HTA

:LUA
:: --[[
@echo off
  setlocal
    2>nul lua "%~f0" %*
  endlocal
exit /b
--]]
_____ ::
-- place your code here
:eof_LUA

:PHP
:<?php /*
@echo off
  setlocal
    2>nul php "%~f0" %*
  endlocal
exit /b
*/
echo "\r";

/* place your code here */
?>
:eof_PHP

:PL
@echo off
  setlocal
    2>nul perl -x "%~f0" %*
  endlocal
exit /b
#!perl
# place your code here
:eof_PL

:PS1
<# :
  @echo off
    setlocal
      powershell /noprofile /executionpolicy bypass^
      "&{[ScriptBlock]::Create((Get-Content '%~f0') -join [Char]10).Invoke(@(&{$args}%*))}"
    endlocal
  exit /b
#>
# place your code here
:eof_PS1

:PY
1>2# : ^
'''
@echo off
  setlocal
    2>nul python "%~f0" %*
  endlocal
exit /b
'''
# place your code here
:eof_PY

:RB
@echo off
  setlocal
    2>nul ruby -x "%~f0" %*
  endlocal
exit /b
#!ruby
# place your code here
:eof_RB

:SH
:<<EOF
@echo off
  setlocal
    2>nul bash "%~f0" %*
  ebdlocal
exit /b
EOF
# place your code here
:eof_SH

:TCL
::set comment {
  @echo off
    setlocal
      2>nul tclsh86t "%~f0" %*
    endlocal
  exit /b
}
# place your code here
:eof_TCL

:VBN
rem^ & @echo off
rem^ &   setlocal enabledelayedexpansion
rem^ &     set "key=HKLM\SOFTWARE\Microsoft\.NETFramework"
rem^ &     for /f "tokens=3" %%i in ('2^>nul reg query %key% /v InstallRoot') do set "root=%%i"
rem^ &     if /i "%root%" equ "" echo:Could not find .NET root.
rem^ &     for /f %%i in ('dir /ad /b "%root%v*"') do set "path=%root%%%i;!path!"
rem^ &     for %%i in (vbc.exe) do if exist "%%~$PATH:i" set "vbc=%%~$PATH:i"
rem^ &     set "arg=/nologo /t:exe /out:app.exe /optimize+"
rem^ &     set "arg=%arg% /debug:pdbonly /define:CODE_ANALYSYS"
rem^ &     %vbc% %arg% "%~f0"
rem^ &     app.exe
rem^ &   endlocal
rem^ & exit /b

Imports System

Friend NotInheritable Class Program
  Private Shared Sub Clear
    Console.CursorTop = Console.CursorTop - 1
    Console.Write(New String(" ", Console.BufferWidth))
    Console.CursorTop = Console.CursorTop - 2
  End Sub
  
  Shared Sub Main
    Clear
    ' place your code here
  End Sub
End Class
:eof_VBN

:VBS
::'@cscript /nologo /e:vbscript "%~f0" %*&exit /b
' place your code here
:eof_VBS

:WSF
<?xml : version="1.0" encoding="utf-8"?> ^<!-- :
  @cscript /nologo "%~f0?.wsf" //job:JS //job:VBS&exit /b
-->
<package>
  <job id="JS">
    <script language="JScript"><![CDATA[
    ]]></script>
  </job>
  <job id="VBS">
    <script language="VBScript"><![CDATA[
    ]]></script>
  </job>
</package>
:eof_WSF