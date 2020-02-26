//+------------------------------------------------------------------+
//|                                                     SinalIFR.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      ""
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 3
#property indicator_plots   3
//--- plot Venda
#property indicator_label1  "Venda"
#property indicator_type1   DRAW_ARROW
#property indicator_color1  clrRed
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- plot Compra
#property indicator_label2  "Compra"
#property indicator_type2   DRAW_ARROW
#property indicator_color2  clrMediumTurquoise
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1
//--- plot IFR
#property indicator_label3  "IFR"
#property indicator_type3   DRAW_NONE
#property indicator_color3  clrRed
#property indicator_style3  STYLE_SOLID
#property indicator_width3  1
//--- input parameters
input int      Periodos=14;
//--- indicator buffers
double         VendaBuffer[];
double         CompraBuffer[];
double         IFRBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,VendaBuffer,INDICATOR_DATA);
   SetIndexBuffer(1,CompraBuffer,INDICATOR_DATA);
   SetIndexBuffer(2,IFRBuffer,INDICATOR_DATA);
//--- setting a code from the Wingdings charset as the property of PLOT_ARROW
   PlotIndexSetInteger(0,PLOT_ARROW,159);
   PlotIndexSetInteger(1,PLOT_ARROW,159);
   
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

   
   CopyBuffer(iRSI(_Symbol,_Period,Periodos,PRICE_CLOSE),0,0,rates_total,IFRBuffer);
//--- return value of prev_calculated for next call
   for(int i=1;i<rates_total;i++)
     {
         CompraBuffer[i] = IFRBuffer[i-1] <30 && IFRBuffer[i]>=30 ? low[i] : 0;
         VendaBuffer[i] =  IFRBuffer[i-1] >70 && IFRBuffer[i]<=70 ? close[i] : 0;
     }
   return(rates_total);
  }
//+------------------------------------------------------------------+
