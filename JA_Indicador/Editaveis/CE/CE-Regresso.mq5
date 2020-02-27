//+------------------------------------------------------------------+
//|                                                     Regresso.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      ""
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 2
#property indicator_plots   2
//--- plot Compra
#property indicator_label1  "Compra"
#property indicator_type1   DRAW_ARROW
#property indicator_color1  clrDarkTurquoise
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- plot Venda
#property indicator_label2  "Venda"
#property indicator_type2   DRAW_ARROW
#property indicator_color2  clrRed
#property indicato_style2  STYLE_SOLID
#property indicator_width2  1
//--- indicator buffers
double         CompraBuffer[];
double         VendaBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,CompraBuffer,INDICATOR_DATA);
   SetIndexBuffer(1,VendaBuffer,INDICATOR_DATA);
   
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
   return(rates_total);
  }
//+------------------------------------------------------------------+
