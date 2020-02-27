//+------------------------------------------------------------------+
//|                                              CV-MA-SUAVIZADA.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window

#property indicator_buffers 9
#property indicator_plots   2

//--- Sinal
#property indicator_label1  "Sinal V2"

//--- plot Horizonte
#property indicator_label2  "Grafico"
#property indicator_type2   DRAW_COLOR_LINE
#property indicator_color2   clrRed, clrBlack, clrGray, clrRoyalBlue, clrYellow, clrNONE
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1

//+------------------------------------------------------------------+
//|  Variaveis de entrada do usuario                                 |
//+------------------------------------------------------------------+
input group    "SETUP DA MEDIA"
input int                  slep     = 0;
input int                  periodo  = 20;
input ENUM_MA_METHOD       modo_1   = MODE_SMMA;
input ENUM_MA_METHOD       modo_2   = MODE_EMA;

//---

//+------------------------------------------------------------------+
//| Declaracao dos buffers de sinal e plot                           |
//+------------------------------------------------------------------+

double   Sinal[];
double   Plot[];
double   PlotColor[];

//---


//+------------------------------------------------------------------+
//|  Declaracao dos handles e buffers de calculo                     |
//+------------------------------------------------------------------+

int   ma1_open_handle;
int   ma1_close_handle;
int   ma1_median_handle;

int   ma1_low_handle;
int   ma1_high_handle;

int   ma2_open_handle;
int   ma2_close_handle;
int   ma2_median_handle;

int   ma2_low_handle;
int   ma2_high_handle;

//---

double   ma1_open_array[];
double   ma1_close_array[];
double   ma1_median_array[];

double   ma2_open_array[];
double   ma2_close_array[];
double   ma2_median_array[];

double   ma1_low_array[];
double   ma1_high_array[];

double   ma2_low_array[];
double   ma2_high_array[];

//---

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{

//+------------------------------------------------------------------+
//| Inicializar os buffers                                           |
//+------------------------------------------------------------------+

   SetIndexBuffer(0, Sinal,   INDICATOR_DATA);
   SetIndexBuffer(1, Plot,    INDICATOR_DATA);
   SetIndexBuffer(2, PlotColor,  INDICATOR_COLOR_INDEX);
   SetIndexBuffer(3, ma1_open_array, INDICATOR_DATA);
   SetIndexBuffer(4, ma1_close_array, INDICATOR_DATA);
   SetIndexBuffer(5, ma1_median_array, INDICATOR_DATA);
   SetIndexBuffer(6, ma2_open_array, INDICATOR_DATA);
   SetIndexBuffer(7, ma2_close_array, INDICATOR_DATA);
   SetIndexBuffer(8, ma2_median_array, INDICATOR_DATA);

//---

//+------------------------------------------------------------------+
//|  Configuracoes do indicador                                      |
//+------------------------------------------------------------------+

   IndicatorSetInteger(INDICATOR_DIGITS, _Digits);

//---

//+------------------------------------------------------------------+
//| Inicializar o handles                                            |
//+------------------------------------------------------------------+

   ma1_open_handle      = iMA(_Symbol, _Period, periodo, 0, modo_1, PRICE_OPEN);
   ma1_close_handle     = iMA(_Symbol, _Period, periodo, 0, modo_1, PRICE_CLOSE);
   ma1_median_handle    = iMA(_Symbol, _Period, periodo, 0, modo_1, PRICE_MEDIAN);

   ma2_open_handle      = iMA(_Symbol, _Period, periodo, 0, modo_2, PRICE_OPEN);
   ma2_close_handle     = iMA(_Symbol, _Period, periodo, 0, modo_2, PRICE_CLOSE);
   ma2_median_handle    = iMA(_Symbol, _Period, periodo, 0, modo_2, PRICE_MEDIAN);



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

   if(prev_calculated == 0) {
      inicio = 2;
      qtdCopiada = rates_total;
   } else {
      inicio = prev_calculated - 1;
      qtdCopiada = 5;
   }

//---

//+------------------------------------------------------------------+
//|  Carregar informacoes nos Buffers                                |
//+------------------------------------------------------------------+

   CopyBuffer(ma1_open_handle,   0, 0, qtdCopiada, ma1_open_array);
   CopyBuffer(ma1_close_handle,  0, 0, qtdCopiada, ma1_close_array);
   CopyBuffer(ma1_median_handle, 0, 0, qtdCopiada, ma1_median_array);


   CopyBuffer(ma2_open_handle,   0, 0, qtdCopiada, ma2_open_array);
   CopyBuffer(ma2_close_handle,  0, 0, qtdCopiada, ma2_close_array);
   CopyBuffer(ma2_median_handle, 0, 0, qtdCopiada, ma2_median_array);



//---

//+------------------------------------------------------------------+
//| Calcular a media das medias moveis                               |
//+------------------------------------------------------------------+

   for(int i = inicio; i < rates_total; i++) {
      double media = ( ma1_open_array[i] + ma1_close_array[i] + ma1_median_array[i]  + ma2_open_array[i] + ma2_close_array[i] + ma2_median_array[i]  ) / 6 ;



      Plot[i] = media + slep;
      PlotColor[i] = 4;

      if(Plot[i] < Plot[i - 1]) {
         PlotColor[i] = 0;
         Sinal[i] = -1;
      } else if(Plot[i] > Plot[i - 1]) {
         PlotColor[i] = 1;
         Sinal[i] = 1;
      }
   }

//---

//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
