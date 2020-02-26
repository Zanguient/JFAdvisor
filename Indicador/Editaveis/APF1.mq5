//+------------------------------------------------------------------+
//|                                                         APF1.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      ""
#property version   "1.00"

#property indicator_chart_window
#property indicator_buffers 1
#property indicator_plots   1

//--- plot Label1
#property indicator_label1  "Label1"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrRed
#property indicator_style1  STYLE_SOLID
#property indicator_width1  2
//--- indicator buffers
double         Label1Buffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,Label1Buffer,INDICATOR_DATA);
   
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
   int start =0;
   if(prev_calculated>0) start=rates_total-1;
   
   for(int i=start;i<rates_total;i++)
     {
         double media =0;
         if(i>20)
           {
               for(int j=0;j<20;j++)
                 {
                     media += close[i-j];
                 }
               media = media/20;
           }
           Label1Buffer[i] = media;
     }

/*   
   for(int i=start;i<rates_total;i++)
     {
         Label1Buffer[i] = (high[i]+low[i])/2 ;
     }
*/

//---
   return(rates_total);
  }
//+------------------------------------------------------------------+
