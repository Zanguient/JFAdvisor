//+------------------------------------------------------------------+
//|                                                     CONTADOR.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
{
//---
// Declaracao de variaveis
   datetime inicio, fim;
   double lucro = 0, perda = 0;
   int trades = 0;
   double resultados;
   ulong ticket;

// Obtencao do Historico
   MqlDateTime inicio_struct;
   inicio_struct.hour = 0;
   inicio_struct.min  = 0;
   inicio_struct.sec  = 0;

   fim      = TimeCurrent(inicio_struct);
   inicio = StructToTime(inicio_struct);


   HistorySelect(inicio, fim);

   for(int i = 0; i < HistoryDealsTotal(); i++) {

      if( (ticket = HistoryDealGetTicket(i)) > 0) {
         if(HistoryDealGetString(ticket, DEAL_SYMBOL) == _Symbol) {
            trades++;
            resultados = HistoryDealGetDouble(ticket, DEAL_PROFIT);
            if(resultados < 0) {
               perda += -resultados;
            } else if(resultados > 0) {
               lucro += resultados;
            }
         }
      }
   }
   double fator_lucro;
   if(perda > 0) {
      fator_lucro = lucro / perda;
   } else {
      fator_lucro = -1;
   }

   double resultado_liquido = lucro - perda;



// Exibicao
   Comment(
      "Trades: ", trades,
      "\nLucro: ", lucro,
      "\nPerdas: ", perda,
      "\nResultado: ", resultado_liquido,
      "\nFL: ", fator_lucro
   );

}
//+------------------------------------------------------------------+
