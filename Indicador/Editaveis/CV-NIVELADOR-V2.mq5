//+------------------------------------------------------------------+
//|                                                 CV-NIVELADOR.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"



#property indicator_separate_window





#property indicator_buffers   7
#property indicator_plots     3


//--- Sinal
#property indicator_label1  "Sinal IN"

//--- plot Horizonte
#property indicator_label2  "(0) Horizonte "


//--- plot Horizonte
#property indicator_label3  "(2) Ondas"
#property indicator_type3   DRAW_COLOR_HISTOGRAM
#property indicator_color3  clrGray, clrBlack,clrRed, clrYellow, clrNONE
#property indicator_style3  STYLE_SOLID
#property indicator_width3  5


int                           horizonteHandle;
double                        horizontePlot[];
double                        horizonteCalc[];

int                           PrecoMedioHandle;
double                        PrecoMedioPlot[];
double                        PrecoMedioColor[];
double                        PrecoMedioCalc[];

double                        sinal[];

double                        calc[];

input int                     filtro    = 0;

input int                     hsplit    = 0;
input int                     hma1      = 19;
input int                     hma2      = 18;
input int                     hma3      = 17;
input int                     hma4      = 16;
input ENUM_MA_METHOD          hmode     = MODE_SMA;
input ENUM_APPLIED_PRICE      hprice    = PRICE_CLOSE;

input int                     osplit    = 0;
input int                     oma1      = 1;
input int                     oma2      = 1;
input int                     oma3      = 1;
input int                     oma4      = 1;
input ENUM_MA_METHOD          omode     = MODE_SMA;
input ENUM_APPLIED_PRICE      oprice    = PRICE_CLOSE;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping

   SetIndexBuffer(0, sinal,           INDICATOR_DATA);
   SetIndexBuffer(1, horizontePlot,   INDICATOR_DATA);
   
   SetIndexBuffer(2, PrecoMedioPlot,  INDICATOR_DATA);
   SetIndexBuffer(3, PrecoMedioColor, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(4, horizonteCalc,   INDICATOR_DATA );
   SetIndexBuffer(5, PrecoMedioCalc,  INDICATOR_DATA);
   SetIndexBuffer(6, calc,            INDICATOR_CALCULATIONS);


   IndicatorSetInteger(INDICATOR_DIGITS, _Digits);

   PrecoMedioHandle  = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA", osplit, oma1, oma2, oma3, oma4, oprice, omode);
   horizonteHandle   = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA", hsplit, hma1, hma2, hma3, hma4, hprice, hmode);


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
      inicio = 20;
      qtdCopiada = rates_total;
   } else {
      inicio = prev_calculated -1;
      qtdCopiada = 4;
   }


//---
   CopyBuffer(horizonteHandle,   1, 0, qtdCopiada, horizonteCalc);
   CopyBuffer(PrecoMedioHandle,  1, 0, qtdCopiada, PrecoMedioCalc);

   for(int i = inicio; i < rates_total; i++) {

      horizontePlot[i]     = 0;

      calc[i] = PrecoMedioCalc[i] - horizonteCalc[i];

      PrecoMedioPlot[i] = calc[i];

      if(calc[i] > calc[i - 1] ) {
         PrecoMedioColor[i]   = 1;
         sinal[i] = 1;
      } else {
         PrecoMedioColor[i]   = 2;
         sinal[i] = -1;
      }
      if(PrecoMedioPlot[i] < filtro && PrecoMedioPlot[i] > -filtro)
        {
         PrecoMedioColor[i]   = 3;
         sinal[i] = 0;
        }
   }
//--- return value of prev_calculated for next call
   return(rates_total);
}



//+------------------------------------------------------------------+
