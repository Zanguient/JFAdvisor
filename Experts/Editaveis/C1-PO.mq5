//+------------------------------------------------------------------+
//|                                                        C1-PO.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"





#include                      <Trade\Trade.mqh>
#include                      <parametros.mqh>

CTrade                        trade;

input int                     ma_periodo  =  20;
input int                     ma_desloc   =  0;
input ulong                   magicNumber =  001;
input ulong                   desvPts     =  20;

input double                  lote        = 1;
input double                  stopLoss    = 50;
input double                  takeProfit  = 50;
input double                  gatilhoBE   = 2;
input double                  gatilhoTS   = 6;
input double                  stepTS      = 2;

double                        ask;
double                        bid;
double                        last;

double                        PRC;
double                        STL;
double                        TKP;

double                        compraArray[];
double                        vendaArray[];

bool                          posAberta;
bool                          ordPendente;
bool                          beAtivo;

int                           cv_handle;
int                           handle1;

bool                          sinalCompra;
bool                          sinalVenda;

input int                     horaIncioAbertura       = 9;//
input int                     minutoInicioAbertura    = 30;//
input int                     horaFimAbertura         = 16;//
input int                     minutoFimAbertura       = 45;//
input int                     horaIncioFechamento     = 17;//
input int                     minutoIncioFechamento   = 20;//

MqlTick                       ultimoTick; // Ultimos precos
MqlRates                      rates[];
MqlDateTime                   horaAtual;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
{
   trade.SetTypeFilling(ORDER_FILLING_RETURN);  // Tipo de venda
   trade.SetDeviationInPoints(desvPts);         // Desvio Aceitavel
   trade.SetExpertMagicNumber(magicNumber);     // ID do Robo
   

   
   ArraySetAsSeries(compraArray, true);
   ArraySetAsSeries(vendaArray,true);

   SymbolInfoTick(_Symbol, ultimoTick);
   
   cv_handle = iCustom(_Symbol, _Period, "estudo/CV-ABERTURA-LT");
   if(cv_handle == INVALID_HANDLE) {
      Print("Erro ao criar indicador! erro = ", GetLastError());
      return (INIT_FAILED);
   }
   if(horaIncioAbertura > horaFimAbertura || horaFimAbertura > horaIncioFechamento) {
      Alert("Inconsistencia de horario de Negociacao!");
      return(INIT_FAILED);
   }
   if(horaIncioAbertura == horaFimAbertura && minutoInicioAbertura >= minutoFimAbertura) {
      Alert("Inconsistencia de horario de Negociacao!");
      return(INIT_FAILED);
   }
   if(horaFimAbertura  == horaIncioFechamento &&  minutoFimAbertura >= minutoIncioFechamento) {
      Alert("Inconsistencia de horario de Negociacao!");
      return(INIT_FAILED);
   }
   
   return(INIT_SUCCEEDED);
//--- Inicializacao dos indiadores
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
{

//---  Recebe dados do indicador
   CopyBuffer(cv_handle, 0, 0, 20, compraArray);
   CopyBuffer(cv_handle, 2, 0, 20, vendaArray);
   
   if(compraArray[1] > 0)
     {
         sinalCompra = true;
     }else
   if(vendaArray[1] > 0)
     {
         sinalVenda = true;
     }
//---  Valida o Sinal de Compra e Venda

//--- Verificacao de Posicao de venda

   
   posAberta = false;
   for(int i = PositionsTotal() - 1; i >= 0; i--) {
      string symbol  = PositionGetSymbol(i);
      ulong  magic   = PositionGetInteger(POSITION_MAGIC);
      if(symbol == _Symbol && magic == magicNumber) {
         posAberta = true;
         break;
      }
   }
//--- Verificacao de Ordens
   ordPendente = false;
   for(int i = OrdersTotal() - 1 ; i >= 0; i--) {
      ulong ticket   = OrderGetTicket(i);
      ulong magic    = OrderGetInteger(ORDER_MAGIC);
      string symbol  = OrderGetString(ORDER_SYMBOL);
      if(symbol == _Symbol && magic == magicNumber) {
         ordPendente = true;
         break;
      }
   }
//--- Ativacao do BreakEvem
   if(!posAberta) {
      beAtivo = false;
   }
   if(posAberta && !beAtivo) {
      BreakEven(ultimoTick.last);
   }
//--- Ativacao do TraillingStop
   if(posAberta && beAtivo) {
      TraillingStop(ultimoTick.last);
   }
//---
//--- Opcoes de tempo

      Comment(
         "Dentro do horario de Negociacao!",
         sinalCompra ? "\nComprando true" : "\nComprando false",
         sinalVenda ? "\nVendendo true" : "\nVendendo false",
         "\nPreco Atual ",
         "\nEm Compra ", compraArray[0],
         "\nEm Venda  ", vendaArray[0]
      );

   if(HoraFechamento()) {
      Comment("Horario de fechamento de posicoes!");
   } else if(HoraNegociacao()) {

   } else {
      Comment("Fora do horario de Negociacao!");
      DeletaOrdens();
   }
   
//--- Executa Politicas de Negociacao
   if( sinalCompra && !posAberta && !ordPendente && HoraNegociacao()) {
      //--- Normalizacao dos precos
      PRC = NormalizeDouble(ultimoTick.ask,   _Digits);
      STL = NormalizeDouble(PRC - stopLoss,   _Digits);
      TKP = NormalizeDouble(PRC + takeProfit, _Digits);
      //---
      trade.Buy(lote, _Symbol, PRC, STL, TKP, NULL);
      sinalCompra = false;
   } else if( sinalVenda && !posAberta && !ordPendente && HoraNegociacao()) {
      //---
      PRC = NormalizeDouble(ultimoTick.bid,    _Digits);
      STL = NormalizeDouble(PRC + stopLoss,    _Digits);
      TKP = NormalizeDouble(PRC - takeProfit,   _Digits);
      //---
      trade.Sell(lote, _Symbol, PRC, STL, TKP, NULL);
      sinalVenda = false;
   }
}


//+------------------------------------------------------------------+
//    Implementacao de funcoes abaixo
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DeletaOrdens()
{
   for(int i = OrdersTotal() - 1; i >= 0; i--) {
      ulong ticket = OrderGetTicket(i);
      string symbol = OrderGetString(ORDER_SYMBOL);
      ulong magic = OrderGetInteger(ORDER_MAGIC);
      if(symbol == _Symbol && magic == magicNumber) {
         if(trade.OrderDelete(ticket)) {
            Print("Ordem Deletada - sem falha. ResultRetcode: ", trade.ResultRetcode(), ", ResultRetcodeDescription: ", trade.ResultRetcodeDescription() );
         } else {
            Print("Ordem Deletada - com falha. ResultRetcode: ", trade.ResultRetcode(), ", ResultRetcodeDescription: ", trade.ResultRetcodeDescription() );
         }
      }
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void FechaPosicao()
{
   for(int i = PositionsTotal() - 1; i >= 0 ; i--) {
      string symbol  = PositionGetString(POSITION_SYMBOL);
      ulong magic    = PositionGetInteger(POSITION_MAGIC);
      if(symbol == _Symbol && magic == magicNumber) {
         ulong PositionTicket = PositionGetInteger(POSITION_TICKET);
         if(trade.PositionClose(PositionTicket, desvPts)) {
            Print("Posicao Fechada - sem falha. ResultRetcode: ", trade.ResultRetcode(), ", ResultRetcodeDescription: ", trade.ResultRetcodeDescription() );
         } else {
            Print("Posicao Fechada - com falha. ResultRetcode: ", trade.ResultRetcode(), ", ResultRetcodeDescription: ", trade.ResultRetcodeDescription() );
         }
      }
   }
}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool HoraFechamento()
{
   TimeToStruct(TimeCurrent(), horaAtual);
   if(horaAtual.hour >= horaIncioFechamento) {
      if(horaAtual.hour == horaIncioFechamento) {
         if(horaAtual.min >= minutoIncioFechamento) {
            return true;
         } else {
            return false;
         }
      }
      return true;
   }
   return false;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool HoraNegociacao()
{
   TimeToStruct(TimeCurrent(), horaAtual);
   if(horaAtual.hour >= horaIncioAbertura && horaAtual.hour <= horaFimAbertura) {
      if(horaAtual.hour == horaIncioAbertura) {
         if(horaAtual.min >= minutoInicioAbertura) {
            return true;
         } else {
            return false;
         }
      }
      if(horaAtual.hour == horaFimAbertura) {
         if(horaAtual.min <= minutoFimAbertura) {
            return true;
         } else {
            return false;
         }
      }
      return true;
   }
   return false;
}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void TraillingStop(double preco)
{
   for(int i = PositionsTotal() - 1; i >= 0; i--) {
      string symbol  = PositionGetString(POSITION_SYMBOL);
      ulong magic    = PositionGetInteger(POSITION_MAGIC);
      if(symbol == _Symbol && magic == magicNumber) {
         ulong PositionTicket       = PositionGetTicket(POSITION_TICKET);
         double StopLossCorrente    = PositionGetDouble(POSITION_SL);
         double TakeProfitCorrente  = PositionGetDouble(POSITION_TP);
         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY) {
            if(preco >= (StopLossCorrente + gatilhoTS)) {
               double novoSL = NormalizeDouble(StopLossCorrente + stepTS, _Digits);
               if(trade.PositionModify(PositionTicket, novoSL, TakeProfitCorrente)) {
                  Print("TraillingStop - sem falha. ResultRetcode: ", trade.ResultRetcode(), ", ResultRetcodeDescription: ", trade.ResultRetcodeDescription() );
               } else {
                  Print("TraillingStop - com falha. ResultRetcode: ", trade.ResultRetcode(), ", ResultRetcodeDescription: ", trade.ResultRetcodeDescription() );
               }
            }
         } else if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL) {
            if(preco <= (StopLossCorrente - gatilhoTS)) {
               double novoSL = NormalizeDouble(StopLossCorrente - stepTS, _Digits);
               if(trade.PositionModify(PositionTicket, novoSL, TakeProfitCorrente)) {
                  Print("TraillingStop - sem falha. ResultRetcode: ", trade.ResultRetcode(), ", ResultRetcodeDescription: ", trade.ResultRetcodeDescription() );
               } else {
                  Print("TraillingStop - com falha. ResultRetcode: ", trade.ResultRetcode(), ", ResultRetcodeDescription: ", trade.ResultRetcodeDescription() );
               }
            }
         }
      }
   }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void BreakEven(double preco)
{
   for(int i = PositionsTotal() - 1 ; i >= 0 ; i--) {
      string symbol  = PositionGetSymbol(i);
      ulong magic    = PositionGetInteger(POSITION_MAGIC);
      if(symbol == _Symbol && magic == magicNumber) {
         ulong PositionTicket       = PositionGetInteger(POSITION_TICKET);
         double PrecoEntrada        = PositionGetDouble(POSITION_PRICE_OPEN);
         double TakeProfitCorrente  = PositionGetDouble(POSITION_TP);
         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY) {
            if(preco >= (PrecoEntrada + gatilhoBE)) {
               if(trade.PositionModify(PositionTicket, PrecoEntrada, TakeProfitCorrente)) {
                  Print("BreakEven - sem falha. ResultRetcode: ", trade.ResultRetcode(), ", ResultRetcodeDescription: ", trade.ResultRetcodeDescription() );
                  beAtivo = true;
               } else {
                  Print("BreakEven - com falha. ResultRetcode: ", trade.ResultRetcode(), ", ResultRetcodeDescription: ", trade.ResultRetcodeDescription() );
               }
            }
         } else if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL) {
            if(preco <= (PrecoEntrada - gatilhoBE)) {
               if(trade.PositionModify(PositionTicket, PrecoEntrada, TakeProfitCorrente)) {
                  Print("BreakEven - sem falha. ResultRetcode: ", trade.ResultRetcode(), ", ResultRetcodeDescription: ", trade.ResultRetcodeDescription() );
                  beAtivo = true;
               } else {
                  Print("BreakEven - com falha. ResultRetcode: ", trade.ResultRetcode(), ", ResultRetcodeDescription: ", trade.ResultRetcodeDescription() );
               }
            }
         }
      }
   }
}
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool checkCompra()
{
   CopyBuffer(cv_handle, 3, 1, 5, compraArray);
   sinalCompra = false;
   if(compraArray[0] > 0) {
      sinalCompra    = true;
   }
   return false;
}

bool checkVenda()
{
   CopyBuffer(cv_handle, 3, 1, 5, vendaArray);
   sinalVenda  = false;
   if(vendaArray[0] > 0) {
      sinalVenda     = true;
   }
   return false;
}
//+------------------------------------------------------------------+
