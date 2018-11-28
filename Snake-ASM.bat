@echo off
if not exist "bin\bootdisk.img" (
    call compile.bat
)
call setup.bat
cd bin
start dosbox-x.exe