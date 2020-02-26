
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#include <Politicas.mqh>
#include <Trade\Trade.mqh>
CTrade                        trade;



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//input string                  _3 = ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>";



MqlTick                       ultimoTick;//Estrutura de precos
MqlRates                      rates[];//precos anteiores


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
   { 
      smaHandle = iMA(_Symbol, _Period, ma_periodo, ma_desloc, ma_metodo, ma_preco);   
      if(smaHandle==INVALID_HANDLE)
        {
         Print("Erro ao criar media movel - erro", GetLastError());
         return(INIT_FAILED);
        }
        
        
        
      ArraySetAsSeries(smaArray, true);
      ArraySetAsSeries(rates, true);
  
      trade.SetTypeFilling(preenchimneto);
      trade.SetDeviationInPoints(desvPts);
      trade.SetExpertMagicNumber(magicNum);
   
      return(INIT_SUCCEEDED);
   }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {

      
      if(!SymbolInfoTick(_Symbol, ultimoTick))
        {
            Alert("Erro ao obter informacoes de precos: ", GetLastError());
            return;
        }
        
      if(CopyRates(_Symbol, _Period, 0, 3, rates)<0)
         {
            Alert("Erro ao obter as informacoes de MqlRates: ", GetLastError());
            return;
         }
        
      if(CopyBuffer(smaHandle, 0,0,3, smaArray)<0)
         {
            Alert("Erro ao copiar dados da media movel: ", GetLastError());
            return;
         }  

      
//---

      posAberta = Posicao();


//---
      ordPendente = false;
      for(int i=OrdersTotal()-1; i>=0; i--)
        {
            ulong ticket = OrderGetTicket(i);
            string symbol = OrderGetString(ORDER_SYMBOL);
            ulong magic = OrderGetInteger(ORDER_MAGIC);
            if(symbol == _Symbol && magic==magicNum)
              {
                  ordPendente = true;
                  break;
              }
            
        }
        
        
        
      if(!posAberta)
        {
            beAtivo = false;
        }
        
      if(posAberta && !beAtivo)
        {
            BreakEven(ultimoTick.last);
        }
        
      if(posAberta && beAtivo)
        {
            TraillingStop(ultimoTick.last);
        }
      
      if(ultimoTick.last>smaArray[0]  && rates[1].close>rates[1].open && rates[2].close>rates[2].open && !posAberta && !ordPendente)
        {
         Comment("Compra");
         
         PRC = NormalizeDouble(ultimoTick.ask, _Digits);
         STL = NormalizeDouble(PRC - stopLoss, _Digits);
         TKP = NormalizeDouble(PRC + takeProfit, _Digits);
         
         if(trade.Buy(lote, _Symbol, PRC, STL, TKP, ""))
            {
               Print(">>>> Ordem de compra - sem falha. ResultRetcode: ", trade.ResultRetcode(), "RetcodeDescription: ", trade.ResultRetcodeDescription());
            } 
          else
            {
               Print(">>>> Ordem de compra - com falha. ResultRetcode: ", trade.ResultRetcode(), "RetcodeDescription: ", trade.ResultRetcodeDescription());
            }
         
        }
      else if (ultimoTick.last<smaArray[0] && rates[1].close<rates[1].open && rates[2].close<rates[2].open && !posAberta && !ordPendente)
      {
         Comment("Venda");
         
         PRC = NormalizeDouble(ultimoTick.bid, _Digits);
         STL = NormalizeDouble(PRC + stopLoss, _Digits);
         TKP = NormalizeDouble(PRC - takeProfit, _Digits);          
         
         if(trade.Sell(lote, _Symbol, PRC, STL, TKP, ""))
            {
               Print(">>>> Ordem de venda - sem falha. ResultRetcode: ", trade.ResultRetcode(), "RetcodeDescription: ", trade.ResultRetcodeDescription());
            }
          else
            {
               Print(">>>> Ordem de venda - com falha. ResultRetcode: ", trade.ResultRetcode(), "RetcodeDescription: ", trade.ResultRetcodeDescription());
            }
      }    
      
      Comment("Preco ASK = ", ultimoTick.ask,"\nPreco BID = ", ultimoTick.bid);
      
//+------------------------------------------------------------------+
//| Vetoramento                                                      |
//+------------------------------------------------------------------+
            
      
  }



  
//+------------------------------------------------------------------+
//|  Trailling Stop                                                  |
//+------------------------------------------------------------------+


//---
//---

