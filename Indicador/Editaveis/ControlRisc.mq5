//+------------------------------------------------------------------+
//|                                                  ControlRisc.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      ""
#property version   "1.00"
#property indicator_separate_window
#property indicator_height 20
#property indicator_minimum 1
#property indicator_maximum 10
#property indicator_buffers 2
#property indicator_plots   1
//--- plot Sinal
#property indicator_label1  "Sinal"
#property indicator_type1   DRAW_COLOR_HISTOGRAM
#property indicator_color1  clrDimGray,clrRed,clrLime
#property indicator_style1  STYLE_SOLID
#property indicator_width1  3
//--- input parameters
input int      Compra;
input int      Venda;
//--- indicator buffers
double         SinalBuffer[];
double         SinalColors[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,SinalBuffer,INDICATOR_DATA);
   SetIndexBuffer(1,SinalColors,INDICATOR_COLOR_INDEX);
   
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
