//+------------------------------------------------------------------+
//|                                                    CV-SPARRI.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window

#property indicator_buffers 7
#property indicator_plots 4

#property indicator_label1 "Sinal"

#property indicator_label2 "Media 1"
#property indicator_type2 DRAW_COLOR_LINE
#property indicator_color2 clrYellow, clrRed
#property indicator_style2 STYLE_SOLID
#property indicator_width2 1

#property indicator_label3 "Media 2"
#property indicator_type3 DRAW_COLOR_LINE
#property indicator_color3 clrYellow, clrRed
#property indicator_style3 STYLE_SOLID
#property indicator_width3 1

#property indicator_label4 "Media 3"
#property indicator_type4 DRAW_COLOR_LINE
#property indicator_color4 clrYellow, clrRed
#property indicator_style4 STYLE_SOLID
#property indicator_width4 1

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+



input int                  periodo1 = 2;
input ENUM_MA_METHOD       mode1    = MODE_SMA;
input ENUM_APPLIED_PRICE   price1   = PRICE_CLOSE;


input int                  periodo2 = 3;
input ENUM_MA_METHOD       mode2    = MODE_SMA;
input ENUM_APPLIED_PRICE   price2   = PRICE_CLOSE;


input int                  periodo3 = 4;
input ENUM_MA_METHOD       mode3    = MODE_SMA;
input ENUM_APPLIED_PRICE   price3   = PRICE_CLOSE;

double   Sinal[];

double   array1[];
double   array1color[];
int      handle1;

double   array2[];
double   array2color[];
int      handle2;

double   array3[];
double   array3color[];
int      handle3;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping

   SetIndexBuffer(0, Sinal,       INDICATOR_DATA);
   SetIndexBuffer(1, array1,      INDICATOR_DATA);
   SetIndexBuffer(2, array1color, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(3, array2,      INDICATOR_DATA);
   SetIndexBuffer(4, array2color, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(5, array3,      INDICATOR_DATA);
   SetIndexBuffer(6, array3color, INDICATOR_COLOR_INDEX);

   handle1 = iMA(_Symbol, _Period, periodo1, 0, mode1, price1);
   handle2 = iMA(_Symbol, _Period, periodo2, 0, mode2, price2);
   handle3 = iMA(_Symbol, _Period, periodo3, 0, mode3, price3);
   
   ChartIndicatorAdd(0, 1,handle1);


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
   int qtdCopy;

   if(prev_calculated == 0) {
      inicio = 1;
      qtdCopy = rates_total;
   } else {
      inicio   = prev_calculated - 1;
      qtdCopy  = 1;
   }

//---

   CopyBuffer(handle1, 0, 0, qtdCopy, array1);
   CopyBuffer(handle2, 0, 0, qtdCopy, array2);
   CopyBuffer(handle3, 0, 0, qtdCopy, array3);

   for(int i = inicio; i < rates_total; i++) {

      if( (array1[i] < array1[i - 1] || array2[i] < array2[i - 1] || array3[i] < array3[i - 1]) ) {
         array1color[i] = 1;
         array2color[i] = 1;
         array3color[i] = 1;
         
         Sinal[i] = -1;

      } else {
         array1color[i] = 0;
         array2color[i] = 0;
         array3color[i] = 0;
         
         Sinal[i] = 1;
         
      }



   }

//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
