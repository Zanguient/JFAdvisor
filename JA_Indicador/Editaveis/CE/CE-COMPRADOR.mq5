//+------------------------------------------------------------------+
//|                                                    COMPRADOR.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers 4
#property indicator_plots   1
//--- plot Sinal
#property indicator_label1  "Sinal"
#property indicator_type1   DRAW_COLOR_HISTOGRAM
#property indicator_color1  clrRed,clrGreen
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- indicator buffers
double         SinalBuffer[];
double         SinalColors[];


MqlTick     tickArray[];
MqlTick     tick;

MqlRates    rates[];
double      volumes[];
double      medias[];
double      sell_volumes[];

double ask, bid;
long   ask_volume, bid_volume;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
   SetIndexBuffer(0, SinalBuffer, INDICATOR_DATA);
   SetIndexBuffer(1, SinalColors, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(2, medias,      INDICATOR_CALCULATIONS);
   SetIndexBuffer(3, volumes, INDICATOR_DATA);
   MarketBookAdd(_Symbol);
   ArraySetAsSeries(rates, true);
   ArraySetAsSeries(sell_volumes, true);
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

   CopyTicks(_Symbol, tickArray, COPY_TICKS_TRADE);
   
 
// 
//   int buy =0; 
//   int sell = 0;
//   
//   for(int i=0;i<ArraySize(tickArray);i++)
//     {
//         if((tickArray[i].flags&TICK_FLAG_BUY) == TICK_FLAG_BUY)
//           {
//               buy ++; 
//           }
//         else
//         if((tickArray[i].flags&TICK_FLAG_SELL) == TICK_FLAG_SELL)
//           {
//               sell ++;
//           }
//         Comment( tickArray[i].volume_real,"\n",buy,"\n", sell);
//         SinalBuffer[i] = ;
//         SinalColors[i] = 0;   
//     }   
   
   
   return(rates_total);
}
//+------------------------------------------------------------------+


