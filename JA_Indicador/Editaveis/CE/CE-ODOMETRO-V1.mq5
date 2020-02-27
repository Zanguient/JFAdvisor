//+------------------------------------------------------------------+
//|                                               RB-ODOMETRO-V1.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//---  Velocidade Instantanea

//+------------------------------------------------------------------+
//|  NOTA IMPORTANTE                                                 |
//+------------------------------------------------------------------+
//
//    As politicas de cores deste indicador e equivalente ao indicador
//    candles, no entanto, a informacao relevante neste indicaador e 
//    a velocidade em que os precos se movem no candle em questao.
//
//---


#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers 3
#property indicator_plots   2





//---
#property indicator_label1  "Sinal"

//--- plot ODO
#property indicator_label2  "ODO"
#property indicator_type2   DRAW_COLOR_HISTOGRAM
#property indicator_color2  clrGray,clrRoyalBlue
#property indicator_style2  STYLE_SOLID
#property indicator_width2  3
//--- indicator buffers
double         Sinal[];

double         ODOBuffer[];
double         ODOColors[];

input group "SETUP"
input int filtro = 0;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
   SetIndexBuffer(0, Sinal, INDICATOR_DATA);
   SetIndexBuffer(1, ODOBuffer, INDICATOR_DATA);
   SetIndexBuffer(2, ODOColors, INDICATOR_COLOR_INDEX);

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
      inicio = 1;
      qtdCopiada = rates_total;
   } else {
      inicio = prev_calculated -1;
      qtdCopiada = 4;
   }


//---

   double velocidade ;
   for(int i = inicio; i < rates_total; i++) {

      velocidade = close[i] - open[i];

      Sinal[i] = 0;
      ODOBuffer[i] = velocidade;
      if(ODOBuffer[i] >= 0) {
         ODOColors[i] = 1;
         Sinal[i] = 1;
      }
      if(ODOBuffer[i] < 0) {
         ODOColors[i] = 0;
         Sinal[i] = -1;
      }

      if(ODOBuffer[i] < filtro && ODOBuffer[i] > -filtro ) {
         ODOColors[i] = 4;
         Sinal[i] = 0;
      }
   }

//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
