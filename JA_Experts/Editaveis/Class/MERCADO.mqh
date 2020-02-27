//+------------------------------------------------------------------+
//|                                                      MERCADO.mqh |
//|                                           Miqueias da S. Miranda |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      ""
#property version   "1.00"

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class _MERCADO
{
public:
   string            nome;
   string            ativo;
   double            volume_negociado_dia;
   //---
   bool              livre;
   bool              finalizando;
   bool              fechando;
   //---
   string            negociacao_Inicio;
   string            negociacao_Fim;
   string            negociacao_Fechamento;
   //---
   MqlDateTime          horaInicio;
   MqlDateTime          horaTermino;
   MqlDateTime          horaFechamento;
   MqlDateTime          horaAtual;
   //---
   void              Load();
   void              VerificaHorarios(); // deve ser chamada em OnInit()
   bool              HoraNegociacao();
   bool              HoraFechamento();
   //---

};

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  _MERCADO::Load()
{
//---
    
//---
}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void _MERCADO::VerificaHorarios(void)
{
   TimeToStruct(StringToTime(negociacao_Inicio),   horaInicio);
   TimeToStruct(StringToTime(negociacao_Fim),      horaTermino);
   TimeToStruct(StringToTime(negociacao_Fechamento), horaFechamento);
//---
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool _MERCADO::HoraNegociacao(void)
{
   TimeToStruct(TimeCurrent(), horaAtual);
   if(horaAtual.hour >= horaInicio.hour && horaAtual.hour <= horaTermino.hour) {
      if(horaAtual.hour == horaInicio.hour) {
         if(horaAtual.min >= horaInicio.min) {
            return true;
         } else {
            return false;
         }
      }
      if(horaAtual.hour == horaTermino.hour) {
         if( horaAtual.min <= horaTermino.min) {
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
bool _MERCADO::HoraFechamento(void)
{
   TimeToStruct(TimeCurrent(), horaAtual);
   if(horaAtual.hour >= horaFechamento.hour) {
      if(horaAtual.min >= horaFechamento.min) {
         return true;
      } else {
         return false;
      }
      return true;
   }
   return false;
}
//+------------------------------------------------------------------+
