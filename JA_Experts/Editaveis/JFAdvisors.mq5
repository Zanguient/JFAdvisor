//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2018, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
//---
//+------------------------------------------------------------------+
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//+------------------------------------------------------------------+
//---

#include "INCLUDES\\CV-HLine.mqh"

enum OPERACOES {
   DayTrade,
   SwingTrade,
   BuyInHold
};
//---
input group "|||||||||| MERCADO ||| (B3) ||||||||||"
input group ">>>>> Horarios |"
//---
input string inicio = "9:15";       // - Horario Inicio
input string termino = "17:30";     // - Horario Termeno
input string fechamento = "17:45";  // - Horario Fechamento
//---
input group ">>>>> Custos |"
input double emolumentos = 0.20;  // - Emolumento (R$)
input double corretagem = 0.05;   // - Corretagem (R$)
input double taxa_registro = 0.17;// - Taxa de Resgistro BMF ()
input double iss = 0.2;          // - Imposto Sobre Servico (ISS) (%)
input double irrf = 0.2;         // - Imposto de Renda (%)
//---
input group " "
input group "||||||||||| EMPRESA ||| (JFAdivisor) |||||||||||"
input group ">>>>> Informacoes Gerais |"
input double   capital_giro = 100.0;   // - Capital de Giro (R$)
input double   caixa_operacao = 25.0;  // - Valor Alocado (Caixa de Operacao) (R$)
input double   meta_diaria = 100.0;    // - Meta Diaria (R$)
input OPERACOES operacoes ;            // - Modo de Negociacao
//---
input group ">>>>> Planejamento | Day Trade |"
input double   stop_financeiro_Day = 25.0;   // - Stop Financeiro (R$)
input int      lote_Day = 2;                 // - Lote Minimo
input int      lote_max_Day = 10;            // - Lote Maximo
//---
input group ">>>>> Planejamento | Swing Trade |"
input double   stop_financeiro_Swing = 25.0; // - Stop Financeiro (R$)
input int      lote_Swing = 1;               // - Lote Minimo
input int      lote_max_Swing = 10;          // - Lote Maximo
//---
input group ">>>>> Planejamento | Buy in Hold |"
input double   stop_financeiro_Buy = 25.0;   // - Stop Financeiro (R$)
input int      lote_Buy = 1;                 // - Lote Minimo
input int      lote_max_Buy = 10;            // - Lote Maximo
//---
input group " "
input group "||||||||||| CONTADOR ||| (ANA) ||||||||||"
input int      balancete = 10;
input double   bruto = 100;
//---
input group " "
input group "||||||||||| NEGOCIADOR ||| (JOAO) ||||||||||"
//---
input group " "
input group "||||||||||| ANALISTA ||| (MARIA) ||||||||||"
//---
input group " "
input group "||||||||||| APONTADOR ||| (JOSE) ||||||||||"
input int Passo = 15;
//---
bool autorizado = true;
bool negociando = false;
//---
bool first  = true;
bool reload = false;
//--- Versao 0.1
#include "Class\\MERCADO.mqh"    // Pronto ate segunda Ordem
#include "Class\\EMPRESA.mqh"    // Pronto ate segunda Ordem
#include "Class\\NEGOCIADOR.mqh" // Pronto ate segunda Ordem
#include "Class\\APONTADOR.mqh"  // Pronto ate segunda Ordem
#include "Class\\ANALISTA.mqh"   // Desenvolvimento Continuo <
#include "Class\\CONTADOR.mqh"   // Em Espera

//---
_MERCADO       B3;
_EMPRESA       JFAdivisor;
_NEGOCIADOR    Joao;
_ANALISTA      Maria;
_APONTADOR     Jose;
_CONTADOR      Ana;
//---
//+------------------------------------------------------------------+
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//+------------------------------------------------------------------+
int OnInit()
{
//---
   double calc_corretagem  = 0;
   double calc_iss         = 0;
   double calc_emolumentos = 0;
   double calc_registro    = 0;
//---
   Jose.passo = Passo;
//---
   B3.negociacao_Inicio       = inicio;
   B3.negociacao_Fim          = termino;
   B3.negociacao_Fechamento   = fechamento;
   B3.VerificaHorarios();
   B3.nome                    = "B3";
   B3.ativo                   = "WING20";
//---
   Joao.Load();
   Maria.Load();
   Ana.Load(lote_Day, emolumentos, taxa_registro, corretagem, iss, irrf);
//---
   if(  B3.horaInicio.hour > B3.horaTermino.hour || (B3.horaInicio.hour == B3.horaTermino.hour &&  B3.horaInicio.min > B3.horaTermino.min )) {
      Alert("Inconsistencia de horario de Negociacao!");
      return(INIT_FAILED);
   }
   if(  B3.horaTermino.hour > B3.horaFechamento.hour || (B3.horaTermino.hour == B3.horaFechamento.hour &&  B3.horaTermino.min > B3.horaFechamento.min) ) {
      Alert("Inconsistencia de horario de Negociacao!");
      return(INIT_FAILED);
   }
   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   Comment(" ");
   Jose.DellTradeLines();
}
//+------------------------------------------------------------------+
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//+------------------------------------------------------------------+
void OnTick()
{
//---
// executa se nenhuma informacao foi carregada
//---
   if(first) {
      //---
      // Carrega os precos de base para proto renko
      // em tempo de execucao
      //---
      Jose.LoadTradeLines();
      first = false;
   } else {
      Jose.MonitoraColisoes();
      Comment(
         "\n>----[   JOSE.APONTADOR   ]---->",
         "\n"
      );
      //---
      // Corpo principal de programa
      // Atualizacoes
      //---
   }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SalaDeNegocioacao()
{
   if(Jose.ativoCompra && Jose.colideUp) {
   // Joao vai as Compras
   } else if(Jose.ativoVenda && Jose.colideDown) {
   // Joao vai as Vendas
   }
}
//+------------------------------------------------------------------+
