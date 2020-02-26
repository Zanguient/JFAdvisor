//+------------------------------------------------------------------+
//|                                                   RealStrat1.mqh |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "base\CStrategy.mqh"
#include "base\CParam.mqh"
#include "base\CSnap.mqh"
#include "base\CTrade.mqh"

class CInit2: public CInitializeStruct {
public:
   bool Initialize(CParam* pparam, CSnap* psnap, CTradeMod* ptrade) {
   if (CheckPointer(pparam) == POINTER_INVALID || 
       CheckPointer(psnap)  == POINTER_INVALID) return false;   
      m_pparam = pparam; 
      m_psnap  = psnap;
      m_ptrade = ptrade;
       return true;
   }
   CParam* m_pparam;
   CSnap*  m_psnap;
   CTradeMod* m_ptrade;
};

class CRealStrat2 : public CStrategy   {
public:
   static   string  m_name;
                     CRealStrat2(){};
                    ~CRealStrat2(){};
   virtual  string  Name() const {return "Real Strategy 2";}
   virtual  bool    Initialize(CInitializeStruct* pInit) {
                        m_pparam = ((CInit2* )pInit).m_pparam;
                        m_psnap = ((CInit2* )pInit).m_psnap;
                        m_ptrade = ((CInit2* )pInit).m_ptrade;
                        m_psnap.SetStrategy(GetPointer(this));
                        return true;
                    }//Initialize(EA_InitializeStruct* pInit)
   virtual  void    CreateSnap() {
                        m_tb = 0;
                        m_psnap.CreateSnap();
                    }  
   virtual  bool    MayAndEnter();
   virtual  bool    MayAndContinue() {return false;}       
   virtual  void    MayAndClose()   {}
   virtual  bool    Stop()            {return false;}   
   virtual  void    OnBuyFind  (ulong ticket, double price, double lot) {m_tb = ticket;}
   virtual  void    OnBuySFind (ulong ticket, double price, double lot) {}   
   virtual  void    OnBuyLFind (ulong ticket, double price, double lot) {}
   virtual  void    OnSellFind (ulong ticket, double price, double lot) {}  
   virtual  void    OnSellSFind(ulong ticket, double price, double lot) {}   
   virtual  void    OnSellLFind(ulong ticket, double price, double lot) {}      
private:
   CParam* m_pparam;
   CSnap*  m_psnap;  
   CTradeMod* m_ptrade;   
   ulong m_tb;            
};
static string CRealStrat2::m_name = "Real Strategy 2";

bool CRealStrat2::MayAndEnter() {
   if (m_tb != 0) return false;  
   double o = iOpen(NULL,PERIOD_CURRENT,1); 
   double c = iClose(NULL,PERIOD_CURRENT,1); 
   if (c > o) {
      m_ptrade.Buy();
      return true;
   }   
   return false;
} 