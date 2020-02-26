//+------------------------------------------------------------------+
//|                                                  Caso-cores1.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      ""
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers   1
#property indicator_plots     1
//--- input parameters
#property indicator_label1    "Media Movel"
#property indicator_type1     DRAW_LINE
#property indicator_color1    clrBlue
#property indicator_type1     STYLE_SOLID
#property indicator_width1    1

input int      RSI_Periodo=14;
//--- Parametros de media
int ma_handle;
double maArray[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0, maArray, INDICATOR_DATA);
   
   ma_handle = iMA(_Symbol, _Period,0,0,MODE_EMA,PRICE_CLOSE);
   

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
   CopyBuffer(ma_handle,0,0,3,maArray);   
   for(int i=0;i<rates_total;i++)
     {
         maArray[i] = close[i];
     }
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
