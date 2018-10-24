@echo off

REM -----------------------------------------------------------------------------
REM Aliases for the Windows Command Prompt
REM
REM You can run this when Command Prompt launches by running with the /K argument
REM For example:
REM    C:\Windows\System32\cmd.exe /K C:\Users\ripperbone\scripts\profile.cmd
REM
REM -----------------------------------------------------------------------------

echo Hello! Today is %date%

set PROMPT=$P$S~$G$S

doskey alias=doskey /macros
doskey aliases=doskey /macros
doskey cat=type $*
doskey clear=cls
doskey ls=dir
doskey ll=dir
doskey cp=copy $*
doskey mv=move $*
doskey rm=del $*
doskey rmdir=rmdir /S /Q $*
doskey vi=vim $*
doskey export=set $*
doskey ifconfig=ipconfig
doskey history=doskey /history
doskey homedir=cd %userprofile%
doskey home=cd %userprofile%
doskey lock=rundll32.exe user32.dll,LockWorkStation
doskey which=where $*
doskey env=set
doskey time=time /T
doskey date=date /T

REM shortcuts for editing and reloading this file
doskey edit-profile=vim %~dp0profile.cmd
doskey profile=call %~dp0profile.cmd
