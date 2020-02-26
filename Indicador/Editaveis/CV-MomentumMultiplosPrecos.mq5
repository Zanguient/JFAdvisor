//+------------------------------------------------------------------+
//|                                   CV-MomentumMultiplosPrecos.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers 10
#property indicator_plots   5

#property indicator_height 50
//--- plot Tempo1
#property indicator_label1  "Tempo1"
#property indicator_type1   DRAW_COLOR_HISTOGRAM
#property indicator_color1  clrRoyalBlue, clrGray
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1

//--- indicator buffers
double         Tempo1Buffer[];
double         Tempo1Colors[];

//---
input int tempo1 = 14;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
   SetIndexBuffer(0, Tempo1Buffer, INDICATOR_DATA);
   SetIndexBuffer(1, Tempo1Colors, INDICATOR_COLOR_INDEX);
 
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
   if(prev_calculated == 0) {
      inicio = 20;
   } else {
      inicio = prev_calculated - 1;
   }
   for(int i = inicio; i < rates_total; i++) {
      //---
      Tempo1Buffer[i] = close[i] /  close[i - tempo1] * 100;
      //---
      if(Tempo1Buffer[i] < Tempo1Buffer[i - 1 ]) {
         Tempo1Colors[i] = 1;
      } else {
         Tempo1Colors[i] = 0;
      }
   
      
   }
//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
