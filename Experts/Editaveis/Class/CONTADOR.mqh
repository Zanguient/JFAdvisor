//+------------------------------------------------------------------+
//|                                                    _CONTADOR.mqh |
//|                                           Miqueias da S. Miranda |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      ""
#property version   "1.00"
class _CONTADOR
{
private:
   int               ct_lote;
   double            ct_emolumentos;
   double            ct_registro;
   double            ct_corretagem;
   double            ct_iss;
   double            ct_irrf;
   
   int               ct_qtdNegociacoes;
   int               ct_proximoBalancete;
public:
   double            ct_custos;
   //---
   bool              autorizacaoContadora;
   //--- avaliacao
   int               loss;
   int               gain;
   int               miss;
   //--- avaliacao
   double            taxaLoss;
   double            taxaMiss;
   double            taxaGain;
   //--- avaliacao
   double            pesoLoss;
   double            pesoMiss;
   double            pessoGain;
   //--- Retornos ao usuario
   bool              executandoBalancete;
   //--- Funcoes
   void              Load( int      _lote,
                           double   _emolumentos,
                           double   _registro,
                           double   _corretagem,
                           double   _iss,
                           double   _irrf
                         );
   
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void _CONTADOR::Load(int    _lote,
                     double _emolumentos,
                     double _registro,
                     double   _corretagem,
                     double _iss,
                     double _irrf
                    )
{
   ct_lote        = _lote;
   ct_emolumentos = _emolumentos;
   ct_registro    = _registro;
   ct_corretagem  = _corretagem;
   ct_iss         = _iss;
   ct_irrf        = _irrf;
   //---
   double calc_emolumento  = (_lote * 2) * _emolumentos;
   double calc_registro    = (_lote * 2) * _registro;
   double calc_corretagem  = (_lote * 2) * _corretagem;
   double calc_iss         = _corretagem * _iss;
   ct_custos = calc_corretagem + calc_emolumento + calc_iss + calc_registro;
}
//+------------------------------------------------------------------+
