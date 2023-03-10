@echo off
REM --------------------------------------------------------
REM Author:        damiancypcar
REM Modified:      10.03.2023
REM Version:       1.1
REM Desc:          Dump list of running VMs to file
REM --------------------------------------------------------

cls
setlocal
title %~nx0
echo Dump list of running VMs to file
echo.

set "vboxpath=S:\Oracle\VirtualBox"
set vboxman="%vboxpath%\VBoxManage.exe"
set vmfile=vm-list.txt

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
