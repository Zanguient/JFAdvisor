//+------------------------------------------------------------------+
//|                                                CV-RENKO-CAND.mq5 |
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
#property indicator_label1  "Open"
#property indicator_type1   DRAW_COLOR_CANDLES
#property indicator_color1  clrBlack,clrRoyalBlue
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1

//--- indicator buffers
double         OpenBuffer[];
double         HighBuffer[];
double         LowBuffer[];
double         CloseBuffer[];
double         ColorsBuffer[];
double         RenkoBuffer[];

int renko_stored;


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class RENKO
{
public:
   double            open;
   double            high;
   double            low;
   double            close;
};

RENKO renko;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
   SetIndexBuffer(0, OpenBuffer, INDICATOR_DATA);
   SetIndexBuffer(1, HighBuffer, INDICATOR_DATA);
   SetIndexBuffer(2, LowBuffer, INDICATOR_DATA);
   SetIndexBuffer(3, CloseBuffer, INDICATOR_DATA);
   SetIndexBuffer(4, ColorsBuffer, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(5, RenkoBuffer, INDICATOR_CALCULATIONS);

   ArraySetAsSeries(OpenBuffer, true);
   ArraySetAsSeries(HighBuffer, true);
   ArraySetAsSeries(LowBuffer, true);
   ArraySetAsSeries(CloseBuffer, true);
   ArraySetAsSeries(ColorsBuffer, true);

   PlotIndexSetDouble(0, PLOT_EMPTY_VALUE, 0);
   PlotIndexSetDouble(1, PLOT_EMPTY_VALUE, 0);
   PlotIndexSetDouble(2, PLOT_EMPTY_VALUE, 0);
   PlotIndexSetDouble(3, PLOT_EMPTY_VALUE, 0);
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
   
   int i;
   bool formNew = false;
   int inicio;

// Se dados nao forem lidos antes
   if(prev_calculated == 0) {
      inicio = 0;

   }
// Se os dados ja forem lidos antes
   else {
      inicio = renko_stored - 1;
      
   }

   MqlTick TickVet[];
   CopyTicks(_Symbol,TickVet,COPY_TICKS_ALL,rates_total);
   
   for( i = inicio; i < rates_total; i++) {
      CloseBuffer[i] = TickVet[i].last + 10;
      OpenBuffer[i]  = TickVet[i].last;
      HighBuffer[i]  = TickVet[i].last + 10;
      LowBuffer[i]   = TickVet[i].last - 10;
      ColorsBuffer[i] = 0;
      renko_stored++;
   }


//--- return value of prev_calculated for next call
   return(rates_total);
}



//+------------------------------------------------------------------+
