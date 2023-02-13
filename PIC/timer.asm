
_Timer1Interrupt:
	LNK	#0
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;timer.c,4 :: 		void Timer1Interrupt() iv IVT_ADDR_T1INTERRUPT{
;timer.c,5 :: 		if(IFS0bits.T1IF==1)
	BTSS	IFS0bits, #3
	GOTO	L_Timer1Interrupt0
;timer.c,7 :: 		millis_count++;     //increment millisecond count
	MOV	#1, W1
	MOV	#0, W2
	MOV	#lo_addr(_millis_count), W0
	ADD	W1, [W0], [W0++]
	ADDC	W2, [W0], [W0--]
;timer.c,8 :: 		has_updated = 1;    //note an update has occured
	MOV	#lo_addr(_has_updated), W0
	BSET	[W0], BitPos(_has_updated+0)
;timer.c,9 :: 		T1IF_bit=0;
	BCLR	T1IF_bit, BitPos(T1IF_bit+0)
;timer.c,10 :: 		}
L_Timer1Interrupt0:
;timer.c,11 :: 		}
L_end_Timer1Interrupt:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	ULNK
	RETFIE
; end of _Timer1Interrupt

_setupTimer:
	LNK	#0

;timer.c,13 :: 		void setupTimer()
;timer.c,16 :: 		T1CON            = 0x8020;
	MOV	#32800, W0
	MOV	WREG, T1CON
;timer.c,17 :: 		T1IE_bit         = 1;
	BSET	T1IE_bit, BitPos(T1IE_bit+0)
;timer.c,18 :: 		T1IF_bit         = 0;
	BCLR	T1IF_bit, BitPos(T1IF_bit+0)
;timer.c,19 :: 		IPC0             = IPC0 | 0x1000;
	MOV	#4096, W1
	MOV	#lo_addr(IPC0), W0
	IOR	W1, [W0], [W0]
;timer.c,20 :: 		PR1              = 25000;
	MOV	#25000, W0
	MOV	WREG, PR1
;timer.c,21 :: 		}
L_end_setupTimer:
	ULNK
	RETURN
; end of _setupTimer

_millis:
	LNK	#0

;timer.c,23 :: 		unsigned long millis(void)
;timer.c,26 :: 		do {
L_millis1:
;timer.c,27 :: 		has_updated = 0;    //so we can detect an update
	MOV	#lo_addr(_has_updated), W0
	BCLR	[W0], BitPos(_has_updated+0)
;timer.c,28 :: 		temp = millis_count;    //fetch current count
; temp start address is: 4 (W2)
	MOV	_millis_count, W2
	MOV	_millis_count+2, W3
;timer.c,29 :: 		} while (has_updated);
	MOV	#lo_addr(_has_updated), W0
	BTSC	[W0], BitPos(_has_updated+0)
	GOTO	L_millis1
;timer.c,30 :: 		return temp;   //return if no update occurred
	MOV.D	W2, W0
; temp end address is: 4 (W2)
;timer.c,31 :: 		}
L_end_millis:
	ULNK
	RETURN
; end of _millis
