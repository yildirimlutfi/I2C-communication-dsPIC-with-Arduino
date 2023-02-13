
_setupI2c:
	LNK	#0

;i2c.c,1 :: 		void setupI2c()
;i2c.c,3 :: 		I2C2_Init(122222);// Initialize the I2C1 module with clock_rate of 100000. Init value wrote 122222 because arduino clock rate faster than PIC.
	PUSH	W10
	PUSH	W11
	MOV	#56686, W10
	MOV	#1, W11
	CALL	_I2C2_Init
;i2c.c,4 :: 		}
L_end_setupI2c:
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of _setupI2c

_sendMultipleDataViaI2c:
	LNK	#0

;i2c.c,6 :: 		void sendMultipleDataViaI2c(char address,char length ,char *data_)
;i2c.c,9 :: 		I2C2_Start();
	PUSH	W10
	CALL	_I2C2_Start
;i2c.c,10 :: 		I2C2_Write(address<<1);//send address byte via I2C doing shift 1 bit
	ZE	W10, W0
	SL	W0, #1, W0
	MOV.B	W0, W10
	CALL	_I2C2_Write
;i2c.c,12 :: 		for(i=0;i<length;i++)
; i start address is: 2 (W1)
	CLR	W1
; i end address is: 2 (W1)
L_sendMultipleDataViaI2c0:
; i start address is: 2 (W1)
	CP.B	W1, W11
	BRA LTU	L__sendMultipleDataViaI2c8
	GOTO	L_sendMultipleDataViaI2c1
L__sendMultipleDataViaI2c8:
;i2c.c,14 :: 		I2C2_Write(data_[i]  );//send 1 byte data
	ZE	W1, W0
	ADD	W12, W0, W0
	PUSH	W10
	MOV.B	[W0], W10
	CALL	_I2C2_Write
	POP	W10
;i2c.c,12 :: 		for(i=0;i<length;i++)
	INC.B	W1
;i2c.c,15 :: 		}
; i end address is: 2 (W1)
	GOTO	L_sendMultipleDataViaI2c0
L_sendMultipleDataViaI2c1:
;i2c.c,16 :: 		I2C2_Stop();
	CALL	_I2C2_Stop
;i2c.c,17 :: 		}
L_end_sendMultipleDataViaI2c:
	POP	W10
	ULNK
	RETURN
; end of _sendMultipleDataViaI2c

_receiveMultipleDataViaI2c:
	LNK	#2

;i2c.c,19 :: 		void receiveMultipleDataViaI2c(char address,char length, char *data_)
;i2c.c,22 :: 		I2C2_Start();
	PUSH	W10
	CALL	_I2C2_Start
;i2c.c,23 :: 		I2C2_Write(address<<1 | 0x01);//0x01 necessary for arduino request event
	ZE	W10, W0
	SL	W0, #1, W0
	IOR	W0, #1, W0
	MOV.B	W0, W10
	CALL	_I2C2_Write
;i2c.c,24 :: 		for(i=0;i<length;i++)
; i start address is: 4 (W2)
	CLR	W2
; i end address is: 4 (W2)
L_receiveMultipleDataViaI2c3:
; i start address is: 4 (W2)
	CP.B	W2, W11
	BRA LTU	L__receiveMultipleDataViaI2c10
	GOTO	L_receiveMultipleDataViaI2c4
L__receiveMultipleDataViaI2c10:
;i2c.c,26 :: 		data_[i] = I2C2_Read(_I2C_ACK);//read 1 byte data
	ZE	W2, W0
	ADD	W12, W0, W0
	MOV	W0, [W14+0]
	PUSH	W10
	CLR	W10
	CALL	_I2C2_Read
	POP	W10
	MOV	[W14+0], W1
	MOV.B	W0, [W1]
;i2c.c,24 :: 		for(i=0;i<length;i++)
	INC.B	W2
;i2c.c,27 :: 		}
; i end address is: 4 (W2)
	GOTO	L_receiveMultipleDataViaI2c3
L_receiveMultipleDataViaI2c4:
;i2c.c,28 :: 		I2C2_Stop();
	CALL	_I2C2_Stop
;i2c.c,29 :: 		}
L_end_receiveMultipleDataViaI2c:
	POP	W10
	ULNK
	RETURN
; end of _receiveMultipleDataViaI2c
