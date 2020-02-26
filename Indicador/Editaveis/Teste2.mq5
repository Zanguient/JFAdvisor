//+------------------------------------------------------------------+
//|                                                       Teste2.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      ""
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 4
#property indicator_plots   4
//+------------------------------------------------------------------+
//| includes                                                                 |
//+------------------------------------------------------------------+
#include <Trade/Trade.mqh>

//--- plot A
#property indicator_label1  "A"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrRed
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- plot B
#property indicator_label2  "B"
#property indicator_type2   DRAW_LINE
#property indicator_color2  clrDarkBlue
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1
//--- plot C
#property indicator_label3  "C"
#property indicator_type3   DRAW_LINE
#property indicator_color3  clrChartreuse
#property indicator_style3  STYLE_SOLID
#property indicator_width3  1
//--- plot D
#property indicator_label4  "D"
#property indicator_type4   DRAW_LINE
#property indicator_color4  clrYellow
#property indicator_style4  STYLE_SOLID
#property indicator_width4  1
//--- indicator buffers
double         ABuffer[];
double         BBuffer[];
double         CBuffer[];
double         DBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,ABuffer,INDICATOR_DATA);
   SetIndexBuffer(1,BBuffer,INDICATOR_DATA);
   SetIndexBuffer(2,CBuffer,INDICATOR_DATA);
   SetIndexBuffer(3,DBuffer,INDICATOR_DATA);
   
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
//---
   for(int i=3;i<rates_total;i++)
     {
      ABuffer[i] = close[i];
      BBuffer[i] = (close[i]+close[i-1])/2;
      CBuffer[i] = (close[i]+close[i-1]+close[i-2])/3;
      DBuffer[i] = (close[i]+close[i-1]+close[i-2]+close[i-3])/4;
     }
     
     
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
