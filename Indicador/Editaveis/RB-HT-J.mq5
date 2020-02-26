//+------------------------------------------------------------------+
//|                                        RB-MA-SUAVIZADA-V2-HT.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property description "Histograma baseado em CANDLES"
#property indicator_separate_window

#property indicator_buffers 3
#property indicator_plots   2
#property indicator_height    15

#property indicator_minimum 0
#property indicator_maximum 1

//--- plot Sinal_IN
#property indicator_label1  "Sinal_IN"

//--- plot Sinal_Plot
#property indicator_label2  "Sinal_Plot"
#property indicator_type2   DRAW_COLOR_HISTOGRAM
#property indicator_color2  clrRed,clrBlack,clrWhite
#property indicator_style2  STYLE_SOLID
#property indicator_width2  5

double         Sinal_INBuffer[];
double         Sinal_PlotBuffer[];
double         Sinal_PlotColors[];



input group "SETUP"






//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
      SetIndexBuffer(0, Sinal_INBuffer,   INDICATOR_DATA);
      SetIndexBuffer(1, Sinal_PlotBuffer, INDICATOR_DATA);
      SetIndexBuffer(2, Sinal_PlotColors, INDICATOR_COLOR_INDEX);
      
      
      IndicatorSetInteger(INDICATOR_DIGITS, _Digits);
      IndicatorSetString(INDICATOR_SHORTNAME, "RB-HT-J ("+IntegerToString(0)+")");
      
      
   
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
//---

   
      for(int i=inicio;i<rates_total;i++)
        {
            Sinal_PlotBuffer[i] = 1;          
            if(open[i] < close[i])
              {
                  Sinal_PlotColors[i] = 1;
                  Sinal_INBuffer[i] = 1;
              }
            else
            if(open[i] > close[i])
              {
                  Sinal_PlotColors[i] = 0;
                  Sinal_INBuffer[i] = -1;
              }
      
        }   

//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
