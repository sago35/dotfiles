@echo off

for /f %%i in ('ghq list --vcs git -p ^| peco') do (
    if "%~1" == "-e" (
        start %%i
    ) else if "%~1" == "-c" (
        start cmd /k cd %%i
    ) else if "%~1" == "-v" (
        cmd /c gvim %%i
    ) else (
        cd %%i
    )
    break
)
