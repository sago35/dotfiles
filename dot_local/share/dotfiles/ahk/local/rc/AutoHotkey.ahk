SetTitleMatchMode, 2
DetectHiddenWindows, On
Menu, TRAY, Icon, AutoHotkey.exe, 2
SetTimer, PeriodicProcess500ms, 500
CoordMode, ToolTip, Screen

EDITOR = gvim

#include tsense-ahk
#include tsense.ahk
#include ..
#include tsense_conf.ahk

#include *i local.ahk

return

; ------------------------------------------------------------------------------
; tsense mode
#IfWinNotActive ChildView
vk1D::ToggleTsenseMode(1)
vk1D Up::ToggleTsenseMode(0)
#IfWinNotActive

F20::ToggleTsenseMode(1)
F20 Up::ToggleTsenseMode(0)


#IfWinExist, __tsense_mode_win
F1::
    Run, local\etc\AutoHotkey.chm
    return

; vkBAsc028 => :
vkBA::Run, ..\fenrir\fenrir.exe, ..\fenrir\
;#z::Reload
#IfWinExist

; ------------------------------------------------------------------------------
; AutoHotkeyの設定
#q::
    Run, %EDITOR% "%A_ScriptFullPath%"
    return
;#z::
;    Reload
;    return

^[:: Send {ESC}
^h:: Send {BS}

; 直前のアプリと切り替え
+vk1D::
    ToggleApp()
    return

; 変換キーを半角/全角に
;*vk1C::Send, !{vkF3}

PrintScreen::
    Run, %USERPROFILE%\app\rapture\rapture.exe, %USERPROFILE%\app\rapture
    return

;#0::
;    ; A_WorkingDirのHEADを書き出して、出力先フォルダを開く
;    if (FileExist("dist") == "") {
;        FileCreateDir, dist
;    }
;    Run, git archive --format=zip -o dist/%A_YYYY%%A_MM%%A_DD%_ahk_config.zip HEAD
;    Run, explorer dist
;    return

; calendar
#1::
    Gui, 99:Add, MonthCal, AltSubmit x-4 y-3 w350 h290,
    Gui, 99:Show, x131 y91 h288 w346, Calender
    return

99GuiClose:
99GuiEscape:
    Gui, 99:Hide
    return

; Excel like
;#IfWinNotActive ChildView
^;::
    Send, %A_YYYY%/%A_MM%/%A_DD%
    return
;#IfWinNotActive

; ------------------------------------------------------------------------------
; cltc
; vk1D : 無変換
^vk1D::
    ; 常駐モード
    Run, ..\cltc\cltc.exe
    WinWaitActive, ahk_class CLTCMainWindow, , 1
    If (ErrorLevel) {
        ; time out
    } else {
        Send, ^a
    }
    return

#IfWinActive ahk_class CLTCMainWindow
LCtrl::LCtrl
LCtrl Up::Send, {Enter}
^m::
    Send, {Enter}
    WinWait, , , 2, タスク ビュー
    WinGetPos, x, y, w, h, A
    x := x + w / 2
    y := y + h / 2
    MouseMove, %x%, %y%, 10
    return
#IfWinActive

; ------------------------------------------------------------------------------
; Win + TAB
; vk1D : 無変換
#IfWinNotActive ChildView
^+vk1D::
    Send {LWin down}{TAB}{LWin up}
    return
#IfWinNotActive

#IfWinActive タスク ビュー
LCtrl::LCtrl
LCtrl Up::
    Send, {Enter}
    WinWait, , , 2, タスク ビュー
    WinGetPos, x, y, w, h, A
    x := x + w / 2
    y := y + h / 2
    MouseMove, %x%, %y%, 10
    return
^h::Send, {Left}
^j::Send, {Down}
^k::Send, {Up}
^l::Send, {Right}

^b::Send, {Left}
^n::Send, {Down}
^p::Send, {Up}
^f::Send, {Right}
^TAB::Send, {TAB}
#IfWinActive


; ------------------------------------------------------------------------------
; fenrir
#IfWinActive ahk_class fenrirMainWindow
^f::Send, {Right}
^b::Send, {Left}
^n::Send, {Down}
^p::Send, {Up}
^d::Send, {Delete}
^a::Send, {Home}
^e::Send, {End}
^i::Send, {Tab}
^w::Send, ^{BS}
#IfWinActive

; ------------------------------------------------------------------------------
; Rapture
#IfWinActive Rapture -
Left::
    MoveCurrentWindow(-648, 0)
    return
Right::
    MoveCurrentWindow(648, 0)
    return
j::
    MoveCurrentWindow(0, 1)
    return

k::
    MoveCurrentWindow(0, -1)
    return
h::
    MoveCurrentWindow(-1, 0)
    return
l::
    MoveCurrentWindow(1, 0)
    return
!Enter::
    MoveCurrentWindow(0, 3)
    Sleep, 50
    MoveCurrentWindow(3, 0)
    Sleep, 50
    MoveCurrentWindow(0, -3)
    Sleep, 50
    MoveCurrentWindow(-3, 0)
    Sleep, 50
    return
Enter::
    WinGet, tp_pre, Transparent, A
    if (tp = "OFF" or tp = "") {
        tp := "OFF"
    } else if (tp_pre > 0) {
        tp := tp_pre
    }
    WinSet, Transparent, 0, A
    return
Enter UP::
    if (tp = "OFF" or tp = "") {
        tp := "OFF"
    }
    WinSet, Transparent, %tp%, A
    return

WheelDown::
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
WheelUp::
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
F1::
    Run, fuchidori.exe
;Esc::
;    WinClose, A
;    return
#IfWinActive

; ------------------------------------------------------------------------------
; LICEcap
#IfWinActive LICEcap
j::
    MoveCurrentWindow(0, 1)
    return

k::
    MoveCurrentWindow(0, -1)
    return
h::
    MoveCurrentWindow(-1, 0)
    return
l::
    MoveCurrentWindow(1, 0)
    return
+j::
    ResizeCurrentWindow(0, 1)
    return

+k::
    ResizeCurrentWindow(0, -1)
    return
+h::
    ResizeCurrentWindow(-1, 0)
    return
+l::
    ResizeCurrentWindow(1, 0)
    return
#IfWinActive

; ------------------------------------------------------------------------------
; Win + 上下左右 による最大化
+#Left::
+#Right::
+#Up::
+#Down::
;#Left::
;#Right::
#Up::
#Down::
    ; X軸 or Y軸方向を半分サイズに
    WinGet, WID, ID, A
    WinGet, isMaximize, MinMax, ahk_id %WID%
    WinGetPos, NowX, NowY, NowW, NowH, ahk_id %WID%

    if (isMaximize == 1) {
        WinRestore, ahk_id %WID%
        NowX += 8
        NowY += 8
        NowW -= 16
        NowH -= 16
    } else if (RegExMatch(A_ThisHotkey, "^#")) {
        ; shift無しの場合は、画面に対しての半分の領域を確保する
        Gui, New
        Gui, +MaximizeBox
        Gui, Show, hide W%NowW% H%NowH% X%NowX% Y%NowY%, __maximize__

        WinGet, WID_MAXIMIZE, ID, __maximize__
        WinSet, Transparent, 10, ahk_id %WID_MAXIMIZE%
        WinMaximize, ahk_id %WID_MAXIMIZE%

        WinGetPos, NowX, NowY, NowW, NowH, ahk_id %WID_MAXIMIZE%
        Sleep, 50
        Gui, Destroy
    }

    if (RegExMatch(A_ThisHotkey, "Left")) {
        NowW := NowW / 2
    } else if (RegExMatch(A_ThisHotkey, "Right")) {
        NowX := NowX + (NowW / 2)
        NowW := NowW / 2
    } else if (RegExMatch(A_ThisHotkey, "Up")) {
        NowH := NowH / 2
    } else if (RegExMatch(A_ThisHotkey, "Down")) {
        NowY := NowY + (NowH / 2)
        NowH := NowH / 2
    }

    WinMove, ahk_id %WID%, , %NowX%, %NowY%, %NowW%, %NowH%
    return

; ------------------------------------------------------------------------------
; ToggleApp()
; 直前のアプリケーションを記憶しておき、入れ替えるコマンド
ToggleApp() {
    global toggle_app_list

    ToggleAppPushCurrentApp()

    For i, x in toggle_app_list {
        WinGetTitle, t, ahk_id %x%
        if (i > 0 && t != "" && !ToggleAppSkip(t)) {
            WinActivate, ahk_id %x%
            ToggleAppPushCurrentApp()
            Break
        }
    }
    ToggleAppDumpApp()
}

; この関数を定期処理に差し込む
ToggleAppPushCurrentApp() {
    global toggle_app_list

    if (!IsObject(toggle_app_list)) {
        toggle_app_list := Object()
    }

    WinGet, app, , A
    app := app + 0
    For i, x in toggle_app_list {
        if (x == app) {
            toggle_app_list.Remove(i)
        }
    }
    toggle_app_list.Insert(0, app)
}

; titleベースでskipする場合はtrueを返す
ToggleAppSkip(title) {
    if (title == "") {
    } else if (title == "スタート メニュー") {
    } else if (title == "タスクの切り替え") {
    } else if (title == "Program Manager") {
    } else if (title == "CLaunch") {
    } else if (title == "cltc ver.0.8.6") {
    } else {
        return false
    }
    return true
}

ToggleAppDumpApp() {
    global toggle_app_list
    str := ""
    cnt := 0
    str := "- active -"
    WinGetPos, X, Y, Width, Height, A
    ToolTip, %str%, %X%, %Y%

    SetTimer, ToggleAppRemoveToolTip, 1000
}

ToggleAppRemoveToolTip:
    SetTimer, ToggleAppRemoveToolTip, Off
    ToolTip
    return


; ----------------------------------------------------------------------------
; 標準関数
TimedTrayTip(title, text, time) {
    TrayTip
    TrayTip, %title%, %text%
    SetTimer, RemoveTrayTip, %time%
}

RemoveTrayTip:
    SetTimer, RemoveTrayTip, Off
    TrayTip
    return

MoveCurrentWindow(x_ofs, y_ofs) {
    WinGetPos, X, Y, Width, Height, A
    WinMove, A, , X + x_ofs, Y + y_ofs
}

ResizeCurrentWindow(w_ofs, h_ofs) {
    WinGetPos, X, Y, Width, Height, A
    WinMove, A, , X, Y, Width + w_ofs, Height + h_ofs
}

; ----------------------------------------------------------------------------
; 定期処理
PeriodicProcess500ms:
    pp_new_h := A_Hour
    pp_new_m := A_Min
    pp_new_s := A_Sec
    if (pp_new_h != pp_h) {
        PeriodicProcess1hour(pp_new_h, pp_new_m, pp_new_s)
    }
    if (pp_new_m  != pp_m) {
        PeriodicProcess1min(pp_new_h, pp_new_m, pp_new_s)
    }
    if (pp_new_s  != pp_s) {
        PeriodicProcess1sec(pp_new_h, pp_new_m, pp_new_s)
    }
    pp_h := pp_new_h
    pp_m := pp_new_m
    pp_s := pp_new_s
    return

PeriodicProcess1hour(h, m, s) {

}

PeriodicProcess1min(h, m, s) {
    if (h == 12 && m == 30) {
        ; 例) 毎日12:30に定期実行する
    }
}

PeriodicProcess1sec(h, m, s) {
    ToggleAppPushCurrentApp()
}

; vi:set et ft=ahk:
