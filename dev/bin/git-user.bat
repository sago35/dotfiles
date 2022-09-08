@echo off
if "%~1" == "atc" (
    git config --local user.name "Masaaki Takasago"
    git config --local user.email "takasago.masaaki@alphatc.co.jp"
) else if "%~1" == "sago35" (
    git config --local user.name "sago35"
    git config --local user.email "sago35@gmail.com"
) else (
    echo unset
    git config --local --unset user.name
    git config --local --unset user.email
)
git config --get-regexp user
