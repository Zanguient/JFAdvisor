//+------------------------------------------------------------------+
//|                                                   EA-defines.mqh |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property strict

#include "CModule.mqh"

class CParam: public CModule {
public:     
   double dStopLevel;      
   double dFreezeLevel;    
   double dMaxSVol;        
   int    iMaxOrder;          
    CParam() {
      iMaxOrder    = (int)AccountInfoInteger(ACCOUNT_LIMIT_ORDERS);
      dMaxSVol     = SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_LIMIT);
      new_day();
#ifdef __DEBUG__    
      Print("CParam created...");
#endif         
    }//EA_PARAM()
    void new_day() {
      dStopLevel   = SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL) * Point();
      dFreezeLevel = SymbolInfoInteger(Symbol(),SYMBOL_TRADE_FREEZE_LEVEL) * Point();
    }//void new_day()
};