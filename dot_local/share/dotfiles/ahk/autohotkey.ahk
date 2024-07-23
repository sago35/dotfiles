#Requires AutoHotkey v2.0
#SingleInstance
Persistent
CoordMode "Mouse", "Screen"

F1::
{
    WID := WinGetClass("A")
    MsgBox(WID)
    A_Clipboard := wid
}

^+::PrintDate()

PrintDate()
{
    Send(A_YYYY "/" A_MM "/" A_DD)
}

; 変換キーを半角/全角に
;*vk1C::Send('!{vkF3}')

; vk1D == 無変換
vk1D & h::Left
vk1D & j::Down
vk1D & k::Up
vk1D & l::Right

vk1D & f::LButton
vk1D & d::RButton
vk1D & c::MButton
vk1D & v::Send('{LButton}{LButton}')
vk1D & g::XButton1
vk1D & b::XButton2

vk1D & e::End
vk1D & a::Home
vk1D & i::Tab
vk1D & w::WinClose("A")

vk1D & Up::PgUp
vk1D & Down::PgDn
vk1D & Left::Home
vk1D & Right::End

vk1D & Left::Home

vk1D & n::Send('{WheelDown}')
vk1D & p::Send('{WheelUp}')

vk1D & z::EasyWindowMoveStart()
vk1D & z Up::EasyWindowMoveEnd()
vk1D & x::EasyWindowResizeStart()
vk1D & x Up::EasyWindowResizeEnd()
vk1D & r::ToggleMaximizeRunner()
vk1D & t::GetTitle()

vk1D & 1::F1
vk1D & 2::F2
vk1D & 3::F3
vk1D & 4::F4
vk1D & 5::F5
vk1D & 6::F6
vk1D & 7::F7
vk1D & 8::F8
vk1D & 9::F9
vk1D & 0::F10
vk1D & -::F11
vk1D & ^::F12

; vk1C == 変換キー;
;vk1C::Send('!{vkF3}') ; 変換キー単押しを Alt+全角半角に
vk1C & q::1
vk1C & w::2
vk1C & e::3
vk1C & r::4
vk1C & t::5
vk1C & y::6
vk1C & u::7
vk1C & i::8
vk1C & o::9
vk1C & p::0

vk1C & a::-
vk1C & s::^
vk1C & d::\
vk1C & f::[
vk1C & g::]

vk1C & sc027::Enter ; sc027 == semicolon
vk1C & sc028::ESC   ; sc028 == colon
vk1C & @::BackSpace

vk1C & h::Home
vk1C & j::PgDn
vk1C & k::PgUp
vk1C & l::End

vk1C & z::F1
vk1C & x::F2
vk1C & c::F3
vk1C & v::F4
vk1C & b::F5
vk1C & n::F6
vk1C & m::F7
vk1C & ,::F8
vk1C & .::F9
vk1C & /::F10
vk1C & \::F11
vk1C & Left::F12

; for diy keeb
F13::EasyWindowMoveStart() ; z
F13 Up::EasyWindowMoveEnd()
F14::EasyWindowResizeStart() ; x
F14 Up::EasyWindowResizeEnd()
F15::WinClose("A") ; w
F16::Send('{LButton}{LButton}') ; v
F17::ToggleMaximizeRunner() ; r
;+F17::ToggleMaximizeRunner()
F18::GetTitle() ; t

; その他
^h::Send('{BackSpace}')
^Esc::Send('{Esc}')

#Down::ResizeWindow('down')
#Up::ResizeWindow('up')
+#Down::ResizeWindow('down2')
+#Up::ResizeWindow('up2')
+#Right::ResizeWindow('right2')
+#Left::ResizeWindow('left2')

PrintScreen::
{
    profile := EnvGet("USERPROFILE")
    Run(profile "\app\rapture\rapture.exe", profile "\app\rapture")
}

#+z::Reload

^#z::
{
    Sleep 300
    Reload
}

; ------------------------------------------------------------------------------
; Rapture
#HotIf WinActive("Rapture -")
j::
{
    MoveCurrentWindow(0, 1)
    return
}
k::
{
    MoveCurrentWindow(0, -1)
    return
}
h::
{
    MoveCurrentWindow(-1, 0)
    return
}
l::
{
    MoveCurrentWindow(1, 0)
    return
}
Enter::
{
    global rapture_tp_org
    rapture_tp_org := WinGetTransparent()
    WinSetTransparent(0)
    return
}
Enter UP::
{
    global rapture_tp_org
    if (rapture_tp_org == 0) {
        rapture_tp_org := 255
    }
    WinSetTransparent(rapture_tp_org)
    return
}
#HotIf

#WheelDown::
{
    SetTransparent(-5)
}

#WheelUp::
{
    SetTransparent(5)
}

; ----------------------------------------------------------------------------
; MoveCurrentWindow
; ----------------------------------------------------------------------------
MoveCurrentWindow(x_ofs, y_ofs) {
    WinGetPos(&X, &Y, &Width, &Height)
    WinMove(X + x_ofs, Y + y_ofs)
}

; ----------------------------------------------------------------------------
; WinGetTitle
; ----------------------------------------------------------------------------
GetTitle() {
    title := WinGetTitle("A")
    ;MsgBox title
    title := RegExReplace(title, " - [^-\n]+$")
    title := RegExReplace(title, "  -  [^-\n]+$")
    title := RegExReplace(title, " — [^—\n]+$")
    A_Clipboard := title
}

; ----------------------------------------------------------------------------
; ToggleMaximize
; ----------------------------------------------------------------------------
; maximizeLevel = 0 : normal maximize
; maximizeLevel = 1 : maximize without title bar
; maximizeLevel = 2 : maximize without title bar and task bar
ToggleMaximize(maximizeLevel := 0) {
    WID := WinGetID("A")
    isMaximize := WinGetMinMax(WID)
    myStyle := WinGetStyle(WID)

    if (isMaximize == 1 && (maximizeLevel == 0 || (myStyle & 0x00C40000) == 0)) {
        WinRestore(WID)
        if (maximizeLevel) {
            WinSetStyle("+0x00C40000", "ahk_id " WID)
        }
    } else {
        WinMaximize(WID)
        if (maximizeLevel) {
            WinSetStyle("-0x00C40000", "ahk_id " WID)

            if (maximizeLevel == 1) {
                ; maximize without title bar
                MonitorGetWorkArea(1, &WL, &WT, &WR, &WB)
                WinMove(WL, WT, WR, WB, WID)
            } else {
                ; maximize without title bar and task bar
                WinMove(0, 0, A_ScreenWidth, A_ScreenHeight, WID)
            }
        }
    }
}

ToggleMaximizeRunner()
{
    if GetKeyState("Shift", "P") ; Shiftキーが押されているかどうかを確認
    {
        ToggleMaximize(1)
    }
    else
    {
        ToggleMaximize(0)
    }
}

; ----------------------------------------------------------------------------
; ResizeWindow
; ----------------------------------------------------------------------------
ResizeWindow(direction) {
    ; モニタの作業領域を取得
    MonitorGetWorkArea(1, &WL, &WT, &WR, &WB)
    if (direction = "up") {
        NewX := WL
        NewY := WT
        NewW := WR - WL
        NewH := (WB - WT) // 2
    }
    else if (direction = "up2") {
        WinGetPos(&WL, &WT, &WR, &WB, "A")
        NewX := WL
        NewY := WT
        NewW := WR
        NewH := WB // 2
    }
    else if (direction = "down") {
        NewX := WL
        NewY := (WB - WT) // 2
        NewW := WR - WL
        NewH := (WB - WT) // 2
    }
    else if (direction = "down2") {
        WinGetPos(&WL, &WT, &WR, &WB, "A")
        NewX := WL
        NewY := WT + WB // 2
        NewW := WR
        NewH := WB // 2
    }
    else if (direction = "right2") {
        WinGetPos(&WL, &WT, &WR, &WB, "A")
        NewX := WL + WR // 2
        NewY := WT
        NewW := WR // 2
        NewH := WB
    }
    else if (direction = "left2") {
        WinGetPos(&WL, &WT, &WR, &WB, "A")
        NewX := WL
        NewY := WT
        NewW := WR // 2
        NewH := WB
    }

    ; 引数が"up"や"down"以外の場合は、関数を終了
    else {
        return
    }

    ; ウィンドウの移動とサイズ変更
    WinMove(NewX, NewY, NewW, NewH, "A")
}

; ----------------------------------------------------------------------------
; EasyWindowMove
; ----------------------------------------------------------------------------
EasyWindowMoveStart()
{
    global EWM_Enable := false
    global EWM_WID := WinGetID("A")
    global EWM_StartX := 0
    global EWM_StartY := 0

    if (EWM_Enable == false) {
        EWM_Enable := true
        MouseGetPos(&EWM_StartX, &EWM_StartY)
        EWM_WID := WinGetID("A")
        SetTimer EasyWindowMoveTick, 10
    }
}

EasyWindowMoveEnd()
{
    global EWM_Enable

    EWM_Enable := false
    SetTimer EasyWindowMoveTick, False
}


EasyWindowMoveTick()
{
    global EWM_WID
    global EWM_StartX
    global EWM_StartY

    MouseGetPos(&cx, &cy)
    dx := cx - EWM_StartX
    dy := cy - EWM_StartY

    WinGetPos(&x, &y,,, EWM_WID)
    WinMove(x + dx, y + dy,,, EWM_WID)

    ; 初期位置を更新
    EWM_StartX := cx
    EWM_StartY := cy
}

; ----------------------------------------------------------------------------
; EasyWindowResize
; ----------------------------------------------------------------------------
EasyWindowResizeStart()
{
    global EWR_Enable := false
    global EWR_WID := WinGetID("A")
    global EWR_StartX := 0
    global EWR_StartY := 0

    if (EWR_Enable == false) {
        EWR_Enable := true
        MouseGetPos(&EWR_StartX, &EWR_StartY)
        EWR_WID := WinGetID("A")
        SetTimer EasyWindowResizeTick, 10
    }
}

EasyWindowResizeEnd()
{
    global EWR_Enable

    EWR_Enable := false
    SetTimer EasyWindowResizeTick, False
}


EasyWindowResizeTick()
{
    global EWR_WID
    global EWR_StartX
    global EWR_StartY

    MouseGetPos(&cx, &cy)
    dx := cx - EWR_StartX
    dy := cy - EWR_StartY

    WinGetPos(,, &w, &h, EWR_WID)
    WinMove(,, w + dx, h + dy, EWR_WID)

    ; 初期位置を更新
    EWR_StartX := cx
    EWR_StartY := cy
}

; ----------------------------------------------------------------------------
; util
; ----------------------------------------------------------------------------
SetTransparent(x) {
    WID := WinGetID("A")
    t := WinGetTransparent(WID)
    if (t == "") {
        t := 255
    }
    t := t + x
    if (0 <= t && t <= 255) {
        WinSetTransparent(t, WID)
    }
}

; ----------------------------------------------------------------------------
; for debug
; ----------------------------------------------------------------------------
;MyGui := Gui()
;textControl := MyGui.Add("Text", "w400 h400")
;MyGui.Show("w400 h400")
;
;;F1::UpdateText("hello")
;;F2::UpdateText("world")
;
;UpdateText(msg)
;{
;    textControl.Value := msg
;}

; vi:set et ft=ahk:

