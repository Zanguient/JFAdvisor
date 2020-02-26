//+------------------------------------------------------------------+
//|                                                 CV-NIVELADOR.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property description "Baseado em CV-NIVELADOR"
#property description "Observa o comportamento em torno de uma media Central"




#property indicator_separate_window

#property indicator_height    15
#property indicator_maximum   1
#property indicator_minimum   0

#property indicator_buffers   8
#property indicator_plots     3


//--- Sinal
#property indicator_label1  "Sinal IN"

//--- plot Horizonte
#property indicator_label2  "(0) Horizonte"
#property indicator_type2   DRAW_COLOR_LINE
#property indicator_color2  clrGray, clrBlack,clrRed, clrYellow, clrNONE
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1


//--- plot Horizonte
#property indicator_label3  "(0) Ondas"
#property indicator_type3   DRAW_COLOR_HISTOGRAM
#property indicator_color3  clrGray, clrBlack,clrRed, clrYellow, clrNONE
#property indicator_style3  STYLE_SOLID
#property indicator_width3  5


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

input int                     ma_MARE = 34;
input int                     ma_ONDA = 5;
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
   

   IndicatorSetInteger(INDICATOR_DIGITS,_Digits);
   
   PrecoMedioHandle  = iMA(_Symbol, _Period, ma_ONDA,    0, metodo, price);
   horizonteHandle   = iMA(_Symbol, _Period, ma_MARE,    0, metodo, price);


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
       inicio = 20;
       qtdCopiada = rates_total;
     }
   else
     {
      inicio = prev_calculated -1;
      qtdCopiada = 5;
     }

//---

   CopyBuffer(horizonteHandle,   0, 0, qtdCopiada, horizonteCalc);
   CopyBuffer(PrecoMedioHandle,  0, 0, qtdCopiada, PrecoMedioCalc);

   for(int i = inicio; i < rates_total; i++) {
   
      horizontePlot[i]     = 1;
      horizonteColor[i]    = 0;
      
      calc[i] = PrecoMedioCalc[i] - horizonteCalc[i];   
      
      PrecoMedioPlot[i] = 1;
      
      if(calc[i] > calc[i - 1] ) {
         PrecoMedioColor[i]   = 1;
         sinal[i] = 1;
      } else {
         PrecoMedioColor[i]   = 2;
         sinal[i] = -1;
      }
   }
//--- return value of prev_calculated for next call
   return(rates_total);
}



//+------------------------------------------------------------------+
