@echo off

for /f %%i in ('ghq list -p ^| peco') do (
    if "%~1" == "-e" (
        start %%i
    ) else if "%~1" == "-v" (
        cmd /c start gvim %%i
    ) else (
        cd %%i
  )
        break
)
