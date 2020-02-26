//+------------------------------------------------------------------+
//|                                                        C1-PO.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             GITHUB AQUI          |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "" // Colocar meu GitHub
#property version   "3.00"



#include                      <ESTUDO\parametros.mqh>
#include                      <ESTUDO\Negociacao.mqh>
#include                      <ESTUDO\Matematica.mqh>
#include                      <ESTUDO\Horarios.mqh>
//+------------------------------------------------------------------+
//| INICIO DECLARACAO DE VARIAVEIS                                   |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| FIM DECLARACAO DE VARIAVEIS                                      |
//+------------------------------------------------------------------+
int OnInit()
{
//---
   if(!MarketBookAdd(_Symbol))
      return INIT_FAILED;
//---
   trade.SetTypeFilling(ORDER_FILLING_RETURN);  // Tipo de venda
   trade.SetDeviationInPoints(desvPts);         // Desvio Aceitavel
   trade.SetExpertMagicNumber(magicNumber);     // ID do Robo
   ArraySetAsSeries(rates, true); // Inicializa vetor rates
//--- Verifica Horario de Operacao
   HoraInicio();
//--- Inicializacao dos indiadores
   int line_size  = 15;
   int delta_x    = 10;
   int delta_y    = 10;
   int x_size     = 200;
   int y_size     = line_size * ArraySize(infos) + 10;
   if(!ObjectCreate      (0, "Background", OBJ_RECTANGLE_LABEL, 0, 0, 0))
      return INIT_FAILED;
   ObjectSetInteger  (0, "Background", OBJPROP_CORNER,      CORNER_LEFT_LOWER);
   ObjectSetInteger  (0, "Background", OBJPROP_XDISTANCE,   delta_x);
   ObjectSetInteger  (0, "Background", OBJPROP_YDISTANCE,   delta_y + y_size);
   ObjectSetInteger  (0, "Background", OBJPROP_XSIZE,       x_size);
   ObjectSetInteger  (0, "Background", OBJPROP_YSIZE,       y_size);
   ObjectSetInteger  (0, "Background", OBJPROP_BGCOLOR,     clrYellow);
   ObjectSetInteger  (0, "Background", OBJPROP_BORDER_TYPE, BORDER_FLAT);
   ObjectSetInteger  (0, "Background", OBJPROP_BORDER_COLOR, clrBlack );
   for(int i = 0; i < ArraySize(infos); i++) {
      if(!ObjectCreate(0, infos[i], OBJ_LABEL,0, 0, 0)) {
         return INIT_FAILED;
      }
      ObjectSetInteger(0, infos[i], OBJPROP_ANCHOR, ANCHOR_LEFT_UPPER);
      ObjectSetInteger(0, infos[i], OBJPROP_CORNER, CORNER_LEFT_LOWER);
      ObjectSetInteger(0, infos[i], OBJPROP_XDISTANCE, delta_x + 5);
      ObjectSetInteger(0, infos[i], OBJPROP_YDISTANCE, delta_y - 5 + y_size - i * line_size);
      
      ObjectSetInteger(0, infos[i], OBJPROP_COLOR, clrBlack);
      ObjectSetInteger(0, infos[i], OBJPROP_FONTSIZE, 10);
      ObjectSetString(0, infos[i], OBJPROP_TEXT, infos[i]);
      
   }
   for(int i = 0; i < ArraySize(infos); i++) {
      string name = infos[i] + "Valor";
      if(!ObjectCreate(0, name, OBJ_LABEL,0, 0, 0)) {
         return INIT_FAILED;
      }
      ObjectSetInteger(0, name, OBJPROP_ANCHOR, ANCHOR_RIGHT_UPPER);
      ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_LOWER);
      ObjectSetInteger(0, name, OBJPROP_XDISTANCE, delta_x + x_size - 5);
      ObjectSetInteger(0, name, OBJPROP_YDISTANCE, delta_y - 5 + y_size - i * line_size);
      
      ObjectSetInteger(0, name, OBJPROP_COLOR, clrBlack);
      ObjectSetInteger(0, name, OBJPROP_FONTSIZE, 10);
      ObjectSetString(0, name, OBJPROP_TEXT, "-");
      
   }
   
   ObjectCreate(0, "TKP", OBJ_TEXT,0, TimeCurrent(), 116030);
   ObjectSetString(0, "TKP", OBJPROP_TEXT, "12345");
   ObjectSetInteger(0, "TKP", OBJPROP_BGCOLOR, clrRed);   
     
   ChartRedraw();
   return INIT_SUCCEEDED;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   ObjectDelete(0, "Background");
   for(int i=0;i<ArraySize(infos);i++)
     {
         ObjectDelete(0,infos[i]);
     }
   for(int i=0;i<ArraySize(infos);i++)
     {
         ObjectDelete(0,infos[i]+"Valor");
     }
   
}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
{

string posicao = "Nenhuma";
ObjectSetString(0, infos[0]+"Valor", OBJPROP_TEXT, _Symbol);
ObjectSetString(0, infos[1]+"Valor", OBJPROP_TEXT, DoubleToString(ultimoTick.last,0));
ObjectSetString(0, infos[2]+"Valor", OBJPROP_TEXT, posicao);
//--- Reinicio de variaveis de teste
   comprado       = false;
   vendido        = false;
   sinalCompra    = false;
   sinalVenda     = false;
   ordPendente    = false;
   candle_tend    = true;
//--- Opcoes de tempo
   if(HoraFechamento()) {
      Comment("Horario de fechamento de posicoes!");
   } else if(HoraNegociacao()) {
      Menssagem("Dentro do horario de Negociacao!");
   } else {
      Menssagem("Fora do horario de Negociacao!");
      DeletaOrdens();
   }
//---  Carrega informacao de negociacoes
   SymbolInfoTick(_Symbol, ultimoTick);      // Deve ser declarado dentro do OnTick
   CopyRates(_Symbol, _Period, 0, 3, rates); // para poder ser feita a Atualizacao do tick
   if(isNewBar()) {
//---  Carregar Buffers
      BuffersNewBar();
//---  Valida o Sinal de Compra e Venda
      if( XXX == 1) {
         sinalCompra = true;
      } else if( XXX == 1) {
         sinalVenda = true;
      }
//--- Verificacao se existe posicao aberta
      for(int i = PositionsTotal() ; i >= 0; i--) {
         //
         string symbol  = PositionGetSymbol(i);
         ulong  magic   = PositionGetInteger(POSITION_MAGIC);
         //
         if(symbol == _Symbol && magic == magicNumber) {
            posAberta = true;
            break;
         } else {
            posAberta = false;
         }
      }
//--- Se existir posicao aberta, verifica se e comprado/vendido
      if(PositionSelect(_Symbol)) {
         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY) comprado = true;
         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL) vendido = true;
      }
//--- Verificacao de Ordens
      for(int i = OrdersTotal() - 1 ; i >= 0; i--) {
         ulong ticket   = OrderGetTicket(i);
         ulong magic    = OrderGetInteger(ORDER_MAGIC);
         string symbol  = OrderGetString(ORDER_SYMBOL);
         if(symbol == _Symbol && magic == magicNumber) {
            ordPendente = true;
            break;
         }
      }
//--- Verificar Tendencias
//--- Ativacao do BreakEvem
      if(posAberta == false) {
         beAtivo = false;
      }
      if(posAberta == true && beAtivo == false) {
         BreakEven(ultimoTick.last);
      }
//--- Ativacao do TraillingStop
      if(posAberta == true && beAtivo == true) {
         TraillingStop(ultimoTick.last);
      }
//--- Executa Politicas de Negociacao
      if(SinalTouro && !MetaPiso) {
         Touro();
      } else if(SinalUrso && !MetaPiso) {
         //Urso();
      }
   }// fim isNewBar
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnBookEvent(const string &symbol)
{
   MqlBookInfo book[];
   if(!MarketBookGet(_Symbol, book))
      return;
   for(int i = 0; i < ArraySize(book); i++) {
      if(book[i].type == BOOK_TYPE_SELL) {
         precoCompra    = book[i].price;
         volumeCompra   = book[i].volume;
      } else {
         precoVenda     = book[i].price;
         volumeVenda    = book[i].volume;
         break;
      }
   }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void BuffersNewBar()
{
   carteira = AccountInfoDouble(ACCOUNT_EQUITY);
   MetaPiso = carteira > meta_price ? true : false;
   double open  = rates[0].open;
   double close = rates[0].close;
}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void BuffersNewTick()
{
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Martingale()
{
}
//+------------------------------------------------------------------+
