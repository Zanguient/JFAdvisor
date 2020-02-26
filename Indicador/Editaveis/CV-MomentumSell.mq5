//+------------------------------------------------------------------+
//|                                              CV-MomentumSell.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers 3
#property indicator_plots   1
#property indicator_height 50
//--- plot MomentumSell
#property indicator_label1  "MomentumSell"
#property indicator_type1   DRAW_COLOR_HISTOGRAM
#property indicator_color1  clrRed, clrGray
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- indicator buffers
double         MomentumSellBuffer[];
double         MomentumSellColors[];
double         array[];
int            handle;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
   SetIndexBuffer(0, MomentumSellBuffer, INDICATOR_DATA);
   SetIndexBuffer(1, MomentumSellColors, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(2, array, INDICATOR_CALCULATIONS);
//---
   handle = iCustom(_Symbol, _Period, "estudo\\CV-Demanda", 8);
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
   if(prev_calculated == 0) {
      inicio = 20;
      qtdCopy = rates_total;
   } else {
      inicio = prev_calculated - 1;
      qtdCopy = 1;
   }
   CopyBuffer(handle, 1, 0, qtdCopy, array);
   for(int i = inicio; i < rates_total; i++) {
      MomentumSellBuffer[i] = array[i] / array[i - 6];
      if(MomentumSellBuffer[i] > MomentumSellBuffer[i - 1]) {
         MomentumSellColors[i] = 0;
      }else
         {
          MomentumSellColors[i] = 1;
         }
   }
//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
