; Atari 7800 startup code for cc65
;
; Source: http://7800.8bitdev.org/index.php/7800AsmDevKit
;
; SainT / RetroHQ (cc65@retrohq.com), 2019
;

        .export         __STARTUP__ : absolute = 1      ; Mark as startup
        .export         _exit
        .import         __ROM_START__
        .import         __RAM3_START__, __RAM3_SIZE__
        .import         initlib, donelib
        .import         copydata
        .import         push0, _main
		.import			NMI, IRQ
		.export			WEAKRTI

        .include        "zeropage.inc"
        .include        "atari7800.inc"

.segment "STARTUP"
start:
        sei                     ;Disable interrupts
        cld                     ;Clear decimal mode
    

;******** Atari recommended startup procedure

        lda     #$07
        sta     INPTCTRL        ;Lock into 7800 mode
        lda     #$7F
        sta     CTRL            ;Disable DMA
        lda     #$00            
        sta     OFFSET
        sta     INPTCTRL
        ldx     #$FF            ;Reset stack pointer
        txs
    
;************** Clear zero page and hardware ******

        ldx     #$40
        lda     #$00
crloop1:
        sta     $00,x           ;Clear zero page
        sta     $100,x          ;Clear page 1
        inx
        bne     crloop1

;************* Clear RAM **************************

        ldy     #$00            ;Clear Ram
        lda     #$18            ;Start at $1800
        sta     $81             
        lda     #$00
        sta     $80
crloop3:
        lda     #$00
        sta     ($80),y         ;Store data
        iny                     ;Next byte
        bne     crloop3         ;Branch if not done page
        inc     $81             ;Next page
        lda     $81
        cmp     #$20            ;End at $1FFF
        bne     crloop3         ;Branch if not

        ldy     #$00            ;Clear Ram
        lda     #$22            ;Start at $2200
        sta     $81             
        lda     #$00
        sta     $80
crloop4:
        lda     #$00
        sta     ($80),y         ;Store data
        iny                     ;Next byte
        bne     crloop4         ;Branch if not done page
        inc     $81             ;Next page
        lda     $81
        cmp     #$27            ;End at $27FF
        bne     crloop4         ;Branch if not

        ldx     #$00
        lda     #$00
crloop5:                        ;Clear 2100-213F
        sta     $2100,x
        inx
        cpx     #$40
        bne     crloop5

        jsr     copydata
        jsr     initlib

        ; Call main program (pass empty command line)
        jsr     push0           ; argc
        jsr     push0           ; argv
        ldy     #4              ; Argument size
        jsr     _main

_exit:
        jsr     donelib
        jmp     start

WEAKRTI:
		rti						;used for weak RTI assignment to NMI and IRQ

        .segment "ENCRYPTION"
        .res    126, $ff                            ; Reserved for encryption
        .byte   $ff                                 ; fff8 : Region verification (always $ff)
        .byte   <(((__ROM_START__/4096)<<4) | 7)    ; fff9 : Start area for hashing

        .segment "VECTORS"
        .word   NMI
        .word   start
        .word   IRQ
