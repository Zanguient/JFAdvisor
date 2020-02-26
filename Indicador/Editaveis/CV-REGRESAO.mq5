//+------------------------------------------------------------------+
//|                                                  CV-REGRESAO.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers 3
#property indicator_plots   1
//--- plot Regresao
#property indicator_label1  "Regresao"
#property indicator_type1   DRAW_COLOR_LINE
#property indicator_color1  clrRoyalBlue,clrRed
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1

#property indicator_level1 3
#property indicator_level2 -3

//--- indicator buffers
double         RegresaoBuffer[];
double         RegresaoColors[];


double   SumX;
double   SumXY;
double   SumY;
double   SumPowX;
double   PowSumX;
double   b;
int x;
double y;

int handle;
double array[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
   SetIndexBuffer(0, RegresaoBuffer, INDICATOR_DATA);
   SetIndexBuffer(1, RegresaoColors, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(2, array, INDICATOR_CALCULATIONS);
   handle = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 20);
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
      //---
      inicio = 20;
      qtdCopy = rates_total;
   } else {
      inicio = prev_calculated - 1;
      qtdCopy = 1;
   }
   CopyBuffer(handle, 1, 0, rates_total, array);
//---
      _regresao();
   }

//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+

void _regresao()
{
   x = 0;
   y = 0;   
   SumX  = 0;
   SumXY = 0;
   SumY  = 0;
   SumPowX = 0;
   for(int i = inicio; i < rates_total; i++) {
      int n = 5;
      for(int j = 1; j <= n; j++) {
         x = j;
         y = array[i - j] - 1000;
         SumX  += x;
         SumXY += x * y;
         SumY  += y;
         SumPowX += x * x;         
      }
      PowSumX = SumPowX * SumPowX;      
      b = (n * SumXY - SumX * SumY) / (n * SumPowX - PowSumX);
      RegresaoBuffer[i] = b * 100;
      RegresaoColors[i] = 0;
   
}