#Requires AutoHotkey v2.0
#SingleInstance Force

; Ctrl + Alt + Shift + F12
^!+F12::
{
    Run(
        'powershell.exe -NoProfile -WindowStyle Hidden ' .
        '-ExecutionPolicy Bypass ' .
        '-File "C:\Scripts\Close-ApolloSession.ps1"',
        ,
        'Hide'
    )
}