//+------------------------------------------------------------------+
//|                                                        Snack.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      ""
#property version   "1.00"
//+------------------------------------------------------------------+
//|  Globais                                                         |
//+------------------------------------------------------------------+
//---  Manipulador de media movel
int ABuffer = INVALID_HANDLE;

double BBurfer[];


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   ArraySetAsSeries(BBurfer,true);
   
//--- atribuir
   ABuffer = iMA(_Symbol,_Period,15,0,MODE_EMA,PRICE_CLOSE);
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---

   
   CopyBuffer(ABuffer,0,0,3, BBurfer);
   
   double a = BBurfer[1]-BBurfer[2];
   Print(a);   
   
  }
