//+------------------------------------------------------------------+
//|                                                    APONTADOR.mqh |
//|                                           Miqueias da S. Miranda |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      ""
#property version   "1.00"

#include "..\\INCLUDES\\CV-HLine.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
struct AUX {
   int               id;
   double            price;
};
struct REGISTRO {
   int               id;
   double            price;
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class _APONTADOR
{
private:
   //---
   MqlTick           tickTrade;
   MqlTick           rp[];
   //---
   int               max;
   int               mid_high;
   int               mid_low;
   int               min;
   AUX               aux;
   REGISTRO          tradeLevel[4];
   CvHLine           tradeLine[4];
   void              ReloadTradeLines();
   void              RotacionaUp();
   void              RotacionaDown();
   void              RotacionaColisoesUp();
   void              RotacionaColisoesDown();
   void              Cores();
public:
   int               passo;
   bool              colideUp;
   bool              colideDown;
   bool              ativoCompra;
   bool              ativoVenda;
   //---
   // ultima_colizao = estara o id da linha transpassada pelo preco
   // proxima_acima  =
   // proxima_abaixo =
   //---
   //---
   void              Load();
   void              LoadTradeLines();
   void              LoadSensorLines();
   void              DellTradeLines();
   void              TradeLevel();
   void              MonitoraColisoes();


};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void _APONTADOR::Cores(void)
{
   ativoCompra = false;
   ativoVenda = true;
   if(ativoCompra) {
      tradeLine[max].Color(clrLime);
      tradeLine[mid_high].Color(clrLime);
      tradeLine[mid_low].Color(clrLime);
      tradeLine[min].Color(clrLime);
   } else if(ativoVenda) {
      tradeLine[max].Color(clrRed);
      tradeLine[mid_high].Color(clrRed);
      tradeLine[mid_low].Color(clrRed);
      tradeLine[min].Color(clrRed);
   } else if(!ativoCompra && !ativoVenda) {
      tradeLine[max].Color(clrGray);
      tradeLine[mid_high].Color(clrGray);
      tradeLine[mid_low].Color(clrGray);
      tradeLine[min].Color(clrGray);
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void _APONTADOR::Load(void)
{
}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void _APONTADOR::ReloadTradeLines(void)
{
   tradeLine[max].Move(tradeLevel[max].price);
   tradeLine[mid_high].Move(tradeLevel[mid_high].price);
   tradeLine[mid_low].Move(tradeLevel[mid_low].price);
   tradeLine[min].Move(tradeLevel[min].price);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void _APONTADOR::LoadTradeLines()
{
   TradeLevel();
   tradeLine[max].Load     ("TradeLine-" + IntegerToString(max) + "", tradeLevel[max].price, clrRoyalBlue);
   tradeLine[mid_high].Load("TradeLine-" + IntegerToString(mid_high) + "", tradeLevel[mid_high].price, clrRoyalBlue);
   tradeLine[mid_low].Load ("TradeLine-" + IntegerToString(mid_low) + "", tradeLevel[mid_low].price, clrRoyalBlue);
   tradeLine[min].Load     ("TradeLine-" + IntegerToString(min) + "", tradeLevel[min].price, clrRoyalBlue);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void _APONTADOR::LoadSensorLines(void)
{
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  _APONTADOR::DellTradeLines()
{
   tradeLine[max].Delete();
   tradeLine[mid_high].Delete();
   tradeLine[mid_low].Delete();
   tradeLine[min].Delete();
//---
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void _APONTADOR::TradeLevel(void)
{
   if(SymbolInfoTick(_Symbol, tickTrade)) {
      Print("Ok ", tickTrade.last);
   } else {
      Print("SymbolInfoTick() falhou, erro: ", GetLastError());
   }
//---
   max      = 3;
   mid_high = 2;
   mid_low  = 1;
   min      = 0;
//---
   double level_medio = tickTrade.last ;
   tradeLevel[max].price         = level_medio + (passo / 2) + (passo * 3);
   tradeLevel[mid_high].price    = level_medio + (passo / 2) + (passo * 2);
   tradeLevel[mid_low].price     = level_medio + (passo / 2) + (passo * 1);
   tradeLevel[min].price         = level_medio + (passo / 2) + (passo * 0);
   Comment(
      "\nMax", tradeLevel[max].price,
      "\nMid High", tradeLevel[mid_high].price,
      "\nMid Low", tradeLevel[mid_low].price,
      "\nMin", tradeLevel[min].price
   );
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void _APONTADOR::RotacionaUp()
{
   ZeroMemory(aux.id);
   ZeroMemory(aux.price);
   aux.id      = min;
   aux.price   = tradeLevel[max].price + passo;
   min      = mid_low;
   mid_low  = mid_high;
   mid_high = max;
   max      = aux.id;
   tradeLevel[max].price = aux.price;
   ReloadTradeLines();
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  _APONTADOR::RotacionaDown()
{
   ZeroMemory(aux.id);
   ZeroMemory(aux.price);
   aux.id      = max;
   aux.price   = tradeLevel[min].price ;
   max      = mid_high;
   mid_high = mid_low;
   mid_low  = min;
   min      = aux.id;
   tradeLevel[min].price       = aux.price - passo;
   ReloadTradeLines();
}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void _APONTADOR::MonitoraColisoes()
{
   Cores();
   ArraySetAsSeries(rp, true);
   CopyTicks(_Symbol, rp, COPY_TICKS_ALL, 0, 2);
   if(rp[0].last > tradeLevel[max].price) {
      RotacionaUp();
      colideUp = true;
      colideDown = false;
   } else if(rp[0].last > tradeLevel[mid_high].price && rp[1].last < tradeLevel[mid_high].price) {
      //--- Colisao subindo
      colideUp = true;
      colideDown = false;
   } else if(rp[0].last < tradeLevel[mid_high].price && rp[1].last > tradeLevel[mid_high].price) {
      //--- Colisao descendo
      colideUp = false;
      colideDown = true;
   } else if(rp[0].last > tradeLevel[mid_low].price && rp[1].last < tradeLevel[mid_low].price) {
      //--- Colisao subindo
      colideUp = true;
      colideDown = false;
   } else if(rp[0].last < tradeLevel[mid_low].price && rp[1].last > tradeLevel[mid_low].price) {
      //--- Colisao descendo
      colideUp = false;
      colideDown = true;
   } else if(rp[0].last < tradeLevel[min].price ) {
      //--- Colisao descendo
      colideUp = true;
      colideDown = true;
      RotacionaDown();
   } else {
      colideUp = false;
      colideDown = false;
   }
// se eu sei qual a ultima colisao, a proxima acima e a proxima abaixo
// isso reduz a quantidade de testes a ser realizadas.
}

//+------------------------------------------------------------------+
