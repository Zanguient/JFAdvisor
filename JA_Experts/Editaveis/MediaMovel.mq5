//+------------------------------------------------------------------+
//|                                                   MediaMovel.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      ""
#property version   "1.00"
//+------------------------------------------------------------------+
//| Buffers                                                                 |
//+------------------------------------------------------------------+
#property indicator_buffers 1
#property indicator_plots   1

#property indicator_label1  "MEDIA"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrBlueViolet
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1

//+------------------------------------------------------------------+
//| INCLUDES                                                         |
//+------------------------------------------------------------------+
#include <Trade/Trade.mqh> // biblioteca padrao de CTrade
//+------------------------------------------------------------------+
//| INPUTS                                                           |
//+------------------------------------------------------------------+
input int lote = 1;
input int PeriodoLongo = 45;
input int PeriodoCurto = 10; 
//+------------------------------------------------------------------+
//| GLOBAIS                                                          |
//+------------------------------------------------------------------+
//--- manipuladores dos indicadores de media movel
int curtaHandle = INVALID_HANDLE;
int longaHandle = INVALID_HANDLE;
//--- vetores de dados de media movel 
double mediaLonga[];
double mediaCurta[];

double MEDIA[];
//--- declaracao de variaveis de trade
CTrade trade;




int OnInit()
  {
//---
   
//---
   SetIndexBuffer(0,MEDIA,INDICATOR_DATA);
   ArraySetAsSeries(mediaCurta,true);
   ArraySetAsSeries(mediaLonga,true);
//--- atribuir
   curtaHandle = iMA(_Symbol,_Period,PeriodoCurto,0,MODE_SMA,PRICE_CLOSE);
   longaHandle = iMA(_Symbol,_Period,PeriodoLongo,0,MODE_SMA,PRICE_CLOSE);
   
//---

   return(INIT_SUCCEEDED);
  } 
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
 
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---


   
   if(isNewBar())
     {
     
      //--- executa logica operacional do robo
      //+------------------------------------------------------------------+
      //| Obtencao de Dados                                                |
      //+------------------------------------------------------------------+
      int copyed1 = CopyBuffer(curtaHandle,0,0,3,mediaCurta);
      int copyed2 = CopyBuffer(longaHandle,0,0,3,mediaLonga);
      
      bool sinalCompra = false;
      bool sinalVenda = false;
      
      
      if(copyed1 == 3 && copyed2 == 3)
        {
         MEDIA[0] = mediaCurta[0];
         //--- Sinal de compra
         if(mediaCurta[1]>mediaLonga[1] && mediaCurta[2]<mediaLonga[2])
           {
            sinalCompra = true;
           }
         //--- Sinal de venda
         if(mediaCurta[1]<mediaLonga[1] && mediaCurta[2]>mediaLonga[2])
           {
            sinalVenda = true;
           }
        }
        
      //+------------------------------------------------------------------+
      //| verficar se estou posicionado                                    |
      //+------------------------------------------------------------------+
      bool comprado = false;
      bool vendido = false;
      
      
      
      if(PositionSelect(_Symbol))
        {
            if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY)
              {
                  comprado = true;
              }
            if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_SELL)
              {
                  vendido = true;
              }
        }
      
      //+------------------------------------------------------------------+
      //| Roteamento                                                       |
      //+------------------------------------------------------------------+
      // zerado
      if(comprado==false && vendido==false)
        {
         if(sinalCompra)
           {
               trade.Buy(lote,_Symbol,0,0,0,"Compra a mercado");
           }
         if(sinalVenda)
           {
               trade.Sell(lote,_Symbol,0,0,0,"Venda a mercado");
           }
        }else
      if(comprado)
        {
            if(sinalVenda)
              {
                  trade.Sell(lote*2,_Symbol,0,0,0,"Virada de Mao (Compra > Venda)");
              }
         
        }else
      if(vendido)
        {
            if(sinalCompra)
              {
                  trade.Buy(lote*2,_Symbol,0,0,0,"Virada de Mao (Venda > Compra)");
              }
         
        }
     }
   
  }
//+------------------------------------------------------------------+

bool isNewBar()
{
   static datetime last_time = 0;
   
   datetime lastbar_time = (datetime)SeriesInfoInteger(Symbol(),Period(),SERIES_LASTBAR_DATE);
   
   if(last_time==0)
   {
      last_time=lastbar_time;
      return false;
   }
   if(last_time!=lastbar_time)
     {
      last_time=lastbar_time;
      return true;
     }
     return false;
}