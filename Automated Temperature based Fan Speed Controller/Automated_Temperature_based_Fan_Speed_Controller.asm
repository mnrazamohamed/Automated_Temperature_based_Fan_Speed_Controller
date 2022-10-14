
_main:

;Automated_Temperature_based_Fan_Speed_Controller.c,21 :: 		void main()
;Automated_Temperature_based_Fan_Speed_Controller.c,23 :: 		TRISA.RA0 = 1;
	BSF        TRISA+0, 0
;Automated_Temperature_based_Fan_Speed_Controller.c,24 :: 		PORTB =0x01;
	MOVLW      1
	MOVWF      PORTB+0
;Automated_Temperature_based_Fan_Speed_Controller.c,25 :: 		Delay_ms(5000);
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
	NOP
;Automated_Temperature_based_Fan_Speed_Controller.c,26 :: 		TRISE = 0;
	CLRF       TRISE+0
;Automated_Temperature_based_Fan_Speed_Controller.c,27 :: 		TRISD = 0;
	CLRF       TRISD+0
;Automated_Temperature_based_Fan_Speed_Controller.c,28 :: 		PORTD = 0xff;
	MOVLW      255
	MOVWF      PORTD+0
;Automated_Temperature_based_Fan_Speed_Controller.c,30 :: 		ADC_Init(); //Initialize ADC
	CALL       _ADC_Init+0
;Automated_Temperature_based_Fan_Speed_Controller.c,31 :: 		lcd_init ();
	CALL       _Lcd_Init+0
;Automated_Temperature_based_Fan_Speed_Controller.c,32 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Automated_Temperature_based_Fan_Speed_Controller.c,33 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Automated_Temperature_based_Fan_Speed_Controller.c,35 :: 		PWM1_Init(1000);                    // Initialize PWM1 at 1KHz
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      124
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;Automated_Temperature_based_Fan_Speed_Controller.c,36 :: 		PWM1_Start();                      // Start PWM
	CALL       _PWM1_Start+0
;Automated_Temperature_based_Fan_Speed_Controller.c,37 :: 		PORTE= 0x01;
	MOVLW      1
	MOVWF      PORTE+0
;Automated_Temperature_based_Fan_Speed_Controller.c,39 :: 		Lcd_Out(1, 1, "TEMP: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Automated_Temperature_based_Fan_Speed_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Automated_Temperature_based_Fan_Speed_Controller.c,40 :: 		Lcd_Out(2, 1, "Fan Speed: ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_Automated_Temperature_based_Fan_Speed_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Automated_Temperature_based_Fan_Speed_Controller.c,41 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main1:
	DECFSZ     R13+0, 1
	GOTO       L_main1
	DECFSZ     R12+0, 1
	GOTO       L_main1
	DECFSZ     R11+0, 1
	GOTO       L_main1
	NOP
	NOP
;Automated_Temperature_based_Fan_Speed_Controller.c,42 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Automated_Temperature_based_Fan_Speed_Controller.c,44 :: 		Lcd_Out (1, 1, "Temp: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_Automated_Temperature_based_Fan_Speed_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Automated_Temperature_based_Fan_Speed_Controller.c,45 :: 		Lcd_Chr(2,8,233);       //Different LCD displays have different
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      233
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Automated_Temperature_based_Fan_Speed_Controller.c,48 :: 		Lcd_Chr(2,9,'C');     //Display "C" for Celsius
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Automated_Temperature_based_Fan_Speed_Controller.c,50 :: 		do
L_main2:
;Automated_Temperature_based_Fan_Speed_Controller.c,53 :: 		Temp =ADC_READ(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _Temp+0
	MOVF       R0+1, 0
	MOVWF      _Temp+1
;Automated_Temperature_based_Fan_Speed_Controller.c,54 :: 		mV = Temp*0.48828125;          //5000.0/1024.0;
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      122
	MOVWF      R4+2
	MOVLW      125
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _mV+0
	MOVF       R0+1, 0
	MOVWF      _mV+1
	MOVF       R0+2, 0
	MOVWF      _mV+2
	MOVF       R0+3, 0
	MOVWF      _mV+3
;Automated_Temperature_based_Fan_Speed_Controller.c,55 :: 		mV = mV/10.0;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _mV+0
	MOVF       R0+1, 0
	MOVWF      _mV+1
	MOVF       R0+2, 0
	MOVWF      _mV+2
	MOVF       R0+3, 0
	MOVWF      _mV+3
;Automated_Temperature_based_Fan_Speed_Controller.c,56 :: 		Delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
	NOP
;Automated_Temperature_based_Fan_Speed_Controller.c,58 :: 		FloatToStr(mV,txt);
	MOVF       _mV+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       _mV+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       _mV+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       _mV+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      _txt+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;Automated_Temperature_based_Fan_Speed_Controller.c,59 :: 		txt[4]=0;
	CLRF       _txt+4
;Automated_Temperature_based_Fan_Speed_Controller.c,60 :: 		lcd_Out(1,6,txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Automated_Temperature_based_Fan_Speed_Controller.c,62 :: 		if(mV<=24.9){
	MOVF       _mV+0, 0
	MOVWF      R4+0
	MOVF       _mV+1, 0
	MOVWF      R4+1
	MOVF       _mV+2, 0
	MOVWF      R4+2
	MOVF       _mV+3, 0
	MOVWF      R4+3
	MOVLW      51
	MOVWF      R0+0
	MOVLW      51
	MOVWF      R0+1
	MOVLW      71
	MOVWF      R0+2
	MOVLW      131
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main6
;Automated_Temperature_based_Fan_Speed_Controller.c,63 :: 		PWM1_Set_Duty(0);
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;Automated_Temperature_based_Fan_Speed_Controller.c,64 :: 		Lcd_Out(2,1,"FAN IS OFF");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_Automated_Temperature_based_Fan_Speed_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Automated_Temperature_based_Fan_Speed_Controller.c,65 :: 		}
	GOTO       L_main7
L_main6:
;Automated_Temperature_based_Fan_Speed_Controller.c,67 :: 		else if(mV>25 && mV<=29.9){
	MOVF       _mV+0, 0
	MOVWF      R4+0
	MOVF       _mV+1, 0
	MOVWF      R4+1
	MOVF       _mV+2, 0
	MOVWF      R4+2
	MOVF       _mV+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      72
	MOVWF      R0+2
	MOVLW      131
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	MOVF       _mV+0, 0
	MOVWF      R4+0
	MOVF       _mV+1, 0
	MOVWF      R4+1
	MOVF       _mV+2, 0
	MOVWF      R4+2
	MOVF       _mV+3, 0
	MOVWF      R4+3
	MOVLW      51
	MOVWF      R0+0
	MOVLW      51
	MOVWF      R0+1
	MOVLW      111
	MOVWF      R0+2
	MOVLW      131
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main10
L__main32:
;Automated_Temperature_based_Fan_Speed_Controller.c,68 :: 		PWM1_Set_Duty(17);
	MOVLW      17
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;Automated_Temperature_based_Fan_Speed_Controller.c,69 :: 		Lcd_Out(2,1,"FAN IS ON");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_Automated_Temperature_based_Fan_Speed_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Automated_Temperature_based_Fan_Speed_Controller.c,70 :: 		}
	GOTO       L_main11
L_main10:
;Automated_Temperature_based_Fan_Speed_Controller.c,72 :: 		else if(mV>=30 && Mv<=34.9){
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      112
	MOVWF      R4+2
	MOVLW      131
	MOVWF      R4+3
	MOVF       _mV+0, 0
	MOVWF      R0+0
	MOVF       _mV+1, 0
	MOVWF      R0+1
	MOVF       _mV+2, 0
	MOVWF      R0+2
	MOVF       _mV+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main14
	MOVF       _mV+0, 0
	MOVWF      R4+0
	MOVF       _mV+1, 0
	MOVWF      R4+1
	MOVF       _mV+2, 0
	MOVWF      R4+2
	MOVF       _mV+3, 0
	MOVWF      R4+3
	MOVLW      154
	MOVWF      R0+0
	MOVLW      153
	MOVWF      R0+1
	MOVLW      11
	MOVWF      R0+2
	MOVLW      132
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main14
L__main31:
;Automated_Temperature_based_Fan_Speed_Controller.c,73 :: 		PWM1_Set_Duty(35);
	MOVLW      35
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;Automated_Temperature_based_Fan_Speed_Controller.c,74 :: 		Lcd_Out(2,1,"200 RPM");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_Automated_Temperature_based_Fan_Speed_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Automated_Temperature_based_Fan_Speed_Controller.c,75 :: 		}
	GOTO       L_main15
L_main14:
;Automated_Temperature_based_Fan_Speed_Controller.c,76 :: 		else if(mV>=35 && Mv<=39.9){
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      12
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	MOVF       _mV+0, 0
	MOVWF      R0+0
	MOVF       _mV+1, 0
	MOVWF      R0+1
	MOVF       _mV+2, 0
	MOVWF      R0+2
	MOVF       _mV+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main18
	MOVF       _mV+0, 0
	MOVWF      R4+0
	MOVF       _mV+1, 0
	MOVWF      R4+1
	MOVF       _mV+2, 0
	MOVWF      R4+2
	MOVF       _mV+3, 0
	MOVWF      R4+3
	MOVLW      154
	MOVWF      R0+0
	MOVLW      153
	MOVWF      R0+1
	MOVLW      31
	MOVWF      R0+2
	MOVLW      132
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main18
L__main30:
;Automated_Temperature_based_Fan_Speed_Controller.c,78 :: 		PWM1_Set_Duty(70);
	MOVLW      70
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;Automated_Temperature_based_Fan_Speed_Controller.c,79 :: 		Lcd_Out(2,1,"400 RPM");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_Automated_Temperature_based_Fan_Speed_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Automated_Temperature_based_Fan_Speed_Controller.c,80 :: 		}
	GOTO       L_main19
L_main18:
;Automated_Temperature_based_Fan_Speed_Controller.c,81 :: 		else if(mV>=40 && Mv<=44.9){
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	MOVF       _mV+0, 0
	MOVWF      R0+0
	MOVF       _mV+1, 0
	MOVWF      R0+1
	MOVF       _mV+2, 0
	MOVWF      R0+2
	MOVF       _mV+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main22
	MOVF       _mV+0, 0
	MOVWF      R4+0
	MOVF       _mV+1, 0
	MOVWF      R4+1
	MOVF       _mV+2, 0
	MOVWF      R4+2
	MOVF       _mV+3, 0
	MOVWF      R4+3
	MOVLW      154
	MOVWF      R0+0
	MOVLW      153
	MOVWF      R0+1
	MOVLW      51
	MOVWF      R0+2
	MOVLW      132
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main22
L__main29:
;Automated_Temperature_based_Fan_Speed_Controller.c,83 :: 		PWM1_Set_Duty(106);
	MOVLW      106
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;Automated_Temperature_based_Fan_Speed_Controller.c,84 :: 		Lcd_Out(2,1,"600 RPM");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_Automated_Temperature_based_Fan_Speed_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Automated_Temperature_based_Fan_Speed_Controller.c,85 :: 		}
	GOTO       L_main23
L_main22:
;Automated_Temperature_based_Fan_Speed_Controller.c,86 :: 		else if(mV>=45 && Mv<=49.9){
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      52
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	MOVF       _mV+0, 0
	MOVWF      R0+0
	MOVF       _mV+1, 0
	MOVWF      R0+1
	MOVF       _mV+2, 0
	MOVWF      R0+2
	MOVF       _mV+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main26
	MOVF       _mV+0, 0
	MOVWF      R4+0
	MOVF       _mV+1, 0
	MOVWF      R4+1
	MOVF       _mV+2, 0
	MOVWF      R4+2
	MOVF       _mV+3, 0
	MOVWF      R4+3
	MOVLW      154
	MOVWF      R0+0
	MOVLW      153
	MOVWF      R0+1
	MOVLW      71
	MOVWF      R0+2
	MOVLW      132
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main26
L__main28:
;Automated_Temperature_based_Fan_Speed_Controller.c,88 :: 		PWM1_Set_Duty(132);
	MOVLW      132
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;Automated_Temperature_based_Fan_Speed_Controller.c,89 :: 		Lcd_Out(2,8,"750 RPM");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_Automated_Temperature_based_Fan_Speed_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Automated_Temperature_based_Fan_Speed_Controller.c,90 :: 		}
	GOTO       L_main27
L_main26:
;Automated_Temperature_based_Fan_Speed_Controller.c,92 :: 		PWM1_Set_Duty(0);
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;Automated_Temperature_based_Fan_Speed_Controller.c,93 :: 		Lcd_Out(2,8,"800 RPM");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_Automated_Temperature_based_Fan_Speed_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Automated_Temperature_based_Fan_Speed_Controller.c,94 :: 		}
L_main27:
L_main23:
L_main19:
L_main15:
L_main11:
L_main7:
;Automated_Temperature_based_Fan_Speed_Controller.c,96 :: 		while(1);
	GOTO       L_main2
;Automated_Temperature_based_Fan_Speed_Controller.c,97 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
