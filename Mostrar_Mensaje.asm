;INSTITUTO POLITECNICO NACIONAL
 ;CECYT 9 JUAN DE DIOS BATIZ
 ;
 ;PRACITCA 3:
 ;Manipulación de Displays con el PIC16F877A
 ;
 ;GRUPO: 5IM2. EQUIPO: 05
 ;
 ;INTEGRANTES:
 ;1.- Alvarez Flores Ian Salvador
 ;2.- Bello Sanchez Santiago Yolotzin
 ;3.- Luna Bautista Luis Daniel
 ;4.- Urtado Portillo Arturo Leonardo
 ;COMENTARIO: ESTE PROGRAMA MUESTRA  CARACTERES EN 7 SEGMENTOS.
;----------------------------------------------------------------

  list p=16f877A;

  #include "E:\Olivares\P16F877A.INC";

 ;Bits de configuración.
 __config _XT_OSC & _WDT_OFF & _PWRTE_ON & _BODEN_OFF & _LVP_OFF & _CP_OFF ; ALL
;------------------------------------------------------------------------------
;
;fosc = 4 MHz.
;Ciclo de trabajo del PIC = (1/fosc)*4 = 1us.
;t int = (256-R) * (P) * ((1/3579545)*4);= 1.0012 ms ;// Tiempo de interrupcion.
;R=249, P=126.
;frec int = 1/ t int = 874 Hz.
;-------------------------------------------------------------------------------------
;
; Registros de propósito general Banco 0 de memoria RAM.
;
; Registros propios de estructura del programa
; Variables.
Contador1	equ	0x20; //
Contador2	equ	0x21; //
Contador3	equ	0x22; //

;----------------------------------------------------------------------------------------
;
;Constantes.
M	equ	.18;
N	equ	.225;
L	equ	.255;

;Constantes de caracteres en siete segmentos.
		;dpgfedcba
Car_A		equ b'01110111'; Caracter A en siete segmentos.
Car_b		equ b'01111100'; Carácter b en siete segmentos.
Car_C		equ b'00111001'; Caracter C en siete segmentos.
Car_cc		equ b'01011000'; Caracter c en siete segmentos.
Car_d		equ b'01011110'; Caracter d en siete segmentos.
Car_E		equ b'01111001'; Caracter E en siete segmentos.
Car_F		equ b'01110001'; Caracter F en siete segmentos.
Car_G		equ b'01111101'; Caracter G en siete segmentos.
Car_gg		equ b'01101111'; Caracter g en siete segmentos.
Car_H		equ b'01110110'; Caracter H en siete segmentos.
Car_hh		equ b'01110100'; Caracter h en siete segmentos.
Car_i		equ b'00000100'; Caracter i en siete segmentos.
Car_J		equ b'00011110'; Caracter J en siete segmentos.
Car_L		equ b'00111000'; Caracter L en siete segmentos.
Car_n		equ b'01010100'; Caracter n en siete segmentos.
Car_ñ		equ b'01010101'; Caracter ñ en siete segmentos.
Car_o		equ b'01011100'; Caracter o en siete segmentos.
Car_p		equ b'01110011'; Caracter p en siete segmentos.
Car_q		equ b'01100111'; Caracter q en siete segmentos.
Car_r		equ b'01010000'; Caracter r en siete segmentos.
Car_S		equ b'01101101'; Caracter s en siete segmentos.
Car_t		equ b'01111000'; Caracter t en siete segmentos.
Car_U		equ b'00111110'; Caracter U en siete segmentos.
Car_uu		equ b'00111100'; Caracter u en siete segmentos.
Car_v		equ b'00011100'; Caracter u en siete segmentos.
Car_Y		equ b'01101110'; Caracter y en siete segmentos.
Car_Z		equ b'01011011'; Caracter z en siete segmentos.
Car_0		equ b'00111111'; Caracter 0 en siete segmentos.
Car_1		equ b'00000110'; Caracter 1 en siete segmentos.
Car_2		equ b'01011011'; Caracter 2 en siete segmentos.
Car_3		equ b'01001111'; Caracter 3 en siete segmentos.
Car_4		equ b'01100110'; Caracter 4 en siete segmentos.
Car_5		equ b'01101101'; Caracter 5 en siete segmentos.
Car_6		equ b'01111101'; Caracter 6 en siete segmentos.
Car_7		equ b'00000111'; Caracter 7 en siete segmentos.
Car_8		equ b'01111111'; Caracter 8 en siete segmentos.
Car_9		equ b'01100111'; Caracter 9 en siete segmentos.

Car_		equ b'00001000'; Caracter _ en siete segmentos.
Car_null	equ b'00000000'; Caracter nulo en siete segmentos.
Car_guion	equ b'01000000'; Caracter - en siete segmentos.
;---------------------------------------------------------------------
;
;Asignación de los bits de los puertos I/O.
;Puerto A.
Sin_UsoRA0	equ	.0; // Sin Uso RA0.
Sin_UsoRA1	equ	.1; // Sin Uso RA1.
Sin_UsoRA2	equ	.2; // Sin Uso RA2.
Sin_UsoRA3	equ	.3; // Sin Uso RA3.
Sin_UsoRA4	equ	.4; // Sin Uso RA4.
Sin_UsoRA5	equ	.5; // Sin Uso RA5.

proga		equ	b'111111'; // Programación inicial del Puerto A.

 ;Puerto B.
Seg_a	equ	.0; // Salida para enviar el bit D0 del segmento a.
Seg_b	equ	.1; // Salida para enviar el bit D1 del segmento b. 
Seg_c	equ	.2; // Salida para enviar el bit D2 del segmento c. 
Seg_d	equ	.3; // Salida para enviar el bit D3 del segmento d. 
Seg_e	equ	.4; // Salida para enviar el bit D4 del segmento e. 
Seg_f	equ	.5; // Salida para enviar el bit D5 del segmento f. 
Seg_g	equ	.6; // Salida para enviar el bit D6 del segmento g. 
Seg_dp	equ	.7; // Salida para enviar el bit D7 del segmento dp.

progb		equ	b'00000000'; // Programación inicial del Puerto B.

 ;Puerto C.  
clk_pt0		equ	.0; // Salida para controlar el pulso clk del pto. del digito 1.
clk_pt1		equ	.1; // Salida para controlar el pulso clk del pto. del digito 2.
clk_pt2		equ	.2; // Salida para controlar el pulso clk del pto. del digito 3.
clk_pt3		equ	.3; // Salida para controlar el pulso clk del pto. del digito 4. 
clk_pt4		equ	.4; // Salida para controlar el pulso clk del pto. del digito 5.
clk_pt5		equ	.5; // Salida para controlar el pulso clk del pto. del digito 6.
clk_pt6		equ	.6; // Salida para controlar el pulso clk del pto. del digito 7.
clk_pt7		equ	.7; // Salida para controlar el pulso clk del pto. del digito 8.

progc		equ b'00000000'; // Prgramación inicial del Puerto C como entrada.

;Puerto D.
Sin_UsoRD0	equ	.0; // Sin Uso RD0.
Sin_UsoRD1	equ	.1; // Sin Uso RD1.
Sin_UsoRD2	equ	.2; // Sin Uso RD2.
Sin_UsoRD3	equ	.3; // Sin Uso RD3.
Sin_UsoRD4	equ	.4; // Sin Uso RD4.
Sin_UsoRD5	equ	.5; // Sin Uso RD5.
Sin_UsoRD6	equ	.6; // Sin Uso RD6.
Sin_UsoRD7	equ	.7; // Sin Uso RD7.

progd		equ b'11111111'; // Programación inicial del Puerto D como entrada.

;Puerto E.
Sin_UsoRE0	equ	.0; // Sin Uso RE0.
Sin_UsoRE1	equ	.1; // Sin Uso RE1.
Led_Op		equ	.2; // Led sistema en operación.

proge		equ	b'011'; // Programación inicial del Puerto E.
;------------------------------------------------------------------------------------------------


		;==================
		;== Vector reset ==
		;==================
		org 0x0000;
vec_reset	clrf pclath; Asegura la pagina cero de la mem: de  prog.
		goto prog_prin;
;--------------------------------------------------------------------------------------------------


		;============================
		;== Vector de interrupcion ==
		;============================
		org 0x0004;
vec_int		nop;


		retfie;

;-----------------------------------------------------------------------------------------------------

		;=========================
		;== Subrutina de inicio ==
		;=========================

prog_ini	bsf status,rp0; select. el bco. 1 de ram.
		movlw 0x61;
		movwf option_reg ^0x80;
		movlw proga;		w<-- b'111111'
		movwf trisa ^0x80;
		movlw progb;
		movwf trisb ^0x80;
		movlw progc;
		movwf trisc ^0x80;
		movlw progd;
		movwf trisd ^0x80;;
		movlw  proge;
		movwf trise ^0x80;
		movlw 0x06;
		movwf adcon1 ^0x80;conf. el pto. a como salida i/o.
		bcf status,rp0;

		movlw 0xff;	W <--- 0XFF
		movwf portc; 	portc <-- w
		
		return;
;---------------------------------------------------------------------------------------------

		;========================
		;== Programa principal ==
		;========================

prog_prin	call prog_ini;

loop_prin	movlw Car_i;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_n;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_S;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_t;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_i;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_t;
		movwf portb;
		bcf portc,clk_pt2
		nop;
		bsf portc,clk_pt2;

		movlw Car_u;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_t;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

	call retardo;

		movlw Car_p;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_o;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_L;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_i;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_t;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_E;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_cc;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_n;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

	call retardo;

		movlw Car_n;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_cc;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_i;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_o;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_n;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_L;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

;==INSTITUTO POLITECNICO NACIONAL

		call retardo;

		movlw Car_C;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_E;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_C;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_Y;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_t;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_9;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

;==CECyT 9

		call retardo;


		movlw Car_J;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_U;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_n;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_d;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_E;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;

		movlw Car_d;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_i;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_o;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_S;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;

		movlw Car_b;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_t;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_i;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_Z;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;
;==JUAN DE DIOS BATIZ

		movlw Car_p;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_r;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_cc;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_t;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_i;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_cc;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;

		movlw Car_3;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;


		movlw Car_n;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_n;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_n;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_i;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_p;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_U;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_L;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;

		movlw Car_d;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_E;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;


		movlw Car_d;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_i;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_S;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_p;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_L;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_Y;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_S;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;

		movlw Car_C;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_o;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_n;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_E;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_L;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;

		movlw Car_p;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_i;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_cc;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_1;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_6;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_F;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_8;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_7;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

;== MANIOULACION DE DISOLAYS CON EL PIC16F877A
		call retardo;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_r;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_q;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_U;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_i;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_t;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_E;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_cc;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;

		movlw Car_t;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_U;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_r;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_d;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_E;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;
;==ARQUITECTURA DE

		movlw Car_n;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_n;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_i;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_cc;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_r;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_o;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_cc;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_o;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;


		movlw Car_p;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_r;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_o;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_F;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_E;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_S;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_o;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_r;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;

		movlw Car_o;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_L;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_i;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_v;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_r;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_E;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_S;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;


		movlw Car_v;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_r;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_gg;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_S;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;


;== OLIVARES VARGAS

		movlw Car_J;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_E;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_S;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_U;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_S;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_L;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_b;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_E;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_r;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_t;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_o;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;

;== OLIVARES VARGAS JESUS ALBERTO

		movlw Car_E;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_q;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_U;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_i;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_p;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_o;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_5;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;
;== EQUIPO 9

		movlw Car_i;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_n;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_t;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_E;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_gg;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_r;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_n;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

;==INTEGRANTES

		call retardo;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_L;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_v;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_r;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_E;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_S;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;
	
		movlw Car_F;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_L;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_o;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_r;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_E;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_S;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;


		movlw Car_i;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_n;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;


		movlw Car_S;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_L;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_v;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_d;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_o;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_r;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

;==Alvarez Flores Ian Salvador

		call retardo;

		movlw Car_b;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_E;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_L;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_L;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_o;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;

		movlw Car_S;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_n;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_cc;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_hh;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_E;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_Z;
		movwf portb
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;

		movlw Car_S;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_n;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_t;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_i;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_gg;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_o;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

;== Bello Sanchez Santiago

		call retardo;

		movlw Car_L;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_U;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_n;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;


		movlw Car_b;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_U;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_t;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_i;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_S;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_t;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;


		movlw Car_L;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_U;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_i;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_S;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;



		movlw Car_d;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_n;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_i;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_E;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_L;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

;== Luna Bautista Luis Daniel

		call retardo;


		movlw Car_U;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_r;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_t;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_d;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_o;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;

		movlw Car_P;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_o;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_r;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_t;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_i;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_L;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_L;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_o;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_r;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_t;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_U;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_r;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_o;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_null;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;

		movlw Car_L;
		movwf portb;
		bcf portc,clk_pt7;
		nop;
		bsf portc,clk_pt7;

		movlw Car_E;
		movwf portb;
		bcf portc,clk_pt6;
		nop;
		bsf portc,clk_pt6;

		movlw Car_o;
		movwf portb;
		bcf portc,clk_pt5;
		nop;
		bsf portc,clk_pt5;

		movlw Car_n;
		movwf portb;
		bcf portc,clk_pt4;
		nop;
		bsf portc,clk_pt4;

		movlw Car_A;
		movwf portb;
		bcf portc,clk_pt3;
		nop;
		bsf portc,clk_pt3;

		movlw Car_r;
		movwf portb;
		bcf portc,clk_pt2;
		nop;
		bsf portc,clk_pt2;

		movlw Car_d;
		movwf portb;
		bcf portc,clk_pt1;
		nop;
		bsf portc,clk_pt1;

		movlw Car_o;
		movwf portb;
		bcf portc,clk_pt0;
		nop;
		bsf portc,clk_pt0;

		call retardo;
;---------------------------------------------------------------------------------------------

		;=========================
		;== Subrutina de retardo==
		;=========================
retardo		movlw M;
		movwf Contador3;
Loop3		movlw N;
		movwf Contador2;
Loop2		movlw L;
		movwf Contador1;
Loop1 		decfsz Contador1,f;
		goto Loop1;
		decfsz Contador2,f;
		goto Loop2;
		decfsz Contador3,f;
		goto Loop3;
		
		return;
;------------------------------------------------------------------------------------------------

		end
