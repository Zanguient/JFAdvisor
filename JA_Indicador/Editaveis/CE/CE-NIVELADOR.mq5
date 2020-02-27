//+------------------------------------------------------------------+
//|                                                 CV-NIVELADOR.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"



#property indicator_separate_window





#property indicator_buffers   8
#property indicator_plots     3


//--- Sinal
#property indicator_label1  "Sinal IN"

//--- plot Horizonte
#property indicator_label2  "(0) Horizonte "
#property indicator_type2   DRAW_COLOR_LINE
#property indicator_color2  clrGray, clrGreen,clrRed, clrYellow, clrNONE
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1


//--- plot Horizonte
#property indicator_label3  "(3) Ondas"
#property indicator_type3   DRAW_COLOR_LINE
#property indicator_color3  clrGray, clrBlack,clrRed, clrYellow, clrNONE
#property indicator_style3  STYLE_SOLID
#property indicator_width3  1


int                           horizonteHandle;
double                        horizontePlot[];
double                        horizonteColor[];
double                        horizonteCalc[];

int                           PrecoMedioHandle;
double                        PrecoMedioPlot[];
double                        PrecoMedioColor[];
double                        PrecoMedioCalc[];

double                        sinal[];

double                        calc[];

input int                     filtro = 0;

input int                     ma_MARE = 34;
input int                     ma_ONDA = 5;
input int                     periodo = 3;

input ENUM_MA_METHOD          metodo  = MODE_SMA;
input ENUM_APPLIED_PRICE      price   = PRICE_CLOSE;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
   SetIndexBuffer(0, sinal,           INDICATOR_DATA);
   SetIndexBuffer(1, horizontePlot,   INDICATOR_DATA);
   SetIndexBuffer(2, horizonteColor,  INDICATOR_COLOR_INDEX);
   SetIndexBuffer(3, PrecoMedioPlot,  INDICATOR_DATA);
   SetIndexBuffer(4, PrecoMedioColor, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(5, horizonteCalc,   INDICATOR_DATA );
   SetIndexBuffer(6, PrecoMedioCalc,  INDICATOR_DATA);
   SetIndexBuffer(7, calc,            INDICATOR_CALCULATIONS);
   IndicatorSetInteger(INDICATOR_DIGITS, _Digits);
//---
   PrecoMedioHandle  = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, ma_ONDA);
   horizonteHandle  = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, ma_MARE);
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
   int qtdCopiado;
   if(prev_calculated == 0) {
      inicio = ma_MARE;
      qtdCopiado = rates_total;
   } else {
      inicio = prev_calculated - 1;
      qtdCopiado = 2;
   }
//---
   CopyBuffer(horizonteHandle,   1, 0, qtdCopiado, horizonteCalc);
   CopyBuffer(PrecoMedioHandle,  1, 0, qtdCopiado, PrecoMedioCalc);
   for(int i = inicio; i < rates_total; i++) {
      
      horizonteColor[i]    = 2;
      calc[i] = PrecoMedioCalc[i] - horizonteCalc[i];
      //---
      PrecoMedioPlot[i] = calc[i];
      
      double media = 0;
      for(int j = 0; j < periodo; j++) {
         media += calc[i - j]/periodo;
      }
      horizontePlot[i]     = media;
      //---
      if(calc[i] > calc[i - 1] ) {
         PrecoMedioColor[i]   = 2;
         sinal[i] = 1;
      } else {
         PrecoMedioColor[i]   = 2;
         sinal[i] = -1;
      }
      //---
      if(calc[i] < filtro && calc[i] > -filtro ) {
         PrecoMedioColor[i]   = 3;
         sinal[i] = 0;
      }
   }
//--- return value of prev_calculated for next call
   return(rates_total);
}



//+------------------------------------------------------------------+
