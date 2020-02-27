//+------------------------------------------------------------------+
//|                                           CV-CruzamentoMedia.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 7
#property indicator_plots   3

//--- plot Sinal
#property indicator_label1  "Sinal"
//--- plot Open
#property indicator_label2  "Open"
#property indicator_type2   DRAW_COLOR_LINE
#property indicator_color2  clrWhite, clrRed
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1
//--- plot Close
#property indicator_label3  "Close"
#property indicator_type3   DRAW_COLOR_LINE
#property indicator_color3  clrWhite, clrRed
#property indicator_style3  STYLE_SOLID
#property indicator_width3  1
//--- indicator buffers
double         OpenBuffer[];
double         OpenColors[];
double         CloseBuffer[];
double         CloseColors[];
//---
int handle1;
int handle2;
//---
double array1[];
double array2[];

double Sinal[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
   SetIndexBuffer(0, Sinal, INDICATOR_DATA);
   SetIndexBuffer(1, OpenBuffer, INDICATOR_DATA);
   SetIndexBuffer(2, OpenColors, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(3, CloseBuffer, INDICATOR_DATA);
   SetIndexBuffer(4, CloseColors, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(5, array1, INDICATOR_CALCULATIONS);
   SetIndexBuffer(6, array2, INDICATOR_CALCULATIONS);
   handle1 = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 1, PRICE_OPEN);
   handle2 = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 1, PRICE_CLOSE);
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
      inicio = 0;
      qtdCopy = rates_total;
   } else {
      inicio = prev_calculated - 1;
      qtdCopy = 1;
   }
   //---
   CopyBuffer(handle1, 1, 0, qtdCopy, array1);
   CopyBuffer(handle2, 1, 0, qtdCopy, array2);
   //---
   for(int i = inicio; i < rates_total; i++) {
      OpenBuffer[i] = array1[i];
      CloseBuffer[i] = array2[i];
      if(OpenBuffer[i] < CloseBuffer[i]) {
         OpenColors[i] = 0;
         CloseColors[i] = 0;
         Sinal[i] = 1;
      } else {
         OpenColors[i] = 1;
         CloseColors[i] = 1;
         Sinal[i] = -1;
      }
   }
//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
