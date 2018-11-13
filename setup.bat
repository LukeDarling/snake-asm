@echo off
cd > bin/path.conf
SET /p snake_asm_path= < bin/path.conf
echo [autoexec]^

mount W "%snake_asm_path%"^

W:^

kernel.com > bin/dosbox.conf