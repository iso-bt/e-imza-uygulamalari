@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:-------------------------------------- 

mkdir %temp%\EBYS
cd %temp%\EBYS

curl -o %temp%\EBYS\akis.zip https://kamusm.bilgem.tubitak.gov.tr/islemler/surucu_yukleme_servisi/suruculer/AkisKart/windows/64/Akia_windows-x64_6_5_4_msi.zip
curl -o %temp%\EBYS\java.exe https://dl.turktrust.com.tr/java-8u231.exe
curl -o %temp%\EBYS\palma.exe https://dl.turktrust.com.tr/PALMA_2.9_64bit_Setup_A2.7_G10.8_b24020501.exe
curl -o %temp%\EBYS\enVision.exe https://ebys.iso.org.tr/enVision/Util/enVision.Client.Service.exe
curl -o %temp%\EBYS\net4.exe https://dl.turktrust.com.tr/Net_Framework_4.0.exe
curl -o %temp%\EBYS\net45.exe https://dl.turktrust.com.tr/Net_Framework_4.5.2.exe
curl -o %temp%\EBYS\vc86.exe https://download.microsoft.com/download/5/B/C/5BC5DBB3-652D-4DCE-B14A-475AB85EEF6E/vcredist_x86.exe

powershell -Command "Expand-Archive -Path '%temp%\EBYS\akis.zip' -DestinationPath '%temp%\EBYS\'"

%temp%\EBYS\Akia_windows-x64_6_5_4.msi /qn /norestart
%temp%\EBYS\java.exe /qn /norestart
%temp%\EBYS\palma.exe /SILENT /NOCANCEL /NORESTART /qn
%temp%\EBYS\enVision.exe /exenoui /qn
%temp%\EBYS\net4.exe /q /norestar
%temp%\EBYS\net45.exe  /q /norestar
%temp%\EBYS\vc86.exe /q /norestar

rmdir /s /q %temp%\EBYS
