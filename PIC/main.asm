
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68
	LNK	#4

;main.c,6 :: 		void main()
;main.c,9 :: 		setupTimer();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	_setupTimer
;main.c,10 :: 		setupI2c();
	CALL	_setupI2c
;main.c,12 :: 		while(1)
L_main0:
;main.c,14 :: 		for(i=0;i<32;i++)
	CLR	W0
	MOV.B	W0, [W14+0]
L_main2:
	MOV.B	[W14+0], W1
	MOV.B	#32, W0
	CP.B	W1, W0
	BRA LTU	L__main10
	GOTO	L_main3
L__main10:
;main.c,15 :: 		I2C_writeData[i]=rand();
	ADD	W14, #0, W0
	ZE	[W0], W1
	MOV	#lo_addr(_I2C_writeData), W0
	ADD	W0, W1, W0
	MOV	W0, [W14+2]
	CALL	_rand
	MOV	[W14+2], W1
	MOV.B	W0, [W1]
;main.c,14 :: 		for(i=0;i<32;i++)
	MOV.B	#1, W1
	ADD	W14, #0, W0
	ADD.B	W1, [W0], [W0]
;main.c,15 :: 		I2C_writeData[i]=rand();
	GOTO	L_main2
L_main3:
;main.c,17 :: 		sendMultipleDataViaI2c(addressArduino,20,I2C_writeData);
	MOV	#lo_addr(_I2C_writeData), W12
	MOV.B	#20, W11
	MOV	_addressArduino, W10
	CALL	_sendMultipleDataViaI2c
;main.c,18 :: 		Delay_ms(1);
	MOV	#1666, W7
L_main5:
	DEC	W7
	BRA NZ	L_main5
	NOP
	NOP
;main.c,19 :: 		receiveMultipleDataViaI2c(addressArduino,20,I2C_readData);
	MOV	#lo_addr(_I2C_readData), W12
	MOV.B	#20, W11
	MOV	_addressArduino, W10
	CALL	_receiveMultipleDataViaI2c
;main.c,20 :: 		Delay_ms(1);
	MOV	#1666, W7
L_main7:
	DEC	W7
	BRA NZ	L_main7
	NOP
	NOP
;main.c,21 :: 		}
	GOTO	L_main0
;main.c,22 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
	ULNK
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
