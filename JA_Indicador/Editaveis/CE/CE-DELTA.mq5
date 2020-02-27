//+------------------------------------------------------------------+
//|                                                     CV-DELTA.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window

//#property indicator_height    20
//#property indicator_maximum   1
//#property indicator_minimum   0

#property indicator_buffers   3
#property indicator_plots     2

//--- Sinal
#property indicator_label1  "Sinal IN"

//--- plot Horizonte
#property indicator_label2  "Sinal Plot"
#property indicator_type2   DRAW_COLOR_HISTOGRAM
#property indicator_color2  clrBlack,clrRed, clrGray, clrYellow, clrNONE
#property indicator_style2  STYLE_SOLID
#property indicator_width2  5

double            Sinal[];
double            buyPlot[];
double            buyColor[];
double            sellPlot[];
double            sellColor[];

int               custonHandle;
double            deltaArray[];
double            buyArray[];
double            sellArray[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
   SetIndexBuffer(0, Sinal, INDICATOR_DATA);
   SetIndexBuffer(1, buyPlot, INDICATOR_DATA);
   SetIndexBuffer(2, buyColor, INDICATOR_COLOR_INDEX);


   IndicatorSetInteger(INDICATOR_DIGITS, _Digits);
   

   custonHandle = iCustom(_Symbol, _Period, "estudo\\Baixados\\MQL5\\Indicators\\article_3708\\Delta_article");

   ArrayInitialize(deltaArray, EMPTY_VALUE);
   ArrayInitialize(buyArray, EMPTY_VALUE);
   ArrayInitialize(sellArray, EMPTY_VALUE);
   ArrayInitialize(Sinal, EMPTY_VALUE);
   
   
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


//+------------------------------------------------------------------+
//| calcula prev_calculate                                           |
//+------------------------------------------------------------------+
   
   int inicio;
   int qtdCopiada;
   
   if(prev_calculated == 0)
     {
       inicio = 6;
       qtdCopiada = rates_total;
     }
   else
     {
      inicio = prev_calculated -1;
      qtdCopiada = 5;
     }
   
//---
   
   CopyBuffer(custonHandle, 0, 0, qtdCopiada, deltaArray);
   CopyBuffer(custonHandle, 2, 0, qtdCopiada, buyArray);
   CopyBuffer(custonHandle, 3, 0, qtdCopiada, sellArray);





   for(int i = inicio - 1; i < rates_total; i++) {

         buyPlot[i]  = deltaArray[i];
         
      if(deltaArray[i] >= 0) {
         buyColor[i] = 0; 
         Sinal[i]    = 1;
      } else {
         buyColor[i] = 1;
         Sinal[i]    = -1;
      }






   }
//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
