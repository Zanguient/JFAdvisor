//+------------------------------------------------------------------+
//|                                                    EA-Helper.mqh |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property strict

#include "CModule.mqh"

class CSnap: public CModule {
public:
           void CSnap()  {
               m_lmagic = -1; 
               m_symbol = Symbol(); 
#ifdef __DEBUG__    
               Print("CSnap created...");
#endif                  
           }
   virtual void  ~CSnap() {}   
           bool   CreateSnap();
           long   m_lmagic;
           string m_symbol;
};

bool CSnap::CreateSnap() {
   if (m_strategy == NULL) return false;
   int total = PositionsTotal(); 
   ulong ticket;
   ENUM_POSITION_TYPE type;
   double l, p;
   for (int i = total - 1; i >= 0; i--) {
      if ( (ticket = PositionGetTicket(i)) != 0) {
         if (StringLen(m_symbol) == 0 || PositionGetString(POSITION_SYMBOL) == m_symbol) {
            if (m_lmagic < 0 || PositionGetInteger(POSITION_MAGIC) == m_lmagic) {
               type = (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
               l    = PositionGetDouble(POSITION_VOLUME);
               p    = PositionGetDouble(POSITION_PRICE_OPEN);
               switch(type) {
                  case POSITION_TYPE_BUY:
                     m_strategy.OnBuyFind(ticket, p, l);
                     break;
                  case POSITION_TYPE_SELL:
                     m_strategy.OnSellFind(ticket, p, l);
                     break;
               }//switch(type)
            }//if (lmagic < 0 || PositionGetInteger(POSITION_MAGIC) == lmagic)
         }//if (StringLen(symbol) == 0 || PositionGetString(POSITION_SYMBOL) == symbol)
      }//if ( (ticket = PositionGetTicket(i)) != 0)
   }//for (int i = total - 1; i >= 0; i--)
   return true;
}