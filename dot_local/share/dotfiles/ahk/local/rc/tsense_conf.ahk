#IfWinExist, __tsense_mode_win

; ----------------------------------------------------------------------------
; window
tsense_bgcolor      := "FFFF99"
tsense_transeparent := 210

; ----------------------------------------------------------------------------
; key bind
^h::MouseMove, -16,   0, 0, R
^j::MouseMove,   0,  16, 0, R
^k::MouseMove,   0, -16, 0, R
^l::MouseMove,  16,   0, 0, R
;+h::MouseMove,  -8,   0, 0, R
;+j::MouseMove,   0,   8, 0, R
;+k::MouseMove,   0,  -8, 0, R
;+l::MouseMove,   8,   0, 0, R
j::Down
k::Up
h::Left
l::Right
n::Send, {WheelDown}
p::Send, {WheelUp}
+n::Send, {PgDn}
+p::Send, {PgUp}
i::Tab

f::LButton
d::RButton
c::MButton
g::XButton1
b::XButton2
w::WinClose, A
a::Send, {HOME}
e::Send, {END}
v::Send, {LButton}{LButton}
t::WinGetTitle, clipboard, A
m::Send, {ENTER}

r::ToggleMaximize(0)
+r::ToggleMaximize(1)
^r::ToggleMaximize(2)

z::StartEasyWindowDrag()
z Up::EndEasyWindowDrag()
x::StartEasyWindowResize()
x Up::EndEasyWindowResize()
s::GoTo, esmb_TriggerKeyDown
s Up::GoTo, esmb_TriggerKeyUp

^3::WinSet, AlwaysOnTop, Toggle, A
1::F1
2::F2
3::F3
4::F4
5::F5
6::F6
7::F7
8::F8
9::F9
0::F10
-::F11
^::F12

Left::Home
Right::End
Up::PgUp
Down::PgDn
BackSpace::Delete

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
; ----------------------------------------------------------------------------
#IfWinExist
