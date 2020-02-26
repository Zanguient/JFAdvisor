//+------------------------------------------------------------------+
//|                                                     EA-Rules.mqh |
//|                                                           Andrei |
//|                                               http://fxstill.com |
//+------------------------------------------------------------------+
#property copyright "Andrei"
#property link      "http://fxstill.com"
#property strict

class CInitializeStruct {};

class CStrategy  {
public:
   virtual  string  Name() const = 0;
   virtual  bool    Initialize(CInitializeStruct* pInit) = 0;
   virtual  void    CreateSnap()     = 0;  
   virtual  bool    MayAndEnter()    = 0;  
   virtual  bool    MayAndContinue() = 0;       
   virtual  void    MayAndClose()    = 0;
   virtual  bool    Stop()           = 0;   
   virtual  void    OnBuyFind  (ulong ticket, double price, double lot) = 0;
   virtual  void    OnBuySFind (ulong ticket, double price, double lot) = 0;   
   virtual  void    OnBuyLFind (ulong ticket, double price, double lot) = 0;
   virtual  void    OnSellFind (ulong ticket, double price, double lot) = 0;   
   virtual  void    OnSellSFind(ulong ticket, double price, double lot) = 0;   
   virtual  void    OnSellLFind(ulong ticket, double price, double lot) = 0;        
};// class CStrategy
