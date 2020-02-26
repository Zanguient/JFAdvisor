//+------------------------------------------------------------------+
//|                                               CV-Negociacoes.mqh |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"

#include  <Trade\\Trade.mqh>
class CVTrade
{
public:
   double            Lote;
   long              MagicNumber;
   bool              Free;
   int               TypeOp;
   double            PcCompra;      // ask               - melhor oferta de Compra
   double            PcVenda;       // bid               - melhor oferta de Venda
   double            PcSL;          // Stop Loss         - limite de perdas
   double            PcSLInicial;   // Stop Loss Inicial - limite de perdas inicial
   double            PcTP;          // Take Profit       - realizacao dos ganhos
   void              Compra();
   void              Venda();
   void              Consolida();
   void              Vira();
   int               Posicao();
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CVTrade::Compra()
{
   CTrade Trade;
   double bid     = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   PcCompra    = NormalizeDouble(bid,   _Digits);
   Trade.Buy(Lote, _Symbol, PcCompra, 0, 0, NULL);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CVTrade::Venda()
{
   CTrade Trade;
   double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   PcVenda      = NormalizeDouble(ask,  _Digits);
   Trade.Sell(Lote, _Symbol, PcVenda, 0, 0, NULL);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CVTrade::Consolida()
{
   CTrade Trade;
   for(int i = PositionsTotal(); i >= 0; i--) {
      if(PositionGetSymbol(i) == _Symbol) {
         Trade.PositionClose(PositionGetTicket(i));
      }
   }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  CVTrade::Vira()
{
   int pos = Posicao();
   if(pos == 1) {
      Consolida();
      Venda();
   } else if(pos == -1) {
      Consolida();
      Compra();
   }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CVTrade::Posicao()
{
   int position = 0;
   for(int i = PositionsTotal() - 1; i >= 0; i--) {
      string symbol  = PositionGetSymbol(i);
      ulong magic    = PositionGetInteger(POSITION_MAGIC);
      if(symbol == _Symbol && magic == MagicNumber) {
         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)  return 1;
         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL) return -1;
      }
   }
   return position;
}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CVCouter
{
public:
   bool              vazio;
   int               qtd;
   int               id;
   double            price;
};

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//Trade.SetTypeFilling(preenchimento);  // Tipo de venda
//Trade.SetDeviationInPoints(desvPto);         // Desvio Aceitavel
//Trade.SetExpertMagicNumber(magicNumber);     // ID do Robo
//---
//---
//---
//---
//+------------------------------------------------------------------+
//| CARREGA OS DADOS DE HORARIOS                                     |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//TimeToStruct(StringToTime(Negociacao_Inicio),      horaInicio);
//TimeToStruct(StringToTime(Negociacao_Fim),         horaTermino);
//TimeToStruct(StringToTime(Negociacao_Fechamento),  horaFechamento);
//---
//---
//---
//---
//---
//+------------------------------------------------------------------+
//|  Verifica Horario de Operacao                                    |
//+------------------------------------------------------------------+
//if(  horaInicio.hour > horaTermino.hour || (horaInicio.hour == horaTermino.hour &&  horaInicio.min > horaTermino.min ))
//{
//   Alert("Inconsistencia de horario de Negociacao!");
//   return(INIT_FAILED);
//}
//if(  horaTermino.hour > horaFechamento.hour || (horaTermino.hour == horaFechamento.hour &&  horaTermino.min > horaFechamento.min) )
//{
//   Alert("Inconsistencia de horario de Negociacao!");
//   return(INIT_FAILED);
//}
//---
//---
//---
//---
//+------------------------------------------------------------------+
//| ANALISTA - RECEBE SINAL DE ABERTURA DO INDICADOR                            |
//+------------------------------------------------------------------+
//double SinalAbertura(int SinalHandle)
//{
//   double SinalArray[];
//   ArraySetAsSeries(SinalArray, true);
//   CopyBuffer(SinalHandle, 0, 0, 1, SinalArray);
//   return SinalArray[0];
//}
//+------------------------------------------------------------------+
//| ANALISTA - RECEBE SINAL DE FECHAMENTO DO INDICADOR                          |
//+------------------------------------------------------------------+
//double SinalFechamento(int SinalHandle)
//{
//   double SinalArray[];
//   ArraySetAsSeries(SinalArray, true);
//   CopyBuffer(SinalHandle, 0, 0, 1, SinalArray);
//   return SinalArray[0];
//}
//+------------------------------------------------------------------+
//|  Implementacao do Stop Movel                                     |
//+------------------------------------------------------------------+
//void TraillingStop(double preco)
//{
//   for(int i = PositionsTotal() - 1; i >= 0; i--) {
//      string   symbol   = PositionGetSymbol(i);
//      ulong    magic    = PositionGetInteger(POSITION_MAGIC);
//      if(symbol == _Symbol && magic == magicNumber) {
//         ulong PositionTicket       = PositionGetInteger(POSITION_TICKET);
//         double StopLossCorrente    = PositionGetDouble(POSITION_SL);
//         double PrecoEntrada        = PositionGetDouble(POSITION_PRICE_OPEN);
//         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY) {
//            if(preco >= (StopLossCorrente + gatilhoTS)) {
//               double novoSL = NormalizeDouble((rates[1].low - stepTS), _Digits);
//               if(Trade.PositionModify(PositionTicket, novoSL, 0)) {
//                  Print(   "TraillingStop - COMPRA - sem falha. ResultRetcode: ",
//                           Trade.ResultRetcode(),
//                           ", ResultRetcodeDescription: ",
//                           Trade.ResultRetcodeDescription()
//                       );
//               } else {
//                  Print(   "TraillingStop - COMPRA - com falha. ResultRetcode: ",
//                           Trade.ResultRetcode(),
//                           ", ResultRetcodeDescription: ",
//                           Trade.ResultRetcodeDescription()
//                       );
//               }
//            }
//         } else if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL) {
//            if(preco <= (StopLossCorrente - gatilhoTS)) {
//               double novoSL = NormalizeDouble(StopLossCorrente - stepTS, _Digits);
//               if(Trade.PositionModify(PositionTicket, novoSL, 0)) {
//                  Print(   "TraillingStop - VENDA - sem falha. ResultRetcode: ",
//                           Trade.ResultRetcode(),
//                           ", ResultRetcodeDescription: ",
//                           Trade.ResultRetcodeDescription()
//                       );
//               } else {
//                  Print(   "TraillingStop - VENDA - com falha. ResultRetcode: ",
//                           Trade.ResultRetcode(),
//                           ", ResultRetcodeDescription: ",
//                           Trade.ResultRetcodeDescription()
//                       );
//               }
//            }
//         }
//      }
//   }
//}
//+------------------------------------------------------------------+
//|   Implementacao do Break Even                                    |
//+------------------------------------------------------------------+
//void BreakEven(double preco)
//{
//   for(int i = PositionsTotal() - 1 ; i >= 0 ; i--) {
//      string symbol  = PositionGetSymbol(i);
//      ulong magic    = PositionGetInteger(POSITION_MAGIC);
//      if(symbol == _Symbol && magic == magicNumber) {
//         ulong PositionTicket       = PositionGetInteger(POSITION_TICKET);
//         double PrecoEntrada        = PositionGetDouble(POSITION_PRICE_OPEN);
//         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY) {
//            double BE = PrecoEntrada + gatilhoBE;
//            if(preco > BE) {
//               if(Trade.PositionModify(PositionTicket, PrecoEntrada, 0)) {
//                  Print("BreakEven - COMPRA - sem falha. ResultRetcode: ",
//                        Trade.ResultRetcode(),
//                        ", ResultRetcodeDescription: ",
//                        Trade.ResultRetcodeDescription()
//                       );
//                  beAtivo = true;
//               } else {
//                  Print("BreakEven - COMPRA - com falha. ResultRetcode: ",
//                        Trade.ResultRetcode(),
//                        ", ResultRetcodeDescription: ",
//                        Trade.ResultRetcodeDescription()
//                       );
//               }
//            }
//         } else if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL) {
//            if(preco <= (PrecoEntrada - gatilhoBE)) {
//               if(Trade.PositionModify(PositionTicket, PrecoEntrada, 0)) {
//                  Print("BreakEven - VENDA - sem falha. ResultRetcode: ",
//                        Trade.ResultRetcode(),
//                        ", ResultRetcodeDescription: ",
//                        Trade.ResultRetcodeDescription()
//                       );
//                  beAtivo = true;
//               } else {
//                  Print("BreakEven - VENDA - com falha. ResultRetcode: ",
//                        Trade.ResultRetcode(),
//                        ", ResultRetcodeDescription: ",
//                        Trade.ResultRetcodeDescription()
//                       );
//               }
//            }
//         }
//      }
//   }
//}
//+------------------------------------------------------------------+
//| Implementacao do fechamento de Ordens                            |
//+------------------------------------------------------------------+
//void DeletaOrdens()
//{
//   for(int i = OrdersTotal() - 1; i >= 0; i--) {
//      ulong ticket = OrderGetTicket(i);
//      string symbol = OrderGetString(ORDER_SYMBOL);
//      ulong magic = OrderGetInteger(ORDER_MAGIC);
//      if(symbol == _Symbol && magic == magicNumber) {
//         if(Trade.OrderDelete(ticket)) {
//            Print("Ordem Deletada - sem falha. ResultRetcode: ",
//                  Trade.ResultRetcode(),
//                  ", ResultRetcodeDescription: ",
//                  Trade.ResultRetcodeDescription()
//                 );
//         } else {
//            Print("Ordem Deletada - com falha. ResultRetcode: ",
//                  Trade.ResultRetcode(),
//                  ", ResultRetcodeDescription: ",
//                  Trade.ResultRetcodeDescription()
//                 );
//         }
//      }
//   }
//}
//+------------------------------------------------------------------+
//| Verificar Ordens Pendentes                                       |
//+------------------------------------------------------------------+
//bool Ordem()
//{
//   bool ordPendente = false;
//   for(int i = OrdersTotal() - 1; i >= 0; i--) {
//      ulong ticket   = OrderGetTicket(i);
//      string symbol  = OrderGetString(ORDER_SYMBOL);
//      ulong  magic   = OrderGetInteger(ORDER_MAGIC);
//      if(symbol == _Symbol && magic == magicNumber) {
//         ordPendente = true;
//         break;
//      }
//   }
//   return ordPendente;
//}
//+------------------------------------------------------------------+
//| Implementacao do fechamento das posicoes                         |
//+------------------------------------------------------------------+
//void FechaPosicao()
//{
//   for(int i = PositionsTotal() - 1; i >= 0 ; i--) {
//
//      string symbol  = PositionGetString(POSITION_SYMBOL);
//      ulong magic    = PositionGetInteger(POSITION_MAGIC);
//
//      if(symbol == _Symbol && magic == magicNumber) {
//         ulong PositionTicket = PositionGetInteger(POSITION_TICKET);
//         if(Trade.PositionClose(PositionTicket, desvPto)) {
//            Print("Posicao Fechada - sem falha. ResultRetcode: ",
//                  Trade.ResultRetcode(),
//                  ", ResultRetcodeDescription: ",
//                  Trade.ResultRetcodeDescription()
//                 );
//         } else {
//            Print("Posicao Fechada - com falha. ResultRetcode: ",
//                  Trade.ResultRetcode(),
//                  ",ResultRetcodeDescription: ",
//                  Trade.ResultRetcodeDescription()
//                 );
//         }
//      }
//   }
//}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
// _____ _   _ _   _  ____ ___  _____ ____                           |
//|  ___| | | | \ | |/ ___/ _ \| ____/ ___|                          |
//| |_  | | | |  \| | |  | | | |  _| \___ \                          |
//|  _| | |_| | |\  | |__| |_| | |___ ___) |                         |
//|_|    \___/|_| \_|\____\___/|_____|____/                          |
//                                                                   |
//  ____ ___  _   _ _____ ____   ___  _     _____                    |
// / ___/ _ \| \ | |_   _|  _ \ / _ \| |   | ____|                   |
//| |  | | | |  \| | | | | |_) | | | | |   |  _|                     |
//| |__| |_| | |\  | | | |  _ <| |_| | |___| |___                    |
// \____\___/|_| \_| |_| |_| \_\\___/|_____|_____|                   |
//                                                                   |
// ____  _____                                                       |
//|  _ \| ____|                                                      |
//| | | |  _|                                                        |
//| |_| | |___                                                       |
//|____/|_____|                                                      |
//                                                                   |
// _   _  ___  ____      _    ____  ___ ___  ____                    |
//| | | |/ _ \|  _ \    / \  |  _ \|_ _/ _ \/ ___|                   |
//| |_| | | | | |_) |  / _ \ | |_) || | | | \___ \                   |
//|  _  | |_| |  _ <  / ___ \|  _ < | | |_| |___) |                  |
//|_| |_|\___/|_| \_\/_/   \_\_| \_\___\___/|____/                   |
//                                                                   |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| HORAIOS DE ENTRADA                                               |
//+------------------------------------------------------------------+
//bool HoraNegociacao()
//{
//   TimeToStruct(TimeCurrent(), horaAtual);
//
//   if(horaAtual.hour >= horaInicio.hour && horaAtual.hour <= horaTermino.hour) {
//      if(horaAtual.hour == horaInicio.hour) {
//         if(horaAtual.min >= horaInicio.min) {
//            return true;
//         } else {
//            return false;
//         }
//      }
//      if(horaAtual.hour == horaTermino.hour) {
//         if( horaAtual.min <= horaTermino.min) {
//            return true;
//         } else {
//            return false;
//         }
//      }
//      return true;
//   }
//   return false;
//}
//+------------------------------------------------------------------+
//|  HORARIO DE FECHAMENTO DE TODAS AS POSICOES                      |
//+------------------------------------------------------------------+
//bool HoraFechamento()
//{
//   TimeToStruct(TimeCurrent(), horaAtual);
//   if(horaAtual.hour >= horaFechamento.hour) {
//      if(horaAtual.min >= horaFechamento.min) {
//         return true;
//      } else {
//         return false;
//      }
//      return true;
//   }
//   return false;
//}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//double sinalAbertura    = SinalAbertura(handleA);
//double sinalAbertura2   = SinalAbertura(handleB);
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//|     _ _ _   ____       _            _             _   _ _ _      |
//|    | | | | |  _ \ _ __(_)_ __   ___(_)_ __   __ _| | | | | |     |
//|    | | | | | |_) | '__| | '_ \ / __| | '_ \ / _` | | | | | |     |
//|    | | | | |  __/| |  | | | | | (__| | |_) | (_| | | | | | |     |
//|    | | | | |_|   |_|  |_|_| |_|\___|_| .__/ \__,_|_| | | | |     |
//|    |_|_|_|                           |_|             |_|_|_|     |
//|                                                                  |
//+------------------------------------------------------------------+
//|  Abre posicao se nao ouver nenhuma                               |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//if(sinalAbertura == 1 && Posicao() == 0)
//{
//   Compra();
//} else if(sinalAbertura == -1 &&  Posicao() == 0)
//{
//   Venda();
//} else if(Posicao() == -1 && sinalAbertura == 1  )
//{
//   FechaPosicao();
//} else if(Posicao() == 1 && sinalAbertura == -1  )
//{
//   FechaPosicao();
//}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//void OnChartEvent(const int id,
//                  const long & lparam,
//                  const double & dparam,
//                  const string & sparam)
//{
//   if(id == CHARTEVENT_OBJECT_CLICK) {
//      if(sparam == "Fecha") {
//         Print("Botao consolidar" );
//         for(int i = PositionsTotal(); i >= 0; i--) {
//            if(PositionGetSymbol(i) == _Symbol) {
//               Trade.PositionClose(PositionGetTicket(i));
//            }
//         }
//      } else if(sparam == "Compra") {
//         Compra();
//      } else if(sparam == "Venda") {
//         Venda();
//      } else if(sparam == "Vira") {
//         if(comprado) {
//            Trade.Sell(lote, _Symbol, ultimoTick.bid, 0, 0, "Venda Manual");
//         }
//         Print("Botao virar");
//      } else if(sparam == "Dobra") {
//         Print("Botao dobrar");
//      }
//   }
//}
//+------------------------------------------------------------------+
//| Candle a Candle                                                  |
//+------------------------------------------------------------------+
//bool isNewBar()
//{
//   static datetime last_time = 0;
//   datetime lastbar_time = (datetime) SeriesInfoInteger(_Symbol, _Period, SERIES_LASTBAR_DATE);
//   if(last_time == 0) {
//      last_time = lastbar_time;
//      return false;
//   }
//   if(last_time != lastbar_time) {
//      last_time = lastbar_time;
//      return true;
//   }
//   return false;
//}
//+------------------------------------------------------------------+
