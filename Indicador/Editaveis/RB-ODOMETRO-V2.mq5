//+------------------------------------------------------------------+
//|                                               RB-ODOMETRO-V1.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//--- Velocidade Media


#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers 6
#property indicator_plots   2
#property indicator_level1 10
#property indicator_level2 -10
#property indicator_levelcolor clrBlack
#property indicator_levelstyle STYLE_DOT


//--- pl
#property indicator_label1  "Sinal"

//--- plot ODO
#property indicator_label2  "ODO"
#property indicator_type2   DRAW_COLOR_HISTOGRAM
#property indicator_color2  clrRed,clrBlack,clrOrangeRed,clrDarkBlue,clrLightCyan
#property indicator_style2  STYLE_SOLID
#property indicator_width2  5
//--- indicator buffers



//---


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double         Sinal[];

double         ODOBuffer[];
double         ODOColors[];

double         velocidade[];
double         media[];
double         array[];

int            handle;

input int      filtro = 0;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   SetIndexBuffer(0, Sinal, INDICATOR_DATA);
   SetIndexBuffer(1, ODOBuffer, INDICATOR_DATA);
   SetIndexBuffer(2, ODOColors, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(3, velocidade, INDICATOR_DATA);
   SetIndexBuffer(4, media, INDICATOR_DATA);
   SetIndexBuffer(5, array, INDICATOR_DATA);

//---

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

   IndicatorSetInteger(INDICATOR_DIGITS, _Digits);

//---

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

   handle = iCustom(_Symbol, _Period, "estudo\\CV-MA");

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
       inicio = 4;
       qtdCopiada = rates_total;
     }
   else
     {
      inicio = prev_calculated -1;
      qtdCopiada = 5;
     }
   
//---

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

   CopyBuffer(handle, 0, 0, qtdCopiada, array);

//---
   for(int i = inicio ; i < rates_total; i++) {
      velocidade[i] = (close[i] - open[i]);

      media[i] = (velocidade[i] + velocidade[i - 1] + velocidade[i - 2] + velocidade[i - 3] + velocidade[i - 4]) / 5;

      Sinal[i] = 0;

      ODOBuffer[i] = media[i];
      ODOColors[i] = 1;



//+------------------------------------------------------------------+
//|  Politica de cores e sinais                                      |
//+------------------------------------------------------------------+

      if(media[i] >= media[i - 1]) {
         // alta
         ODOColors[i] = 1;
         Sinal[i] = 1;
      }
      else
      if(media[i] < media[i - 1])
        {
         // baixa
         ODOColors[i] = 0;
         Sinal[i] = -1;
        }
        
      if(media[i] < filtro && media[i] > -filtro) {
         // limbo
         ODOColors[i] = 4;
         Sinal[i] = 0;
      }
   }

//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
