//+------------------------------------------------------------------+
//|                                                 RB-CONSOLIDA.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers   3
#property indicator_plots     2

#property indicator_label1    "Sinal"

#property indicator_label2    "Plot"
#property indicator_type2     DRAW_COLOR_LINE
#property indicator_color2    clrBlack, clrRed
#property indicator_width2    1

double   Sinal[];
double   PlotBuffer[];
double   PlotColor[];





//--- Handles

int handleA;
int handleB;
int handleC;
int handleD;
int handleE;
int handleF;
int handleG;
int handleH;
int handleI;
int handleJ;



enum ENUM_RB_HT {
   NONE,
   RB_HT_A,
   RB_HT_B,
   RB_HT_C,
   RB_HT_D,
   RB_HT_E,
   RB_HT_F,
   RB_HT_G,
   RB_HT_H,
   RB_HT_I,
   RB_HT_J
};

input group "SETUP INDICADOR 1 >>>"
input int                  h1_periodo  = 1;
input ENUM_MA_METHOD       h1_mode     = MODE_SMA;
input ENUM_APPLIED_PRICE   h1_price    = PRICE_CLOSE;

input group "SETUP INDICADOR 2 >>>"
input int                  h2_periodo  = 2;
input ENUM_MA_METHOD       h2_mode     = MODE_SMA;
input ENUM_APPLIED_PRICE   h2_price    = PRICE_CLOSE;

input group "SETUP INDICADOR 3 >>>"
input int                  h3_periodo  = 3;
input ENUM_MA_METHOD       h3_mode     = MODE_SMA;
input ENUM_APPLIED_PRICE   h3_price    = PRICE_CLOSE;

input group "SETUP INDICADOR 4 >>>"
input int                  h4_split    = 0;
input int                  h4_ma1      = 1;
input int                  h4_ma2      = 1;
input int                  h4_ma3      = 1;
input int                  h4_ma4      = 1;
input ENUM_MA_METHOD       h4_mode     = MODE_SMA;
input ENUM_APPLIED_PRICE   h4_price    = PRICE_CLOSE;


//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping



   SetIndexBuffer(0, Sinal,      INDICATOR_DATA);
   SetIndexBuffer(1, PlotBuffer, INDICATOR_DATA);
   SetIndexBuffer(2, PlotColor,  INDICATOR_COLOR_INDEX);

//--- Captura de Sinal de indicadores externos (13)





   handle1 = iCustom(_Symbol, _Period, "estudo\\Rubro-Negro\\RB-HT-A", h1_periodo, h1_mode, h1_price);
   handle2 = iCustom(_Symbol, _Period, "estudo\\Rubro-Negro\\RB-HT-A", h2_periodo, h2_mode, h2_price);
   handle3 = iCustom(_Symbol, _Period, "estudo\\Rubro-Negro\\RB-HT-A", h3_periodo, h3_mode, h3_price);


   handle4 = iCustom(_Symbol, _Period, "estudo\\Rubro-Negro\\RB-HT-B", h4_split, h4_ma1, h4_ma2, h4_ma3, h4_ma4, h3_price, h3_mode);



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

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   CopyBuffer(,,,qtdCopiada,);
//---

   for(int i=inicio;i<total;i++)
     {
      
     }
      


//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
