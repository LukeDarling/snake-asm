@echo off
cd > bin/path.conf
SET /p snake_asm_path= < bin/path.conf
echo [autoexec]^

mount W "%snake_asm_path%"^

W:^

mount T "%snake_asm_path%\bin"^

set PATH=%%PATH%%;T:\TC;T:\TASM > bin/dosbox.conf