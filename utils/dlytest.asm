	cseg

bdos	equ	5

start::
	mvi	c,141	; delay
	lxi	d,50	; 50 ticks/sec
	call	bdos
	lxi	d,msg
	mvi	c,9
	call	bdos
	jmp	start

msg:	db	'+++ 1 sec +++',0dh,0ah,'$'

	end	start
