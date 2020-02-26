//+------------------------------------------------------------------+
//|                                                      linhas1.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+




// HLineCreate
// HLineMove
// HLineDelete
int OnInit()
  {
//--- indicator buffers mapping
   lineCreate("last");  
   
MqlTick tickAtual;
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

    double fech = SymbolInfoDouble(_Symbol,SYMBOL_LAST);
   ObjectMove(0,"last",0,0, fech);
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+

void lineCreate(
                string            name="Hline"      //Nome da linha
)
{
   ObjectCreate(0,name, OBJ_ARROW_STOP, 0,0,0);
   ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_BOTTOM);
   ObjectSetInteger(0,name, OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(0,name, OBJPROP_WIDTH, 1);
   ObjectSetInteger(0,name,OBJPROP_STYLE, STYLE_DASHDOTDOT);
} 