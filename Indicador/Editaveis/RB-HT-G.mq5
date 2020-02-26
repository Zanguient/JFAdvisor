//+------------------------------------------------------------------+
//|                                                       CV-SAR.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"

#property description "Baseado no indicador Sar"

#property indicator_separate_window

#property indicator_height  15
#property indicator_minimum 0
#property indicator_maximum 1

#property indicator_buffers 4
#property indicator_plots   2

#property indicator_label1  "Sinal IN"

//--- plot Mostrador
#property indicator_label2  "Mostrador"
#property indicator_type2   DRAW_COLOR_HISTOGRAM
#property indicator_color2  clrRed,clrBlack
#property indicator_style2  STYLE_SOLID
#property indicator_width2  5


//--- indicator buffers
double         MostradorBuffer[];
double         MostradorColors[];

double         Sinal_IN[], SARArray[];

input    group "CONFIGURACAO SAR"
input  double        step  = 0.2;
input  double        max   = 0.5;

int SAR;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0, Sinal_IN, INDICATOR_DATA);
   SetIndexBuffer(1, MostradorBuffer,INDICATOR_DATA);
   SetIndexBuffer(2, MostradorColors,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(3, SARArray, INDICATOR_DATA);
   
   IndicatorSetInteger(INDICATOR_DIGITS, _Digits);
   
   SAR = iSAR(_Symbol,_Period,step,max);
   
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

   CopyBuffer(SAR,0,0,qtdCopiada,SARArray);

   
//--- return value of prev_calculated for next call
   for(int i=inicio;i<rates_total;i++)
     {
     
      double media = (high[i] + low[i])/2;
      
      MostradorBuffer[i] = 1;
      MostradorColors[i] = 2;
      if(SARArray[i] > media )
        {
            MostradorColors[i] = 0;
            Sinal_IN[i] = -1;
        }
      else
      if(SARArray[i] < media)
        {
            MostradorColors[i] = 1;
            Sinal_IN[i] = 1;
        }
      
     }
   return(rates_total);
//+------------------------------------------------------------------+
}