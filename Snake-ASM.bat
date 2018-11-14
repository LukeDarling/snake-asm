@echo off
if not exist "kernel.com" (
    call compile.bat
)
call setup.bat
cd bin
start dosbox-x.exe