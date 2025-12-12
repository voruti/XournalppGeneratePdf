@echo off
cd /D "%~dp0"

if "%~1"=="" (
    echo Error: no parameter passed
    pause
    exit 1
)
if not "%~2"=="" (
    echo Error: more than one parameter passed
    pause
    exit 1
)
if not exist "%~n0.sh" (
    echo Error: corresponding .sh script not found
    pause
    exit 1
)

SETLOCAL ENABLEDELAYEDEXPANSION

set "win_path=%~1"
@REM echo "win path: %win_path%"

set "drive_letter=%win_path:~0,1%"
@REM echo "drive letter: %drive_letter%"
call :LoCase drive_letter
@REM echo "drive letter: %drive_letter%"

set "switched_slashes=%win_path:\=/%"
@REM echo "switched slashes: %switched_slashes%"

set "unix_path=/%drive_letter%/%switched_slashes:~3%"
@REM echo "unix path: %unix_path%"

%GIT_BASH% "%~n0.sh" "%unix_path%"

ENDLOCAL

timeout /T 5 /NOBREAK


:LoCase
:: Subroutine to convert a variable VALUE to all lower case.
:: The argument for this subroutine is the variable NAME.
:: https://superuser.com/a/1522024
SET %~1=!%~1:A=a!
SET %~1=!%~1:B=b!
SET %~1=!%~1:C=c!
SET %~1=!%~1:D=d!
SET %~1=!%~1:E=e!
SET %~1=!%~1:F=f!
SET %~1=!%~1:G=g!
SET %~1=!%~1:H=h!
SET %~1=!%~1:I=i!
SET %~1=!%~1:J=j!
SET %~1=!%~1:K=k!
SET %~1=!%~1:L=l!
SET %~1=!%~1:M=m!
SET %~1=!%~1:N=n!
SET %~1=!%~1:O=o!
SET %~1=!%~1:P=p!
SET %~1=!%~1:Q=q!
SET %~1=!%~1:R=r!
SET %~1=!%~1:S=s!
SET %~1=!%~1:T=t!
SET %~1=!%~1:U=u!
SET %~1=!%~1:V=v!
SET %~1=!%~1:W=w!
SET %~1=!%~1:X=x!
SET %~1=!%~1:Y=y!
SET %~1=!%~1:Z=z!
GOTO:EOF
