@goto:start
  Example of building Lua on Windows (with SDK).
  
  1.Download Lua:
      curl -R -O http://www.lua.org/ftp/lua-5.3.3.tar.gz
  2.Extract 'src' folder into a your favorite folder.
  3.Run setenv.cmd with required parameters (see setenv.cmd /?).
  4.Place this batch into 'src' folder and launch it.
  5.Done.
:start
@echo off
  cl.exe /MD /O2 /c /DLUA_BUILD_AS_DLL *.c
  ren lua.obj lua.o
  ren luac.obj luac.o
  link.exe /DLL /IMPLIB:lua5.3.3.lib /OUT:lua5.3.3.dll *.obj
  link.exe /OUT:lua.exe lua.o lua5.3.3.lib
  lib.exe /OUT:lua5.3.3-static.lib *.obj
  link.exe /OUT:luac.exe luac.o lua5.3.3-static.lib
  md lua
  move *.exe lua
  move *.dll lua
  del /f /q *
exit /b
