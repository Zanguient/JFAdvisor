//+------------------------------------------------------------------+
//|                                                   Ea&Modules.mq5 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
#property strict

#include "RealStrat1.mqh"
#include "RealStrat2.mqh"
#include "PanelDialog.mqh"

enum CSTRAT {
   strategy_1 = 1,
   strategy_2 = 2
};

input CSTRAT strt    = strategy_1;
input double dlot   = 0.01;
input int    profit = 50;
input int    stop   = 50;
input long   Magic  = 123456;

CParam par;
CSnap  snap;
CTradeMod trade;

CStrategy* pS1;
CSTRAT str_curr = -1;

datetime dtNow;

CPanelDialog EDlg;

int OnInit()
  {  
   trade.dBaseLot = dlot;
   trade.dProfit  = profit * _Point;
   trade.dStop    = stop   * _Point;
   trade.lMagic   = Magic;
   snap.m_lmagic  = Magic;
   if (!SwitchStrategy(strt) ) return (INIT_FAILED);
   dtNow = -1;
   
   if(!EDlg.Create(0,pS1.Name(),0,50,50,390,200)) return(INIT_FAILED);
   
   if(!EDlg.Run())  return(INIT_FAILED);
   EDlg.AddStrategy(CRealStrat1::m_name, strategy_1);
   EDlg.AddStrategy(CRealStrat2::m_name, strategy_2);        
   return (INIT_SUCCEEDED);
  }
  
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
      EDlg.Destroy(reason);
      if (CheckPointer(pS1) != POINTER_INVALID) delete pS1;      
  }
  
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
      if (id == CHARTEVENT_OBJECT_CLICK && StringCompare(sparam, EDlg.GetButtonName()) == 0 ) {
         SwitchStrategy((CSTRAT)EDlg.GetStratID() );
      } 
      else EDlg.ChartEvent(id,lparam,dparam,sparam);
  }  
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
      if (IsNewCandle() ){
         pS1.CreateSnap();
         pS1.MayAndEnter();
         
      }     
  }
//+------------------------------------------------------------------+
bool IsNewCandle() {
   datetime d = iTime(NULL, PERIOD_CURRENT, 0);
   if (dtNow == -1 || dtNow != d) {
      dtNow = d;
      return true;
   }  
   return false;
}

bool SwitchStrategy(CSTRAT sr) {
   if (str_curr == sr) return true;
   CStrategy* s = NULL;
   switch(sr) {
      case strategy_1:
         {
            s = new CRealStrat1();
            CInit1 ci;
            if (!ci.Initialize(GetPointer(par), GetPointer(snap), GetPointer(trade)) ) return false;
            s.Initialize(GetPointer(ci));  
         }
         break;
      case strategy_2:
         {
            s = new CRealStrat2();
            CInit2 ci;
            if (!ci.Initialize(GetPointer(par), GetPointer(snap), GetPointer(trade)) ) return false;
            s.Initialize(GetPointer(ci));              
         }   
         break;
   }
   if (s == NULL) return false;
   if (CheckPointer(pS1) != POINTER_INVALID) delete pS1;
   pS1 = s;    
   str_curr = sr;
   EDlg.Caption(pS1.Name() );
   return true;
}