; Copyright 2020 James Larrowe
;
; This file is part of RAMDump.
;
; RAMDump is licensed under the MIT license; for more details,
; see the file LICENSE in the root of this repository.

INCLUDE "addrs.inc"

INCLUDE "hardware.inc"

INCLUDE "res/done.asm"

SECTION "start", ROM0[$100]
_start:
	nop
	jp main
	ds $150 - @

SECTION "main", ROM0[$150]
main::
	; the boot ROM passes control during VBlank
	; take this opportunity to disable the LCD
	xor a
	ldh [rLCDC], a

	; set the scroll registers to 0
	ldh [rSCX], a
	ldh [rSCY], a

	; disable interrupts
	ldh [rIE], a

	; now set the palette
	ld a, %11100100
	ldh [rBGP], a

	ASSERT (doneTilesEnd - doneTiles) % 2 == 0

	; copy background tiles
	ld hl, vBGTiles + (8 * 2)
	ld sp, doneTiles
REPT (doneTilesEnd - doneTiles) / 2
	pop de
	ld a, e
	ld [hl+], a
	ld a, d
	ld [hl+], a
ENDR

	; generate tilemap
	ld hl, _SCRN0
	xor a
REPT (doneTilesEnd - doneTiles) / (8 * 2)
	inc a
	ld [hl+], a
ENDR

	; Enable SRAM
	ld a, CART_RAM_ENABLE
	ld [rRAMG], a

	; copy Work RAM to SRAM
	ld hl, _SRAM
	ld sp, _RAM
REPT $2000 / 2
	pop de
	ld a, e
	ld [hl+], a
	ld a, d
	ld [hl+], a
ENDR

	assert CART_RAM_DISABLE == 0
	xor a
	ld [rRAMG], a ; disable cart RAM

	ld a, LCDCF_ON | LCDCF_BGON | LCDCF_BG9800
	ldh [rLCDC], a

	ei ; enable interrupts to low-power hang
.lockup:
	halt
	; unreachable, IE==0
	jr .lockup
