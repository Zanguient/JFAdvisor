
//--- importe biblioteca trade
#include <Trade\Trade.mqh>

//--- crie instancia de chamada de trade



void OnTick()
  {
   // receber o preco ask
   double ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK), _Digits);
   // receber o preco bid
   double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   // testar se ja existe posicao aberta
   
   if( ask >= sensor_sup)
   {
         Comment("Subindo");
         sensor_sup = SYMBOL_LAST+20;
   }else
   if(bid <= sensor_inf)
     {
         Comment("Descendo");
         sensor_inf = SYMBOL_LAST-20;
     }

  }

