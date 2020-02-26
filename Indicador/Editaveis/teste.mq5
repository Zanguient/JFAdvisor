//+------------------------------------------------------------------+
//|                                                        teste.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                                                  |
//+------------------------------------------------------------------+

#property indicator_chart_window
#property indicator_buffers 1
#property indicator_plots 1

//--- plot A
#property indicator_label1 "A"
#property indicator_type1 DRAW_LINE
#property indicator_color1 clrBlue
#property indicator_style1 STYLE_SOLID
#property indicator_width1 1



//--- indicator buffers
double         ABuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,ABuffer,INDICATOR_DATA);
   
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
   for(int i=0 ; i<rates_total; i++)
   {
   
   // 
   ABuffer[i] = high[i];
   
   } 
   
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
