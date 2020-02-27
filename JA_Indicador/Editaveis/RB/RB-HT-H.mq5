//+------------------------------------------------------------------+
//|                                                      CV-ASHI.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window

#property description "Heiken Ashi"

#property indicator_height    15
#property indicator_maximum   1
#property indicator_minimum   0

#property indicator_buffers 5
#property indicator_plots   2

#property indicator_label1  "Sinal IN"


//--- plot Ashi_Candles
#property indicator_label2  "Sinal Plot"
#property indicator_type2   DRAW_COLOR_HISTOGRAM
#property indicator_color2  clrRed,clrBlack
#property indicator_style2  STYLE_SOLID
#property indicator_width2  5

int            ashi_handle;
double         ashi_array[];

double         ashi_open[];
double         ashi_close[];
double         Sinal[];

//--- indicator buffers
double         Ashi_Open_Array[];
double         Ashi_CandlesColors[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
   SetIndexBuffer(0, Sinal,               INDICATOR_DATA);
   SetIndexBuffer(1, Ashi_Open_Array,     INDICATOR_DATA);
   SetIndexBuffer(2, Ashi_CandlesColors,  INDICATOR_COLOR_INDEX);
   SetIndexBuffer(3, ashi_open,           INDICATOR_DATA);
   SetIndexBuffer(4, ashi_close,           INDICATOR_DATA);
   
   IndicatorSetInteger(INDICATOR_DIGITS, _Digits);

   ashi_handle = iCustom(_Symbol, _Period, "Examples\\Heiken_Ashi");
   

   

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
       inicio = 0;
       qtdCopiada = rates_total;
     }
   else
     {
      inicio = prev_calculated -1;
      qtdCopiada = 5;
     }
   
//---
   CopyBuffer(ashi_handle, 1, 0, qtdCopiada, ashi_open);
   CopyBuffer(ashi_handle, 4, 0, qtdCopiada, ashi_close);

   
   for(int i = inicio; i < rates_total; i++) {
      
      Ashi_Open_Array[i] = 1;
      
      if(ashi_open[i] < ashi_close[i]) {
         Ashi_CandlesColors[i] = 1;
         Sinal[i] = 1;
      } else {
         Ashi_CandlesColors[i] = 0;
         Sinal[i] = -1;
      }
   }

//--- return value of prev_calculated for next call
   return(rates_total);




}
//+------------------------------------------------------------------+
