global EN_INPUT := 0x4090409
global ZH_INPUT := 0x8040804

; Key mappings
!w::!F4 ; map alt+w to alt+F4
#t::Run C:\software\terminal\WindowsTerminal.exe ; Win+T to open terminal

GetCurrentIME()
{
    SetFormat, Integer, H
    WinID:=WinActive("A")
    ThreadID:=DllCall("GetWindowThreadProcessId", "UInt", WinID, "UInt", 0)
    InputLocaleID:=DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")
    Clipboard:=InputLocaleID
    return InputLocaleID
}

^Space::
{
    ClipSaved := ClipboardAll ; save the clipboard
    IME := GetCurrentIME()
    if (IME = 0x4090409) {
        ControlGetFocus, ctl, A ; Get Control
        PostMessage, 0x50, 0, 0x8040804, %ctl% , A ; switch IME
    } else if (IME = 0x8040804) {
        ControlGetFocus, ctl, A
        PostMessage, 0x50, 0, 0x4090409, %ctl% , A
    }
    Clipboard := ClipSaved ; Restore the clipboard
    ClipSaved := "" ; Release the tmpSaved data
    Return
}

; audio funcs
ScrollLock::Send {Volume_Down}
Pause::Send {Volume_Up}

; use win+j/k to switch windows desktop
#j::#^Left
#k::#^Right

/*
 *  Specific processes operations
 */
; using hjkl to switch processes
#IfWinActive ahk_class MultitaskingViewFrame
h::left
j::down
k::up
l::right
#IfWinActive

; Using alt + hjkl in clion
#IfWinActive ahk_exe clion64.exe
!h::Send {Left}
!j::Send {Down}
!k::Send {Up}
!l::Send {Right}
#IfWinActive

; Using ctrl + hjkl in excel
#IfWinActive ahk_exe excel.exe
^h::Send {Left}
^j::Send {Down}
^k::Send {Up}
^l::Send {Right}
#IfWinActive

; map CapsLock and Shift+CapsLock to Esc
+CapsLock::
CapsLock::
    Send {Esc}
    PostMessage, 0x50, 0, %EN_INPUT%, , A ; 切换到英文输入法
Return

; 长按ctrl，短按esc
; g_LastCtrlKeyDownTime := 0
; g_AbortSendEsc := false
; g_ControlRepeatDetected := false
; 
; *CapsLock::
;     if (g_ControlRepeatDetected)
;     {
;         return
;     }
; 
;     send,{Ctrl down}
;     g_LastCtrlKeyDownTime := A_TickCount
;     g_AbortSendEsc := false
;     g_ControlRepeatDetected := true
; 
;     return
; 
; *CapsLock Up::
;     send,{Ctrl up}
;     g_ControlRepeatDetected := false
;     if (g_AbortSendEsc)
;     {
;         return
;     }
;     current_time := A_TickCount
;     time_elapsed := current_time - g_LastCtrlKeyDownTime
;     if (time_elapsed <= 250)
;     {
;         SendInput {Esc}
;     }
;     return
; 
; ~*^a::
; ~*^b::
; ~*^c::
; ~*^d::
; ~*^e::
; ~*^f::
; ~*^g::
; ~*^h::
; ~*^i::
; ~*^j::
; ~*^k::
; ~*^l::
; ~*^m::
; ~*^n::
; ~*^o::
; ~*^p::
; ~*^q::
; ~*^r::
; ~*^s::
; ~*^t::
; ~*^u::
; ~*^v::
; ~*^w::
; ~*^x::
; ~*^y::
; ~*^z::
; ~*^1::
; ~*^2::
; ~*^3::
; ~*^4::
; ~*^5::
; ~*^6::
; ~*^7::
; ~*^8::
; ~*^9::
; ~*^0::
; ~*^Space::
; ~*^Backspace::
; ~*^Delete::
; ~*^Insert::
; ~*^Home::
; ~*^End::
; ~*^PgUp::
; ~*^PgDn::
; ~*^Tab::
; ~*^Return::
; ~*^,::
; ~*^.::
; ~*^/::
; ~*^;::
; ~*^'::
; ~*^[::
; ~*^]::
; ~*^\::
; ~*^-::
; ~*^=::
; ~*^`::
; ~*^F1::
; ~*^F2::
; ~*^F3::
; ~*^F4::
; ~*^F5::
; ~*^F6::
; ~*^F7::
; ~*^F8::
; ~*^F9::
; ~*^F10::
; ~*^F11::
; ~*^F12::
;     g_AbortSendEsc := true
;     return

