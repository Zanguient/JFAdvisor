//+------------------------------------------------------------------+
//|                                                        CV-MA.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window

#property indicator_buffers 3
#property indicator_plots   2

//--- Sinal
#property indicator_label1  "Sinal"

//--- plot Horizonte
#property indicator_label2  "Grafico"
#property indicator_type2   DRAW_COLOR_LINE
#property indicator_color2  clrRoyalBlue, clrGray
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1

double      Sinal[];
double      maPlot[];
double      maColor[];

double      maCap[];
int         maHandle;

input double               vtSlip  = 0;
input int                  periodo = 5;
input ENUM_MA_METHOD       mode = MODE_SMA;
input ENUM_APPLIED_PRICE   price = PRICE_CLOSE;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{




//--- indicator buffers mapping
   SetIndexBuffer(0, Sinal, INDICATOR_DATA);
   SetIndexBuffer(1, maPlot, INDICATOR_DATA);
   SetIndexBuffer(2, maColor, INDICATOR_COLOR_INDEX);
   
   IndicatorSetInteger(INDICATOR_DIGITS,_Digits);

   ArrayInitialize(maCap, EMPTY_VALUE);
   
   maHandle = iMA(_Symbol, _Period, periodo, 0, mode, price);
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


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

   int inicio;
   int qtdCopiada;

   if(prev_calculated == 0) {
      inicio = 1;
      qtdCopiada = rates_total;
   } else {
      inicio = prev_calculated -1;
      qtdCopiada = 4;
   }


//---
//---

   CopyBuffer(maHandle, 0, 0, qtdCopiada, maCap);
   
   for(int i = inicio; i < rates_total; i++) {
      maPlot[i] = maCap[i] + vtSlip;


      if(maCap[i] > maCap[i - 1]) {
         maColor[i] = 0;
         Sinal[i] = 1;
      } else if(maCap[i] <= maCap[i - 1]) {
         maColor[i] = 1;
         Sinal[i] = -1;
      }

   }
//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
