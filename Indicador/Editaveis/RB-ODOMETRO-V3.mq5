//+------------------------------------------------------------------+
//|                                               RB-ODOMETRO-V3.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property description "Calcula a velocidade da CV-MA-COMPOSTA"
#property indicator_separate_window
#property indicator_buffers 6
#property indicator_plots   2


//---
#property indicator_label1  "Sinal"

//--- plot ODO
#property indicator_label2  "ODO"
#property indicator_type2   DRAW_COLOR_HISTOGRAM
#property indicator_color2  clrRed,clrBlack,clrOrangeRed,clrDarkBlue,clrLightCyan
#property indicator_style2  STYLE_SOLID
#property indicator_width2  5

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+


input int             slip= 0;
input int             ma1 = 1;
input int             ma2 = 1;
input int             ma3 = 1;
input int             ma4 = 1;

input ENUM_MA_METHOD  mode = MODE_SMA;
input ENUM_APPLIED_PRICE price = PRICE_CLOSE;

input double          filtro = 0;


//---

//+------------------------------------------------------------------+
//|  Declaracao dos buffers                                          |
//+------------------------------------------------------------------+

double         Sinal[];
double         ODOBuffer[];
double         ODOColors[];
double         velocidade[];
double         media[];
double         array[];

//---

//+------------------------------------------------------------------+
//|  Declaracao dos handles                                          |
//+------------------------------------------------------------------+

int            handle;

//---

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{

//+------------------------------------------------------------------+
//|  Inicializacao dos buffers                                       |
//+------------------------------------------------------------------+

   SetIndexBuffer(0, Sinal, INDICATOR_DATA);
   SetIndexBuffer(1, ODOBuffer, INDICATOR_DATA);
   SetIndexBuffer(2, ODOColors, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(3, velocidade, INDICATOR_DATA);
   SetIndexBuffer(4, media, INDICATOR_DATA);
   SetIndexBuffer(5, array, INDICATOR_DATA);
   
//---

//+------------------------------------------------------------------+
//|  Configuracao dos indicadores                                    |
//+------------------------------------------------------------------+

   IndicatorSetInteger(INDICATOR_DIGITS, _Digits);

//---

//+------------------------------------------------------------------+
//|  Inicializacao dos indicadores                                   |
//+------------------------------------------------------------------+

   handle = iCustom(_Symbol, _Period,"estudo\\CV-MA-COMPOSTA",slip,ma1,ma2,ma3,ma4,price,mode);

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
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

   CopyBuffer(handle, 1, 0, qtdCopiada, array);

//---
      for(int i= inicio ;i<rates_total;i++)
        {            
            Sinal[i]       = 0;            
            velocidade[i]  = (array[i] - array[i-1]);
            
            media[i]       = (velocidade[i] + velocidade[i-1])/2;
            
            ODOBuffer[i]   = media[i];
//            ODOBuffer[i]   = array[i];
            
//+------------------------------------------------------------------+
//| Politica de cores e sinais                                       |
//+------------------------------------------------------------------+
            
            
            // As cores serao as mesmas da media
            
            if(media[i] > media[i-1])
              {
               // compra
               ODOColors[i] = 1;
               Sinal[i] = 1;
              }
            else
            if(media[i] < media[i-1])
              {
               // venda
               ODOColors[i] = 0;
               Sinal[i] = -1;
              }
            
            if(media[i] < filtro && media[i] > -filtro)
              {
              // n/d
               ODOColors[i] = 4;
               Sinal[i] = 0;
              }
        }

//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
