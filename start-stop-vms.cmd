@echo off
REM --------------------------------------------------------
REM Author:        damiancypcar
REM Modified:      10.03.2023
REM Version:       7.0
REM Desc:          Automatic start/stop Virtalbox VMs
REM --------------------------------------------------------

cls
setlocal
title %~nx0
echo Automatic start/stop Virtalbox VMs
echo.

set errorlevel=
set mydate=%date%_%time%
set "vboxpath=S:\Oracle\VirtualBox"
set vboxman="%vboxpath%\VBoxManage.exe"
set logfile="%~dp0start-stop-log.txt"
set vmlist=vm-list.txt

IF "%~1"=="" (GOTO empty)
IF "%~1"=="start" (GOTO startvm)
IF "%~1"=="stop" (GOTO stopvm
) ELSE (GOTO empty)


:empty
echo use start or stop argument
goto:eof

REM ---------------------------------- START ---------------------------------------
:startvm
echo Start delay
timeout /t 30 /nobreak

echo/ >> %logfile%
echo START >> %logfile%
echo START VMs
echo %date% >> %logfile%
echo %date%
echo %time% >> %logfile%
echo %time%

REM Start VirtalBox GUI
start "" %vboxpath%\VirtualBox.exe

REM Procedure for VM with snapshot restoration on start
REM timeout /t 1 /nobreak > NUL
REM echo Restore <vm_name> snapshot >> %logfile%
REM echo Restore <vm_name> snapshot
REM %vboxman% snapshot <vm_name> restore 4c571372-761d-43b1-b854-4633084e5a0a >> %logfile% 2>&1
REM echo %time% >> %logfile%
REM echo %time%
REM timeout /t 5 /nobreak > NUL
REM echo Starting <vm_name> >> %logfile%
REM echo Starting <vm_name>
REM %vboxman% startvm <vm_name> --type gui >> %logfile% 2>&1
REM REM %vboxman% guestproperty get %%i "/VirtualBox/GuestInfo/Net/0/V4/IP" >> %logfile% 2>&1
REM if %errorlevel% EQU 1 (
REM     echo FAILED TO START <vm_name> >> %logfile%
REM     echo FAILED TO START <vm_name>
REM     echo Errorlevel is %errorlevel% >> %logfile%
REM     rem exit /b %errorlevel%
REM ) else if %errorlevel% EQU 0 (
REM     echo Start done for <vm_name> >> %logfile%
REM     echo Start done for <vm_name>
REM )
REM echo %time% >> %logfile%
REM echo %time%

for /F %%i in (%vmlist%) do (
    echo Starting %%i >> %logfile%
    echo Starting %%i
    REM echo %time% >> %logfile%
    %vboxman% startvm %%i --type gui >> %logfile% 2>&1
    REM %vboxman% guestproperty get %%i "/VirtualBox/GuestInfo/Net/0/V4/IP" >> %logfile% 2>&1
    if %errorlevel% EQU 1 (
        echo FAILED TO START %%i >> %logfile%
        echo FAILED TO START %%i
        echo Errorlevel is %errorlevel% >> %logfile%
        rem exit /b %errorlevel%
    ) else if %errorlevel% EQU 0 (
        echo Start done for %%i >> %logfile%
        echo Start done for %%i
    )
    timeout /t 60 /nobreak > NUL
)

REM Locks screen
timeout /t 10 /nobreak > NUL
echo Lock PC >> %logfile%
echo Lock PC
rundll32.exe user32.dll,LockWorkStation

echo %time% >> %logfile%
echo %time%
echo END >> %logfile%
echo END
echo/ >> %logfile%

goto:eof

REM ---------------------------------- STOP ----------------------------------------
:stopvm
echo/ >> %logfile%
echo STOP >> %logfile%
echo STOP VMs
echo %date% >> %logfile%
echo %date%
echo %time% >> %logfile%
echo %time%

REM Stop procedure for VM with snapshot restoration
REM timeout /t 1 /nobreak > NUL
REM echo Shutdown <vm_name> >> %logfile%
REM echo Shutdown <vm_name> 
REM %vboxman% controlvm <vm_name> poweroff soft >> %logfile% 2>&1
REM REM %vboxman% guestproperty get %%i "/VirtualBox/GuestInfo/Net/0/V4/IP" >> %logfile% 2>&1
REM if %errorlevel% EQU 1 (
REM     echo FAILED TO STOP <vm_name> >> %logfile%
REM     echo FAILED TO STOP <vm_name>
REM     echo Errorlevel is %errorlevel% >> %logfile%
REM     rem exit /b %errorlevel%
REM ) else if %errorlevel% EQU 0 (
REM     echo Stop done for <vm_name> >> %logfile%
REM     echo Stop done for <vm_name>
REM )
REM echo %time% >> %logfile%
REM echo %time%

for /F %%i in (%vmlist%) do (
    timeout /t 5 /nobreak > NUL
    echo Stopping %%i >> %logfile%
    echo Stopping %%i
    REM echo %time% >> %logfile%
    %vboxman% controlvm %%i savestate 1>> %logfile% 2>&1
    REM %vboxman% guestproperty get %%i "/VirtualBox/GuestInfo/Net/0/V4/IP" >> %logfile% 2>&1
    if %errorlevel% EQU 1 (
        echo FAILED TO STOP %%i >> %logfile%
        echo FAILED TO STOP %%i
        echo Errorlevel is %errorlevel% >> %logfile%
        rem exit /b %errorlevel%
    ) else if %errorlevel% EQU 0 (
        echo Stop done for %%i >> %logfile%
        echo Stop done for %%i
    )
)

echo %date% >> %logfile%
echo %date%
echo %time% >> %logfile%
echo %time%
echo END >> %logfile%
echo END
echo/ >> %logfile%

goto:eof

endlocal
