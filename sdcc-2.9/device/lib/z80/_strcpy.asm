;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Apr  7 2010) (MINGW32)
; This file was generated Sun Apr 11 14:38:23 2010
;--------------------------------------------------------
	.module _strcpy
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strcpy
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area _OVERLAY
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;../_strcpy.c:29: char * strcpy (
;	---------------------------------
; Function strcpy
; ---------------------------------
_strcpy:
	push	ix
	ld	ix,#0
	add	ix,sp
;../_strcpy.c:34: register char * to = d;
	ld	c,4 (ix)
	ld	b,5 (ix)
;../_strcpy.c:35: register char * from = s;
	ld	e,6 (ix)
	ld	d,7 (ix)
;../_strcpy.c:37: while (*to++ = *from++) ;
00101$:
	ld	a,(de)
	inc	de
	ld	(bc),a
	inc	bc
	or	a,a
	jr	NZ,00101$
;../_strcpy.c:39: return d;
	ld	l,4 (ix)
	ld	h,5 (ix)
	pop	ix
ret
	.area _CODE
	.area _CABS