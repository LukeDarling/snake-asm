@echo off
bin\nasm.exe -g -f bin -o bin\kernel.bin src\kernel.asm 2> log\compile.log
for /f %%i in ("log\compile.log") do set snake_asm_log_size=%%~zi
if %snake_asm_log_size% gtr 0 echo There was an error compiling the kernel: & type compile.log & echo. & pause & exit
bin\nasm.exe -g -f bin -o bin\boot.bin src\boot.asm 2> log\compile.log
for /f %%i in ("log\compile.log") do set snake_asm_log_size=%%~zi
if %snake_asm_log_size% gtr 0 echo There was an error compiling the bootloader: & type compile.log & echo. & pause & exit
bin\mkfloppy.exe bin\bootdisk.img bin\boot.bin bin\kernel.bin
echo Compilation successful. > log\compile.log