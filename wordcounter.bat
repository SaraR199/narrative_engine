@echo off
setlocal enabledelayedexpansion

:: Prompt user to enter the full folder path
set /p folder=Enter the full folder path containing .md files: 

set totalWords=0

:: Loop through all .md files in the given folder
for %%f in ("%folder%\*.md") do (
    set /a words=0
    :: Read file line by line
    for /f "usebackq tokens=*" %%a in ("%%f") do (
        :: Count words in the current line and add to words
        set line=%%a
        for %%b in (!line!) do (
            set /a words+=1
        )
    )
    set /a totalWords+=words
)

echo Total word count in .md files: %totalWords%

pause
