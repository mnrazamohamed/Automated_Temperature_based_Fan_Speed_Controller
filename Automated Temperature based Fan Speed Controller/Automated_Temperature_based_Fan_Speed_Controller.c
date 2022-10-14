// LCD module connections
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;
// End LCD module connections

 unsigned int Temp = 0;
 float mV;
 unsigned char txt[15];

void main()
{
     TRISA.RA0 = 1;
     PORTB =0x01;
     Delay_ms(5000);
     TRISE = 0;
     TRISD = 0;
     PORTD = 0xff;

     ADC_Init(); //Initialize ADC
     lcd_init ();
     Lcd_Cmd(_LCD_CLEAR);               // Clear display
     Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off

     PWM1_Init(1000);                    // Initialize PWM1 at 1KHz
     PWM1_Start();                      // Start PWM
     PORTE= 0x01;

     Lcd_Out(1, 1, "TEMP: ");
     Lcd_Out(2, 1, "Fan Speed: ");
     Delay_ms(1000);
     Lcd_Cmd(_LCD_CLEAR);

     Lcd_Out (1, 1, "Temp: ");
     Lcd_Chr(2,8,233);       //Different LCD displays have different
                             //Character code for degree

     Lcd_Chr(2,9,'C');     //Display "C" for Celsius

     do
     {

      Temp =ADC_READ(0);
      mV = Temp*0.48828125;          //5000.0/1024.0;
      mV = mV/10.0;
      Delay_ms(500);

      FloatToStr(mV,txt);
      txt[4]=0;
      lcd_Out(1,6,txt);

      if(mV<=24.9){
      PWM1_Set_Duty(0);
      Lcd_Out(2,1,"FAN IS OFF");
      }

      else if(mV>25 && mV<=29.9){
      PWM1_Set_Duty(17);
      Lcd_Out(2,1,"FAN IS ON");
      }

      else if(mV>=30 && Mv<=34.9){
      PWM1_Set_Duty(35);
      Lcd_Out(2,1,"200 RPM");
      }
      else if(mV>=35 && Mv<=39.9){

      PWM1_Set_Duty(70);
      Lcd_Out(2,1,"400 RPM");
      }
      else if(mV>=40 && Mv<=44.9){

      PWM1_Set_Duty(106);
      Lcd_Out(2,1,"600 RPM");
      }
      else if(mV>=45 && Mv<=49.9){

      PWM1_Set_Duty(132);
      Lcd_Out(2,8,"750 RPM");
      }
      else{
      PWM1_Set_Duty(0);
      Lcd_Out(2,8,"800 RPM");
      }
     }
     while(1);
}