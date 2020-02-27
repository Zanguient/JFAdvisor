//+------------------------------------------------------------------+
//|                                                   CV-BuySell.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window

#property indicator_buffers   6
#property indicator_plots     2



#property indicator_label1 "Buy"
#property indicator_type1  DRAW_COLOR_LINE
#property indicator_color1 clrRoyalBlue, clrBlack
#property indicator_style1 STYLE_SOLID
#property indicator_width1 2

#property indicator_label2 "Sell"
#property indicator_type2  DRAW_COLOR_LINE
#property indicator_color2 clrRoyalBlue, clrBlack
#property indicator_style2 STYLE_SOLID
#property indicator_width2 2

double   BuyBuffer[];
double   BuyColor[];
double   SellBuffer[];
double   SellColor[];

double   suporteA[];
double   suporteB[];

int handle;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping

   SetIndexBuffer(0, BuyBuffer,  INDICATOR_DATA);
   SetIndexBuffer(1, BuyColor,   INDICATOR_COLOR_INDEX);
   SetIndexBuffer(2, SellBuffer, INDICATOR_DATA);
   SetIndexBuffer(3, SellColor,  INDICATOR_COLOR_INDEX);
   SetIndexBuffer(4, suporteA,   INDICATOR_DATA);
   SetIndexBuffer(5, suporteB,   INDICATOR_DATA);

   handle = iCustom(_Symbol, _Period, "estudo\\CV-Demanda", 8);

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

   int inicio;
   int qtdCopy;

   qtdCopy  = rates_total;
   inicio   = 1;

   CopyBuffer(handle, 0, 0, qtdCopy, suporteA);
   CopyBuffer(handle, 1, 0, qtdCopy, suporteB);

   double  TotalVolume;

   for(int i = inicio; i < rates_total; i++) {

      TotalVolume = suporteA[i] + suporteB[i];

      BuyColor[i]    = 0;
      SellColor[i]   = 1;
      BuyBuffer[i]   = ((suporteA[i] * 100) / TotalVolume)-50;
      SellBuffer[i]  = ((suporteB[i] * 100) / TotalVolume)-50;
      
//      if(BuyBuffer[i] < BuyBuffer[i-1])
//         {
//            BuyColor[i] = 1;
//         }
//            
//      if(SellBuffer[i] < SellBuffer[i-1])
//         {
//            SellColor[i] = 0;
//         }
      
   }

   ChartRedraw(0);

//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
