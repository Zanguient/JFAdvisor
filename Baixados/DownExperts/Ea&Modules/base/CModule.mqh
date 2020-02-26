//+------------------------------------------------------------------+
//|                                                    EA_Module.mqh |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include "CStrategy.mqh"

class CModule {
   public:
      CModule() {m_strategy = NULL;}
     ~CModule() {}
     virtual bool SetStrategy(CStrategy* strategy) {
                     if(CheckPointer(strategy) == POINTER_INVALID) return false;
                     m_strategy = strategy;
                     return true;
                  }//bool SetStrategy(CStrategy* strategy)   
   protected:   
      CStrategy* m_strategy;  
};
