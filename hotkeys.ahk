; keyboard mappings
!w::Send !{F4} ; map alt+w to alt+F4
^!t::Run %LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.WindowsTerminal_8wekyb3d8bbwe\wt.exe ; Ctrl+Alt+T

; vim settings
SwitchIME(dwLayout){
    HKL:=DllCall("LoadKeyboardLayout", Str, dwLayout, UInt, 1)
    ControlGetFocus,ctl,A
    SendMessage,0x50,0,HKL,%ctl%,A
}

; map CapsLock and Shift+CapsLock to Esc
+CapsLock::
CapsLock::
    Send {Esc}
    SwitchIME(0x04090409) ; 退出到normal模式的时候，切换到英文输入
return

^Space::Send ^{Shift}

; audio funcs
PrintScreen::Send {Volume_Down}
ScrollLock::Send {Volume_Up}

Pause::
if (toggle := !toggle) {
    run, nircmd.exe setdefaultsounddevice "tv"
}
else {
    run, nircmd.exe setdefaultsounddevice "earphone"
}
return