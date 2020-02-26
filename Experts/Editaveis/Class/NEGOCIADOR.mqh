//+------------------------------------------------------------------+
//|                                                   NEGOCIADOR.mqh |
//|                                           Miqueias da S. Miranda |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      ""
#property version   "1.00"

#include <Trade\\Trade.mqh>
//+------------------------------------------------------------------+
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//+------------------------------------------------------------------+

//int               estado;
//bool              FreeBuy;
//bool              FreeSell;
//long              MagicNumber;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//void              Olho(int Sinal);
//void              Compra();
//void              Venda();
//void              Revercao();
//void              Fechamento();
//int               Posicionamento();
//bool              OrdensPendentes();
//bool              isNewBar();

//+------------------------------------------------------------------+
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//+------------------------------------------------------------------+
class _NEGOCIADOR
{
public:

   long              MagicNumber; //ID do Robo

   bool              disponivel;  //Verificar Posisao e Ordens
   bool              comprando;   //ORDER_TYPE_BUY
   bool              vendendo;    //ORDER_TYPE_SELL


   bool              comprado;    //POSITION_TYPE_BUY
   bool              vendido;     //POSITION_TYPE_SELL
   //---
   //---
   //---
   void              Load();
   void              VaiAsCompras();
   void              VaiAsVendas();
   void              VaiEmbora();
   void              Disponibilidade();
private:
   int               Posicionamento();
   int               OrdensPendentes();
   void              TestaOrdens();
   void              TestaPosicao();
};

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void _NEGOCIADOR::Disponibilidade(void)
{
   TestaPosicao();
   TestaOrdens();
   if( !comprado && !vendido && !comprando && !vendendo) {
      disponivel = true;
   } else {
      disponivel = false;
   }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void _NEGOCIADOR::Load(void)
{
   disponivel  = false;
   comprando   = false;
   vendendo    = false;
   comprado    = false;
   vendido     = false;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void _NEGOCIADOR::VaiAsCompras(void)
{
   CTrade            trade;
   MqlTick           tick;
   SymbolInfoTick(_Symbol, tick);
   double preco = tick.bid;
   trade.SetExpertMagicNumber(MagicNumber);
   trade.Buy(1, _Symbol, preco, 0, 0, "Compra a Mercado");
//---
   comprando = true;
//---
   Sleep(1000);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void _NEGOCIADOR::VaiAsVendas(void)
{
   CTrade            trade;
   MqlTick           tick;
   SymbolInfoTick(_Symbol, tick);
   double preco = tick.ask;
   trade.SetExpertMagicNumber(MagicNumber);
   trade.Sell(1, _Symbol, preco, 0, 0, "Venda a Mercado");
//---
   vendendo = true;
//---
   Sleep(1000);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void _NEGOCIADOR::VaiEmbora(void)
{
   CTrade Trade;
   for(int i = PositionsTotal(); i >= 0; i--) {
      if(PositionGetSymbol(i) == _Symbol) {
         Trade.PositionClose(PositionGetTicket(i));
      }
   }
   Sleep(1000);
}



//+------------------------------------------------------------------+
//| CANDLE A CANDLE - APONTADOR                                      |
//+------------------------------------------------------------------+
bool isNewBar()
{
   static datetime last_time = 0;
   datetime lastbar_time = (datetime) SeriesInfoInteger(_Symbol, _Period, SERIES_LASTBAR_DATE);
   if(last_time == 0) {
      last_time = lastbar_time;
      return false;
   }
   if(last_time != lastbar_time) {
      last_time = lastbar_time;
      return true;
   }
   return false;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int _NEGOCIADOR::Posicionamento(void)
{
   for(int i = PositionsTotal() - 1; i >= 0; i--) {
      string symbol  = PositionGetSymbol(i);
      ulong magic    = PositionGetInteger(POSITION_MAGIC);
      if(symbol == _Symbol && magic == MagicNumber) {
         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
            return 1;
         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
            return -1;
      }
   }
   return 0;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int _NEGOCIADOR::OrdensPendentes(void)
{
   for(int i = OrdersTotal() - 1; i >= 0; i--) {
      //---
      ulong ticket   = OrderGetTicket(i);
      string symbol  = OrderGetString(ORDER_SYMBOL);
      ulong  magic   = OrderGetInteger(ORDER_MAGIC);
      if(symbol == _Symbol && magic == MagicNumber) {
         if(OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_BUY)
            return 1;
         if(OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL)
            return -1;
      }
   }
   return 0;
}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void _NEGOCIADOR::TestaOrdens()
{
   if(OrdensPendentes() == 1) {
      comprando = true;
   } else if(OrdensPendentes() == -1) {
      vendendo = true;
   } else {
      comprando   = false;
      vendendo    = false;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  _NEGOCIADOR::TestaPosicao(void)
{
   if(Posicionamento() == 1) {
      comprado = true;
   } else if(Posicionamento() == -1) {
      vendido = true;
   } else {
      comprado = false;
      vendido = false;
   }
}
//+------------------------------------------------------------------+
