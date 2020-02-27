//+------------------------------------------------------------------+
//|                                                      CV-SENO.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers   3
#property indicator_plots     1

#property indicator_maximum 1.2
#property indicator_minimum -1.2


//#property indicator_level1  0.1
//#property indicator_level2  0.2
//#property indicator_level3  0.3
//#property indicator_level4  0.4
//#property indicator_level5  0.5
//#property indicator_level6  0.6
//#property indicator_level7  0.7
//#property indicator_level8  0.8
//#property indicator_level9  0.9
//#property indicator_level10 1.0
//#property indicator_level11 -1
//#property indicator_level12 -0.1
//#property indicator_level13 -0.2
//#property indicator_level14 -0.3
//#property indicator_level15 -0.4
//#property indicator_level16 -0.5
//#property indicator_level17 -0.6
//#property indicator_level18 -0.7
//#property indicator_level19 -0.8
//#property indicator_level20 -0.9


#property indicator_label1 "Seno"
#property indicator_type1  DRAW_COLOR_HISTOGRAM
#property indicator_style1 STYLE_SOLID
#property indicator_color1 clrRed
#property indicator_width1 1

input int filtroSin = 5000;
input double filtroZero = 0;
input int ma1 = 2;

double      Seno[];
double      SenoColor[];
double      Calc[];

int         handle;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping

   SetIndexBuffer(0, Seno,       INDICATOR_DATA);
   SetIndexBuffer(1, SenoColor,  INDICATOR_COLOR_INDEX);
   SetIndexBuffer(2, Calc,       INDICATOR_DATA);

   handle = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, ma1, PRICE_MEDIAN, MODE_SMA);

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

   int inicio;
   int qtdCopy;

   if(prev_calculated == 0) {
      inicio   = 1;
      qtdCopy  = rates_total;
   } else {
      inicio   = prev_calculated - 1;
      qtdCopy  = 3;
   }

   CopyBuffer(handle, 1, 0, qtdCopy, Calc);

   for(int i = inicio; i < rates_total; i++) {
      SenoColor[i] = 0;
      
      double calc = MathSin((MathArctan(( NormalizeDouble(Calc[i], 0) - NormalizeDouble(Calc[i - 1], 0) ) / filtroSin) * 180) / M_PI);
      
      if(calc < filtroZero && calc > -filtroZero ) {
         calc = 0;
      }
      
      Seno[i] = calc;
      
      if(Seno[i] > Seno[i-1])
        {
            SenoColor[i] = 1;
        } 
   }

   return(rates_total);
}
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
