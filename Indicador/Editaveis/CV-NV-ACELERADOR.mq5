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
#property indicator_color2    clrBlack, clrRed, clrYellow
#property indicator_width2    5

double   Sinal[];
double   PlotBuffer[];
double   PlotColor[];

double   Array[];
int      Handle;
double velocidade[];

input int filtro = 0;
input int periodo_longo = 20;
input int periodo_curto = 5;


input ENUM_MA_METHOD mode = MODE_SMA;
input ENUM_APPLIED_PRICE price = PRICE_MEDIAN;
   
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
   Handle = iCustom(_Symbol, _Period, "estudo\\CV-NIVELADOR", filtro, periodo_longo, periodo_curto, mode, price);   
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
       inicio = 3;
       qtdCopiada = rates_total;
     }
   else
     {
      inicio = prev_calculated -1;
      qtdCopiada = 5;
     }
   
//---

   CopyBuffer(Handle, 3, 0, qtdCopiada, Array);
   double media = 0;
   for(int i=inicio;i<rates_total;i++)
     {
         Sinal[i] = 0;
         velocidade[i] = Array[i] - Array[i-1];
         media = (velocidade[i] + velocidade[i-1] + velocidade[i-2] + velocidade[i-3])/4;
         PlotBuffer[i] = media;
         
         
         if(PlotBuffer[i] >= PlotBuffer[i-1])
           {
         PlotColor[i] = 0;
         Sinal[i] = 1;   
           }
         else
         if(PlotBuffer[i] < PlotBuffer[i-1])
           {
         Sinal[i] = -1;  
         PlotColor[i] = 1;   
           }
           
         if(PlotBuffer[i] < filtro && PlotBuffer[i] > -filtro)
           {
         PlotColor[i] = 2;
         Sinal[i] = 0;
           }
     }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
