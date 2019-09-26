; Atari 7800 MARIA registers
;
; Source: http://7800.8bitdev.org/index.php/7800AsmDevKit
;
; SainT / RetroHQ (cc65@retrohq.com), 2019

INPTCTRL := $01     ;Input control. In same address space as TIA. write-only
VBLANK   := $01     ;VBLANK. D7=1:dump paddle caps to ground.     write-only
INPT0    := $08     ;Paddle Control Input 0                       read-only
INPT1    := $09     ;Paddle Control Input 1                       read-only
INPT2    := $0A     ;Paddle Control Input 2                       read-only
INPT3    := $0B     ;Paddle Control Input 3                       read-only

; ** some common alternate names for INPT0/1/2/3
INPT4B   := $08     ;Joystick 0 Fire 1                            read-only
INPT4A   := $09     ;Joystick 0 Fire 1                            read-only
INPT5B   := $0A     ;Joystick 1 Fire 0                            read-only
INPT5A   := $0B     ;Joystick 1 Fire 1                            read-only
INPT4R   := $08     ;Joystick 0 Fire 1                            read-only
INPT4L   := $09     ;Joystick 0 Fire 1                            read-only
INPT5R   := $0A     ;Joystick 1 Fire 0                            read-only
INPT5L   := $0B     ;Joystick 1 Fire 1                            read-only

INPT4    := $0C     ;Player 0 Fire Button Input                   read-only
INPT5    := $0D     ;Player 1 Fire Button Input                   read-only

AUDC0    := $15     ;Audio Control Channel   0                    write-only
AUDC1    := $16     ;Audio Control Channel   1                    write-only
AUDF0    := $17     ;Audio Frequency Channel 0                    write-only
AUDF1    := $18     ;Audio Frequency Channel 1                    write-only
AUDV0    := $19     ;Audio Volume Channel    0                    write-only
AUDV1    := $1A     ;Audio Volume Channel    1                    write-only
