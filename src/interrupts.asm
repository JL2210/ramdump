; Copyright 2020 James Larrowe
;
; This file is part of RAMDump.
;
; RAMDump is licensed under the MIT license; for more details,
; see the file LICENSE in the root of this repository.

INCLUDE "addrs.inc"

SECTION "interrupts", ROM0[$0040]
vblank:
	reti
	ds 8 - (@ - vblank)
lcd_stat:
	reti
	ds 8 - (@ - lcd_stat)
timer:
	reti
	ds 8 - (@ - timer)
serial:
	reti
	ds 8 - (@ - serial)
joypad:
	reti
