OnExit, ExitSub

#MaxHotkeysPerInterval 120

#include local\rc
#include AutoHotkey.ahk


; vk1C == 変換キー
vk1C & q::1
vk1C & w::2
vk1C & e::3
vk1C & r::4
vk1C & t::5
vk1C & a::6
vk1C & s::7
vk1C & d::8
vk1C & f::9
vk1C & g::0

vk1C & y::-
vk1C & u::^
vk1C & i::\
vk1C & o::[
vk1C & p::]
vk1C & @::BackSpace

vk1C & h::Left
vk1C & j::Down
vk1C & k::Up
vk1C & l::Right
vk1C & sc027::ESC   ; sc027 == semicolon
vk1C & sc028::Enter ; sc028 == colon

vk1C & Shift::F1
vk1C & z::F2
vk1C & x::F3
vk1C & c::F4
vk1C & v::F5
vk1C & b::F6
vk1C & n::F7
vk1C & m::F8
vk1C & ,::F9
vk1C & .::F10


;DEL::
;    Send, {LButton}{LButton}
;    Sleep, 800
;    Send, {TAB}
;    Sleep, 200
;    Send, {TAB}
;    Sleep, 500
;    Send, {DOWN}
;    Send, {DOWN}
;    Send, {DOWN}
;    Send, {DOWN}
;    Sleep, 500
;    Send, ^{ENTER}

#IfWinActive Adobe Acrobat Reader (64-bit)
^c::
    Send, ^c
    ClipWait
    x = %clipboard%
    space := " "
    StringReplace, x, x, .`r`n, .`r, All
    StringReplace, x, x, :`r`n, :`r, All
    StringReplace, x, x, `r`n, %space%, All
    StringReplace, x, x, .`r, .`r`n`r`n, All
    StringReplace, x, x, :`r, :`r`n`r`n, All
    clipboard = %x%
    return
#IfWinActive

; ------------------------------------------------------------------------------
; with QMK
#IfWinNotActive ChildView ; RemoteView
F13::StartEasyWindowDrag() ; z
F13 Up::EndEasyWindowDrag()
F14::StartEasyWindowResize() ; x
F14 Up::EndEasyWindowResize()
F15::WinClose, A ; w
F16::Send, {LButton}{LButton} ; v
F18::WinGetTitle, clipboard, A ; t

F17::ToggleMaximize(0) ; r
+F17::ToggleMaximize(1)
^F17::ToggleMaximize(2)

F19::
    WinSet, AlwaysOnTop, Toggle, A
    return
^F3::
    WinSet, AlwaysOnTop, Toggle, A
    return
#IfWinNotActive

#WheelDown::
    WinGet, tp, Transparent, A
    if (tp = "OFF" or tp = "") {
        tp := 250
    } else if (tp >= 5) {
        tp := tp - 5
    } else {
        tp := 0
    }
    WinSet, Transparent, %tp%, A
    return
#WheelUp::
    WinGet, tp, Transparent, A
    if (tp = "OFF" or tp = "") {
        tp := "OFF"
    } else if (tp < 250) {
        tp := tp + 5
    } else {
        tp := "OFF"
    }
    WinSet, Transparent, %tp%, A
    return
; ------------------------------------------------------------------------------

ExitSub:
    ; AHK終了時に実行したい処理があればここに書く
    ExitApp

#IfWinNotActive ChildView ; RemoteView
^m::
    Send, {Enter}
    return
#IfWinNotActive

;F10::
;    mofs := 0
;    Loop {
;        if (1000 < A_TimeIdlePhysical) {
;            MouseGetPos, mx, my
;            Sleep, 10
;            x := -1280 - mofs
;            mofs := 1 - mofs
;            MouseMove, %x%, 1200, 0
;            Sleep, 10
;            MouseMove, %mx%, %my%, 0
;            Sleep, 60000
;        }
;        Sleep, 1000
;    }
;    return

;F12::
;    if (teams_id = "") {
;        MsgBox, teams_id not found
;        return
;    }
;    WinActivate, ahk_id %teams_id%
;    return

;F11::
;+F12::
;    WinGet, active_id, ID, A
;
;    ;WinGet, teams_id, ID, ahk_exe Teams.exe
;    ;MsgBox, %teams_id%
;
;    if (teams_id = "") {
;        MsgBox, teams_id not found
;        return
;    }
;
;    WinActivate, ahk_id %teams_id%
;    WinWaitActive, ahk_id %teams_id%
;
;    Send, ^+m
;
;    WinActivate, ahk_id %active_id%
;
;    return



;#IfWinActive - WinActor
;F4::
;    ;Loop, 7 {
;    {
;        ;i := A_Index - 1
;        i := 6
;        Send, {Alt}{Down 6}{Right}
;        Loop, %i% {
;            Send, {Down}
;        }
;        ;Send, {Down %i%}
;        Sleep, 100
;        Send, {Enter}
;        WinWaitActive, 保存
;        Send, %i%.csv{Enter}
;
;        WinWaitActive, WinActor,, 5
;        if !ErrorLevel {
;            Send, {Enter}
;        }
;        WinWaitActive, WinActor,, 5
;        if !ErrorLevel {
;            Send, {Enter}
;        }
;
;        WinWaitActive, - WinActor
;        Send, {Esc 3}
;    }
;    ;SendMessage, 0x9803, 0x00000000, 0x19002C
;    return
;#IfWinActive
;
;F3::
;    WinGetTitle, x, A
;    MsgBox, %x%
;    return


;+F4::
;    Send, ^v
;    Send, {DOWN}
;    return

;#IfWinActive ahk_class CabinetWClass
;; F4 を押す毎に以下の URL を切り替える
;; ローカル側を開くときは、 others/tb_unc_open 経由で開く事により svn update 等を実施する
;;   file:///C:/alphatc_svn_work/
;;   file://atcserver/svn/alphatc/files/work/
;; ahk_class CabinetWClass == explorer.exe
;F4::
;    WinGet, wid, ID, A
;
;    windows := ComObjCreate("Shell.Application").Windows()
;    for win in windows {
;        if win.hwnd == wid {
;            name := win.LocationName
;            url  := win.LocationURL
;            hwnd := win.hwnd
;
;            path := ""
;            if SubStr(url, 1, 8) == "file:///" {
;                path := SubStr(url, 9)
;            }
;            clip_org := clipboardAll
;            Run, copy_fullpath.exe %path%
;            path := clipboard
;            MsgBox, %path%
;            ;:w
;            ;clipboard := clip_org
;
;            if SubStr(path, 1, 20) == "C:\alphatc_svn_work\" {
;                target := "file://atcserver/svn/alphatc/files/work/" + SubStr(url, 1 + 28)
;                win.Navigate(target)
;
;            } else if SubStr(path, 1, 35) == "\\atcserver\svn\alphatc\files\work\" {
;                ;target := "file:///C:/alphatc_svn_work/" + SubStr(url, 1 + 40)
;                ;win.Navigate(target)
;                MsgBox, tb_unc_open --hwnd %wid% %path%
;                Run, tb_unc_open --hwnd %wid% file:///%path%
;            }
;        }
;    }
;    return
;#IfWinActive


; vi:set et ft=ahk:
