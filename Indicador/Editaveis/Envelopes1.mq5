//+------------------------------------------------------------------+
//|                                                   Envelopes1.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      ""
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 3
#property indicator_plots   3
//--- plot Superior
#property indicator_label1  "Superior"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrRed
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- plot Inferior
#property indicator_label2  "Inferior"
#property indicator_type2   DRAW_LINE
#property indicator_color2  clrRed
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1
//--- plot Inferior
#property indicator_label3  "MA"
#property indicator_type3   DRAW_LINE
#property indicator_color3  clrRed
#property indicator_style3  STYLE_SOLID
#property indicator_width3  1

//--- envelopes
double         SuperiorBuffer[];
double         InferiorBuffer[];
double         maBuf[];
double         multiBuffer[];
int            maHandle;
int multiHandle;



   input int periodo = 14;
   input double desvio = 0.009;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,SuperiorBuffer,INDICATOR_DATA);
   SetIndexBuffer(1,InferiorBuffer,INDICATOR_DATA);
   SetIndexBuffer(2,maBuf, INDICATOR_DATA);
   SetIndexBuffer(3,multiBuffer,INDICATOR_DATA);
   
   
   
   maHandle = iMA(_Symbol,_Period,30,0, MODE_EMA, PRICE_MEDIAN);
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
    CopyBuffer(maHandle,0,0,rates_total,maBuf);
    CopyBuffer(multiHandle,0,0,)
   
   for(int i=periodo-1 ;i<rates_total;i++)
     {
     
    
      
      double media = 0;

          
      SuperiorBuffer[i] = maBuf[i]+40;
      InferiorBuffer[i] = maBuf[i]-40;
     
     }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
