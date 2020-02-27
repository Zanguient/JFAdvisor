//+------------------------------------------------------------------+
//|                                                     CV-TEste.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers 5
#property indicator_plots   1
//--- plot Label1
#property indicator_label1  "Label1"
#property indicator_type1   DRAW_COLOR_CANDLES
#property indicator_color1  clrRed
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- indicator buffers

double         Label1Buffer1[];
double         Label1Buffer2[];
double         Label1Buffer3[];
double         Label1Buffer4[];
double         Label1Colors[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,Label1Buffer1,INDICATOR_DATA);
   SetIndexBuffer(1,Label1Buffer2,INDICATOR_DATA);
   SetIndexBuffer(2,Label1Buffer3,INDICATOR_DATA);
   SetIndexBuffer(3,Label1Buffer4,INDICATOR_DATA);
   SetIndexBuffer(4,Label1Colors,INDICATOR_COLOR_INDEX);
   
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
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
