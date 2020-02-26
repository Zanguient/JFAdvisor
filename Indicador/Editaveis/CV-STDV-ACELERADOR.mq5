//+------------------------------------------------------------------+
//|                                             CV-NV-ACELERADOR.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers   5
#property indicator_plots     2

#property indicator_label1    "Sinal"

#property indicator_label2    "Plot"
#property indicator_type2     DRAW_COLOR_HISTOGRAM
#property indicator_color2    clrBlack, clrRed
#property indicator_width2    1

double   Sinal[];
double   PlotBuffer[];
double   PlotColor[];

double   Array[];
int      Handle;
double velocidade[];


input int periodo = 20;
input int shift = 0;
input ENUM_MA_METHOD mode = MODE_SMA;
input ENUM_APPLIED_PRICE price = PRICE_CLOSE;

   
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping

   SetIndexBuffer(0, Sinal,      INDICATOR_DATA);
   SetIndexBuffer(1, PlotBuffer, INDICATOR_DATA);
   SetIndexBuffer(2, PlotColor,  INDICATOR_COLOR_INDEX);
   SetIndexBuffer(3, Array,      INDICATOR_DATA);
   SetIndexBuffer(4, velocidade, INDICATOR_DATA);
   
   
//--- Captura de Sinal de indicadores externos
   Handle= iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA", 0, 2, 2, 2, 2, PRICE_CLOSE, MODE_SMA);
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
//|                                                                  |
//+------------------------------------------------------------------+

   int inicio;
   int qtdCopiada;

   if(prev_calculated == 0) {
      inicio = 3;
      qtdCopiada = rates_total;
   } else {
      inicio = prev_calculated -1;
      qtdCopiada = 1;
   }


//---
   
   CopyBuffer(Handle, 1, 0, qtdCopiada, Array);
   
   double media = 0;
   
   for(int i=inicio;i<rates_total;i++)
     {
         double angulo = MathArctan((Array[i] - Array[i-1])/30)*(180/M_PI);
         
         
         Sinal[i] = 0;
         
         if(angulo > 10)
           {
            Sinal[i] = 1;
           }
         if(angulo < -10)
           {
            Sinal[i] = -1;
           }        
         PlotBuffer[i] = angulo;
         PlotColor[i] = 0;
         
     }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
