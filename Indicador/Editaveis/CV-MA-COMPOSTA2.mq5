//+------------------------------------------------------------------+
//|                                               CV-MA-COMPOSTA.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 9
#property indicator_plots   2

#property indicator_label1 "Sinal IN"

//--- plot MA_COMPOSTA
#property indicator_label2  "MA_COMPOSTA"
#property indicator_type2   DRAW_COLOR_LINE
#property indicator_color2  clrGray,clrRoyalBlue
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1


//--- input parameters

input double slip = 0;
input int   ma1 = 1;




input ENUM_APPLIED_PRICE   price = PRICE_CLOSE;
input ENUM_MA_METHOD       mode  = MODE_SMA;

int   handle_ma1;
int   handle_ma2;
int   handle_ma3;
int   handle_ma4;

double   array_ma1[];
double   array_ma2[];
double   array_ma3[];
double   array_ma4[];

//--- indicator buffers
double         MA_COMPOSTABuffer[];
double         MA_COMPOSTAColors[];

double media[];
double mediamovel[];

double   Sinal[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
   SetIndexBuffer(0, Sinal,               INDICATOR_DATA);
   SetIndexBuffer(1, MA_COMPOSTABuffer,   INDICATOR_DATA);
   SetIndexBuffer(2, MA_COMPOSTAColors,   INDICATOR_COLOR_INDEX);
   SetIndexBuffer(3, array_ma1,           INDICATOR_DATA);
   SetIndexBuffer(4, array_ma2,           INDICATOR_DATA);
   SetIndexBuffer(5, array_ma3,           INDICATOR_DATA);
   SetIndexBuffer(6, array_ma4,           INDICATOR_DATA);
   SetIndexBuffer(7, media,               INDICATOR_DATA);
   SetIndexBuffer(8, mediamovel,          INDICATOR_DATA);

   IndicatorSetInteger(INDICATOR_DIGITS, _Digits);

   handle_ma1 = iMA(_Symbol, _Period, ma1, 0, mode, price);
   handle_ma2 = iMA(_Symbol, _Period, ma1+1, 0, mode, price);
   

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

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

   int inicio;
   int qtdCopiada;

   if(prev_calculated == 0) {
      inicio = 4;
      qtdCopiada = rates_total;
   } else {
      inicio = prev_calculated -1;
      qtdCopiada = 4;
   }


//---

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

   CopyBuffer(handle_ma1, 0, 0, qtdCopiada, array_ma1);
   CopyBuffer(handle_ma2, 0, 0, qtdCopiada, array_ma2);
   
   

   for(int i = inicio; i < rates_total; i++) {
      media[i] = ( array_ma1[i] + array_ma2[i] ) / 2;

      mediamovel[i] = (media[i] + media[i - 1] ) / 2;

      MA_COMPOSTABuffer[i] = mediamovel[i] + slip;
      if(mediamovel[i] > mediamovel[i - 1]) {
         MA_COMPOSTAColors[i] = 1;
         Sinal[i] = 1;
      } else if(mediamovel[i] <= mediamovel[i - 1]) {
         MA_COMPOSTAColors[i] = 0;
         Sinal[i] = -1;
      }
   }

//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
