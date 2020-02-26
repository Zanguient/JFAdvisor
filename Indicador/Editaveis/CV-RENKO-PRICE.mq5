//+------------------------------------------------------------------+
//|                                               CV-RENKO-PRICE.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 3
#property indicator_plots   2

//--- plot Label2
#property indicator_label2  "Label1"
#property indicator_type2   DRAW_COLOR_LINE
#property indicator_color2  clrRoyalBlue,clrBlack
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1

//--- indicator buffers
double         Sinal[];
double         RENKO_Open[];
double         RENKO_Colors[];



//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
   SetIndexBuffer(0, Sinal);
   SetIndexBuffer(1, RENKO_Open, INDICATOR_DATA);
   SetIndexBuffer(2, RENKO_Colors, INDICATOR_COLOR_INDEX);

//---
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime& time[],
                const double& open[],
                const double& high[],
                const double& low[],
                const double& close[],
                const long& tick_volume[],
                const long& volume[],
                const int& spread[])
{
   


   return(rates_total);
}
//+------------------------------------------------------------------+
