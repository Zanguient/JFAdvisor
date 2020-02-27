//+------------------------------------------------------------------+
//|                                                   CV-DIVISOR.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 7
#property indicator_plots   2
//--- Sinal
#property indicator_label1  "Sinal IN"

//--- plot Label2
#property indicator_label2  "Candles"
#property indicator_type2   DRAW_COLOR_BARS
#property indicator_color2  clrRed,clrGreen,clrGray
#property indicator_style2  STYLE_SOLID
#property indicator_width2  2
//--- indicator buffers
double         Open[];
double         High[];
double         Low[];
double         Close[];
double         Colors[];

double         Sinal[];

double         MaArray[];

input group "SETUP MEDIA"
input int                  ma1 = 16;
input int                  ma2 = 17;
input int                  ma3 = 18;
input int                  ma4 = 19;
input ENUM_MA_METHOD       mode = MODE_SMA;
input ENUM_APPLIED_PRICE   price = PRICE_CLOSE;

int            handle;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
   SetIndexBuffer(0, Sinal, INDICATOR_DATA);
   SetIndexBuffer(1, Open, INDICATOR_DATA);
   SetIndexBuffer(2, High, INDICATOR_DATA);
   SetIndexBuffer(3, Low, INDICATOR_DATA);
   SetIndexBuffer(4, Close, INDICATOR_DATA);
   SetIndexBuffer(5, Colors, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(6, MaArray, INDICATOR_DATA);

   IndicatorSetInteger(INDICATOR_DIGITS, _Digits);

   handle = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA", 0, ma1, ma2, ma3, ma4, price, mode);

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
//| calcula prev_calculate                                           |
//+------------------------------------------------------------------+

   int inicio;
   int qtdCopiada;

   if(prev_calculated == 0) {
      inicio = 0;
      qtdCopiada = rates_total;
   } else {
      inicio = prev_calculated - 1;
      qtdCopiada = 5;
   }

//---

   CopyBuffer(handle, 1, 0, qtdCopiada, MaArray);

   for(int i = inicio; i < rates_total; i++) {
      Open[i] = open[i];
      High[i] = high[i];
      Low[i]   = low[i];
      Close[i] = close[i];


      double media = (((high[i] + low[i]) / 2) + ((open[i] + close[i]) / 2)) / 2;

      Colors[i] = 2;
      Sinal[i] = 0;
      if(media < MaArray[i]) {
         Colors[i] = 0;
         Sinal[i] = -1;
      }
      if(media > MaArray[i]) {
         Colors[i] = 1;
         Sinal[i] = 1;
      }
   }
//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
