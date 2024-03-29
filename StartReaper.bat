@echo off
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

echo Purging Configurations file.  If there's a file you would like to see not deleted in the future, add it to the config repository. 
git clean -fd



echo Updating Configurations...
git checkout master
git reset --hard
git remote prune origin
git pull --rebase


echo Setting Date Variables...

For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
For /f "tokens=1-3 delims=/:/ " %%a in ('time /t') do (set mytime=%%a%%c)


echo Updating Local Reaper Templates...
xcopy /s /q /y .\Reaper\Templates "%userprofile%\AppData\Roaming\REAPER\ProjectTemplates"



echo Creating directory for service...

if not exist "M:\Recordings\" mkdir "%cd%\..\Recordings\" (
	mkdir "M:\Recordings\%mydate% %mytime%"
)


echo Starting Reaper...

SET templateFile=Livestream Only Mixing.rpp

REM for x64 computers
if exist "c:\Program Files\REAPER (x64)" (
	Start "" "c:\Program Files\REAPER (x64)\reaper.exe" -template "%cd%\Reaper\Templates\%templateFile%" -saveas "M:\Recordings\%mydate% %mytime%\%mydate% %mytime%.rpp" -newinst

) else powershell (New-Object -ComObject Wscript.Shell).Popup("""It appears that Reaper isn't installed.  Please install the 64-bit version.""",0,"""Reaper?""",0x10)
REM for computers that don't have Reaper




echo Checking that Amps and NetMax are online... 
@echo off
for /f "usebackq skip=2" %%i in (`ping -n 1 -i 1 -w 200 10.20.1.252`) do (
  set pingtest=%%i
  goto :done
  )
:done

if not "%pingtest%" == "Reply" powershell (New-Object -ComObject Wscript.Shell).Popup("""The amplifiers and/or NetMax appear to be offline.""",0,"""Sound System Off?""",0x30)

goto :eof

