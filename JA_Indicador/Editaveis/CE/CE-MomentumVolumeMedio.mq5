//+------------------------------------------------------------------+
//|                                       CV-MomentumVolumeMedio.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window

#property indicator_height 50

#property indicator_buffers 3
#property indicator_plots   1
//--- plot MomentumVolumes
#property indicator_label1  "MomentumVolumes"
#property indicator_type1   DRAW_COLOR_HISTOGRAM
#property indicator_color1  clrRoyalBlue,clrGray
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- indicator buffers
double         MomentumVolumesBuffer[];
double         MomentumVolumesColors[];
double         array[];
int handle;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
   SetIndexBuffer(0, MomentumVolumesBuffer, INDICATOR_DATA);
   SetIndexBuffer(1, MomentumVolumesColors, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(2, array, INDICATOR_CALCULATIONS);
   handle = iCustom(_Symbol, _Period, "estudo\\CV-VolumeMedio");
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
   if(prev_calculated == 0) {
      inicio = 15;
      qtdCopy = rates_total;
   } else {
      inicio = prev_calculated - 1;
      qtdCopy = 1;
   }
   CopyBuffer(handle, 0, 0, rates_total, array);
   for(int i = inicio; i < rates_total; i++) {
      MomentumVolumesBuffer[i] = array[i] / array[i - 7];
      if(MomentumVolumesBuffer[i] > MomentumVolumesBuffer[i - 1]) {
         MomentumVolumesColors[i] = 0;
      } else {
         MomentumVolumesColors[i] = 1;
      }
   }
//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
