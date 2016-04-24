section .data
hex	db	"\x"
hexL	equ	$-hex
space	equ	0x20
colon	equ	0x3a
tab	equ	0x9


section .bss
buffS	equ	1024
buff	resb	buffS

section .text
	global	start

start:

read:
	mov	eax,3
	xor	ebx,ebx
	mov	ecx,buff
	mov	edx,buffS
	int	0x80

	cmp	eax,0
	je	exit

	mov	esi,eax
	mov	edi,buff
scan:
	cmp	byte [edi],colon
	jne	skip
	cmp	byte [edi+1],tab
	jne	skip
	mov	ebp,1
printhex:
	mov	eax,4
	mov	ebx,1
	mov	ecx,hex
	mov	edx,hexL
	int	0x80
printbyte:
	inc	ebp
	cmp	ebp,128
	jg	exit
	mov	eax,4
	mov	ebx,1
	lea	ecx,[edi+ebp]
	mov	edx,1
	int	0x80

	inc	ebp
	mov	eax,4
	mov	ebx,1
	lea	ecx,[edi+ebp]
	mov	edx,1
	int	0x80

	inc	ebp
	mov	eax,[edi+ebp]
	mov	ebx,[edi+ebp+1]
	cmp	al,bl
	jne	printhex
skip:
	inc	edi
	dec	esi
	jnz	scan

	jmp	start
exit:
	mov	eax,1
	xor	ebx,ebx
	int	0x80
