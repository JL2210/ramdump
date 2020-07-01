; Copyright 2020 James Larrowe
;
; This file is part of RAMDump.
;
; RAMDump is licensed under the MIT license; for more details,
; see the file LICENSE in the root of this repository.

SECTION "resets", ROM0[$0000]
rst_00:
	ret
	ds 8 - (@ - rst_00)
rst_08:
	ret
	ds 8 - (@ - rst_08)
rst_10:
	ret
	ds 8 - (@ - rst_10)
rst_18:
	ret
	ds 8 - (@ - rst_18)
rst_20:
	ret
	ds 8 - (@ - rst_20)
rst_28:
	ret
	ds 8 - (@ - rst_28)
rst_30:
	ret
	ds 8 - (@ - rst_30)
rst_38:
	ret
	ds 8 - (@ - rst_38)
