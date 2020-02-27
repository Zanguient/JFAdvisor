//+------------------------------------------------------------------+
//|                                                 CV-MA-RAPIDA.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window
#property description "Indicador baseado em CV-MA"
#property indicator_height    15
#property indicator_maximum   1
#property indicator_minimum   0

#property indicator_buffers 4
#property indicator_plots   2

//---
#property indicator_label1 "Sinal IN"

//--- plot Ashi_Candles
#property indicator_label2  "Sinal Plot"
#property indicator_type2   DRAW_COLOR_HISTOGRAM
#property indicator_color2  clrRed,clrBlack
#property indicator_style2  STYLE_SOLID
#property indicator_width2  5


int                  handle;
double               array[];

double               Sinal[];

double               PlotBuffer[];
double               PlotColor[];

input int                  periodo  = 5;
input ENUM_MA_METHOD       modo     = MODE_SMA;
input ENUM_APPLIED_PRICE   preco    = PRICE_CLOSE;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping

   SetIndexBuffer(0, Sinal, INDICATOR_DATA);
   SetIndexBuffer(1, PlotBuffer, INDICATOR_DATA);
   SetIndexBuffer(2, PlotColor,  INDICATOR_COLOR_INDEX);
   SetIndexBuffer(3, array,      INDICATOR_DATA);

   IndicatorSetInteger(INDICATOR_DIGITS, _Digits);
   IndicatorSetString(INDICATOR_SHORTNAME, "RB-HT-A (" + IntegerToString(periodo) + ")");

   handle = iCustom(_Symbol, _Period, "estudo\\CV-MA", 0, periodo, modo, preco);




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
      inicio = 1;
      qtdCopiada = rates_total;
   } else {
      inicio = prev_calculated - 1;
      qtdCopiada = 5;
   }

//---

   CopyBuffer(handle, 0, 0, qtdCopiada, array);

   for(int i = inicio; i < rates_total; i++) {
      PlotBuffer[i] = 1;

      if(array[i] == 1 ) {
         PlotColor[i] = 1;
         Sinal[i] = 1;
      } else {
         PlotColor[i] = 0;
         Sinal[i] = -1;
      }
   }
//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
