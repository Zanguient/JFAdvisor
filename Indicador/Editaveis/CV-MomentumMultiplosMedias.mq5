//+------------------------------------------------------------------+
//|                                         CV-MomentumMultiplos.mq5 |
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
#property indicator_label1 "Sinal"
//--- plot Momentum1
#property indicator_label2  "Momentum1"
#property indicator_type2   DRAW_COLOR_HISTOGRAM
#property indicator_color2  clrRoyalBlue, clrGray
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1

//--- indicator buffers
double         Momentum1Buffer[];
double         Momentum1Colors[];
//---
int   handle1;
//---
double array1[];
double Sinal[];
//---
input int Media1 = 1;
input int Time1 = 3;
//---


//---


//---


//---



//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
   SetIndexBuffer(0, Sinal, INDICATOR_DATA);
   SetIndexBuffer(1, Momentum1Buffer, INDICATOR_DATA);
   SetIndexBuffer(2, Momentum1Colors, INDICATOR_COLOR_INDEX);
   
//---
   SetIndexBuffer(3, array1, INDICATOR_CALCULATIONS);
   
//---
   handle1 = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, Media1);
   
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
      inicio = Media1+Time1;
      qtdCopy = rates_total;
   } else {
      inicio = prev_calculated - 1;
      qtdCopy = 1;
   }
//---
   CopyBuffer(handle1, 1, 0, qtdCopy, array1);

//---
   for(int i = inicio; i < rates_total; i++) {
      Momentum1Buffer[i] = (array1[i]) / (array1[i - Time1]) * 100;
      
      
      if(Momentum1Buffer[i] < Momentum1Buffer[i - 1 ]) {
         // Venda
         Momentum1Colors[i] = 1;
         Sinal[i]  = -1;
      } else {
         // Compra
         Momentum1Colors[i] = 0;
         Sinal[i]  = 1;
      }
      
    
   }
   ChartRedraw(2);
//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
