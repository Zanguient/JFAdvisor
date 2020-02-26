//+------------------------------------------------------------------+
//|                                               CV-VolumeMedio.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers 4
#property indicator_plots   2
//--- plot Sinal
#property indicator_label1  "Sinal"
//--- plot VolumeMedio
#property indicator_label2  "VolumeMedio"
#property indicator_type2   DRAW_COLOR_HISTOGRAM
#property indicator_color2  clrRed,clrGreen
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1
//--- indicator buffers
double         Sinal[];
double         VolumeMedioBuffer[];
double         VolumeMedioColors[];
double         array[];
int            handle;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
   SetIndexBuffer(0, Sinal, INDICATOR_DATA);
   SetIndexBuffer(1, VolumeMedioBuffer, INDICATOR_DATA);
   SetIndexBuffer(2, VolumeMedioColors, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(3, array, INDICATOR_CALCULATIONS);
   handle = iVolumes(_Symbol, _Period, VOLUME_TICK);
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
      inicio = 4;
      qtdCopy = rates_total;
   } else {
      inicio = prev_calculated - 1 ;
      qtdCopy = 1;
   }
   CopyBuffer(handle, 0, 0, qtdCopy, array);
   for(int i = inicio; i < rates_total; i++) {
      double media1 = (array[i] + array[i - 1] + array[i - 2] + array[i - 3]) / 4;
      double media2 = (array[i] + array[i - 1] + array[i - 2] ) / 3;
      double media3 = (array[i] + array[i - 1]) / 2;
      double media = (media1 + media2 + media3) / 3;
      double MediaMovel = (media + VolumeMedioBuffer[i - 1] ) / 2;
      VolumeMedioBuffer[i] = MediaMovel;
      if(VolumeMedioBuffer[i] > VolumeMedioBuffer[i - 1]) {
         // Compra
         VolumeMedioColors[i] = 1;
         Sinal[i] = 1;
      } else {
         // Venda
         VolumeMedioColors[i] = 0;
         Sinal[i] = -1;
      }
   }
//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
