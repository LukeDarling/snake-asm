@echo off
bin\nasm.exe -g -fbin -o bin\kernel.bin src\kernel.asm 2> log\compile.log
for /f %%i in ("log\compile.log") do set snake_asm_log_size=%%~zi
if %snake_asm_log_size% gtr 0 echo There was an error compiling Snake-ASM: & type compile.log & echo. & pause & exit
echo Compilation successful. > log\compile.log