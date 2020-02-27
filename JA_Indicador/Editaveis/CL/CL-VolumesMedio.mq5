//+------------------------------------------------------------------+
//|                                              CL-VolumesMedio.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers 2
#property indicator_plots 0
#property indicator_height 20
//---
int handleArquivo;

int handleVolumeMedio;
double volumeMedio[];
double sinal[];


//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
   SetIndexBuffer(0, volumeMedio, INDICATOR_DATA);
   SetIndexBuffer(1, sinal, INDICATOR_DATA);
//---
   handleArquivo  = FileOpen(Symbol() + "_VolumesMedio.csv", FILE_READ | FILE_WRITE | FILE_CSV );
//---
   handleVolumeMedio = iCustom(_Symbol, _Period, "estudo\\CV-VolumeMedio");
   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   FileClose(handleArquivo);
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
      inicio   = 20;
      qtdCopy  = rates_total;
   } else {
      inicio   = prev_calculated - 1;
      qtdCopy  = 1;
   }
//---
   CopyBuffer(handleVolumeMedio, 0,0, qtdCopy, sinal);
   CopyBuffer(handleVolumeMedio, 1,0, qtdCopy, volumeMedio);
//---
   for(int i = inicio; i < rates_total; i++) {
      FileWrite(
         handleArquivo,
         TimeToString(time[i]),
         DoubleToString(sinal[i], 0),
         DoubleToString(volumeMedio[i], 0)
         //---
      );
   }
//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
