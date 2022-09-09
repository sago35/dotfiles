OnExit, ExitSub

#include local\rc
#include AutoHotkey.ahk

#IfWinActive Adobe Acrobat Reader DC
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
F13::StartEasyWindowDrag()
F13 Up::EndEasyWindowDrag()
F14::StartEasyWindowResize()
F14 Up::EndEasyWindowResize()
F15::WinClose, A
F16::Send, {LButton}{LButton}
F18::WinGetTitle, clipboard, A

F17::ToggleMaximize(0)
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

F10::
    mofs := 0
    Loop {
        if (1000 < A_TimeIdlePhysical) {
            MouseGetPos, mx, my
            Sleep, 10
            x := -1280 - mofs
            mofs := 1 - mofs
            MouseMove, %x%, 1200, 0
            Sleep, 10
            MouseMove, %mx%, %my%, 0
            Sleep, 60000
        }
        Sleep, 1000
    }
    return

;F12::
;    if (teams_id = "") {
;        MsgBox, teams_id not found
;        return
;    }
;    WinActivate, ahk_id %teams_id%
;    return

F11::
+F12::
    WinGet, active_id, ID, A

    ;WinGet, teams_id, ID, ahk_exe Teams.exe
    ;MsgBox, %teams_id%

    if (teams_id = "") {
        MsgBox, teams_id not found
        return
    }

    WinActivate, ahk_id %teams_id%
    WinWaitActive, ahk_id %teams_id%

    Send, ^+m

    WinActivate, ahk_id %active_id%

    return



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
