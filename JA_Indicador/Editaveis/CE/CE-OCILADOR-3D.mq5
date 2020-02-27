//+------------------------------------------------------------------+
//|                                               CV-OCILADOR-3D.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window

#property indicator_buffers 10
#property indicator_plots   4

#property indicator_label1 "Sinal"

#property indicator_label2 "Media Rapida"
#property indicator_type2  DRAW_COLOR_LINE
#property indicator_color2 clrRed, clrGreen, clrYellow
#property indicator_style2 STYLE_SOLID
#property indicator_width2 1

#property indicator_label3 "Media Lenta"
#property indicator_type3  DRAW_COLOR_LINE
#property indicator_color3 clrRed, clrGreen, clrYellow
#property indicator_style3 STYLE_SOLID
#property indicator_width3 1


#property indicator_label4 "Media + Lenta"
#property indicator_type4  DRAW_COLOR_LINE
#property indicator_color4 clrRed, clrGreen, clrYellow
#property indicator_style4 STYLE_SOLID
#property indicator_width4 1

double      Sinal[];

double      Ma1Buffer[];
double      Ma2Buffer[];
double      Ma3Buffer[];

double      Ma1Color[];
double      Ma2Color[];
double      Ma3Color[];

double      Calc1[];
double      Calc2[];
double      Calc3[];

int         Handle1;
int         Handle2;
int         Handle3;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping

   SetIndexBuffer(0, Sinal,      INDICATOR_DATA);
   SetIndexBuffer(1, Ma1Buffer,  INDICATOR_DATA);
   SetIndexBuffer(2, Ma1Color,   INDICATOR_COLOR_INDEX);
   SetIndexBuffer(3, Ma2Buffer,  INDICATOR_DATA);
   SetIndexBuffer(4, Ma2Color,   INDICATOR_COLOR_INDEX);
   SetIndexBuffer(5, Ma3Buffer,  INDICATOR_DATA);
   SetIndexBuffer(6, Ma3Color,   INDICATOR_COLOR_INDEX);
   SetIndexBuffer(7, Calc1,      INDICATOR_DATA);
   SetIndexBuffer(8, Calc2,      INDICATOR_DATA);
   SetIndexBuffer(9, Calc3,      INDICATOR_DATA);


   Handle1 = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA", 0, 2, 2, 2, 2, PRICE_CLOSE, MODE_SMA);
   Handle2 = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA", 0, 3, 3, 3, 3, PRICE_CLOSE, MODE_SMA);
   Handle3 = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA", 0, 16, 17, 18, 19, PRICE_CLOSE, MODE_SMA);


//---
   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
//---

   int inicio;
   int qtdCopy;

   int valida1 = 0;
   int valida2 = 0;

   if(prev_calculated == 0) {
      inicio   = 10;
      qtdCopy  = rates_total;
   } else {
      inicio   = prev_calculated - 1;
      qtdCopy  = 1;
   }

   CopyBuffer(Handle1, 1, 0, qtdCopy, Calc1);
   CopyBuffer(Handle2, 1, 0, qtdCopy, Calc2);
   CopyBuffer(Handle3, 1, 0, qtdCopy, Calc3);
   
   

   for(int i = inicio; i < rates_total; i++) {
      Sinal[i]    = 0;

      Ma1Color[i] = 0;
      Ma2Color[i] = 0;
      Ma3Color[i] = 0;

      Ma1Buffer[i] = Calc1[i] - Calc3[i];
      Ma2Buffer[i] = Calc2[i] - Calc3[i];
      Ma3Buffer[i] = 0;


      if(Ma1Buffer[i] > Ma1Buffer[i - 1]) {
         valida1 = 1;
      } else if(Ma1Buffer[i] < Ma1Buffer[i - 1]) {
         valida1 = -1;
      }


      if(Ma2Buffer[i] > Ma2Buffer[i - 1]) {
         valida2 = 1;
      } else if(Ma2Buffer[i] < Ma2Buffer[i - 1]) {
         valida2 = -1;
      }

      if(valida1 == 1 && valida2 == 1) {
         Ma1Color[i] = 1;
         Ma2Color[i] = 1;
         
         Sinal[i]    = 1;

      } else if(valida1 == -1 && valida2 == -1) {
         Ma1Color[i] = 0;
         Ma2Color[i] = 0;
         
         Sinal[i]    = -1;

      } else {
         Ma1Color[i] = 2;
         Ma2Color[i] = 2;
         
         Sinal[i]    = 0;
      }


      if( 
            (Ma1Buffer[i] < 10 && Ma1Buffer[i] > -10) &&  
            (Ma1Buffer[i-1] < 10 && Ma1Buffer[i-1] > -10) &&  
            (Ma1Buffer[i-2] < 10 && Ma1Buffer[i-2] > -10) &&
              
            (Ma2Buffer[i] < 10 && Ma2Buffer[i] > -10) &&  
            (Ma2Buffer[i-1] < 10 && Ma2Buffer[i-1] > -10) &&  
            (Ma2Buffer[i-2] < 10 && Ma2Buffer[i-2] > -10) 
            
        ) {
         Ma1Color[i] = 2;
         Ma2Color[i] = 2;
      }




      ChartRedraw(1);
   }
//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
