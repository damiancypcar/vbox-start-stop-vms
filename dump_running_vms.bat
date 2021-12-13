@echo off
REM ======================================
REM Determine list of running VMs
REM Date:       22.09.2020
REM Version:    1.0
REM Author:     damiancypcar@gmail.com
REM ======================================
REM Changelog
REM # 1.0 - first version
REM ======================================
cls
setlocal
title %~nx0
echo Determine list of running VMs
echo.

REM set "vboxpath=S:\Oracle\VirtualBox"
set "vboxpath=S:\Oracle\VirtualBox"
set vboxman="%vboxpath%\VBoxManage.exe"
set vmfile=vm_list.txt

REM vboxman list runningvms
break > %vmfile%
FOR /F "tokens=* USEBACKQ" %%F IN (`%vboxman% list runningvms`) DO (
    REM ECHO %%F
    FOR /F "tokens=1 delims=' " %%G IN ('echo %%F') DO  (
        echo %%G >> %vmfile%
    )
)

echo Done.
REM echo Press any key to exit . . .
REM pause > NUL & exit B 0
