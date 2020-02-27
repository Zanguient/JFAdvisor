//+------------------------------------------------------------------+
//|                                                     ANALISTA.mqh |
//|                                           Miqueias da S. Miranda |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      ""
#property version   "1.00"

//double array1[];
//double array2[];
//double array3[];


//CopyBuffer(handle1, 0, 0, 2, array1);

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//ArraySetAsSeries(array1, true);
//ArraySetAsSeries(array2, true);

//+------------------------------------------------------------------+
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//+------------------------------------------------------------------+
class _ANALISTA
{


private:
   int               handle1;
   int               handle2;
   int               handle3;
   int               handle4;
   int               handle5;


   int               handle11;
   int               handle12;
   int               handle13;
   int               handle14;
   int               handle15;

   int               handle21;
   int               handle22;
   int               handle23;
   int               handle24;
   int               handle25;

   int               handle26;

   double            array1[];
   double            array2[];
   double            array3[];
   double            array4[];
   double            array5[];

   double            array11[];
   double            array12[];
   double            array13[];
   double            array14[];
   double            array15[];

   double            array21[];
   double            array22[];
   double            array23[];
   double            array24[];
   double            array25[];

   double            array26[];
public:
   //---
   bool              indicaCompra;
   bool              indicaVenda;
   bool              acionaAlarme;
   void              Load();
   void              Observatorio();
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void _ANALISTA::Load()
{
   handle1   = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 1, PRICE_MEDIAN, MODE_SMA);
   handle2   = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 2, PRICE_MEDIAN, MODE_SMA);
   handle3   = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 3, PRICE_MEDIAN, MODE_SMA);
   
   
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void _ANALISTA::Observatorio(void)
{
//---
   CopyBuffer(handle1, 0, 0, 1, array1);
   CopyBuffer(handle2, 0, 0, 1, array2);
   CopyBuffer(handle3, 0, 0, 1, array3);
   CopyBuffer(handle4, 0, 0, 1, array4);
   CopyBuffer(handle5, 0, 0, 1, array5);
//---
   bool tendenciaVenda  = false;
   bool tendenciaCompra = false;
//---
   if(array11[0] == -1  && array12[0] == -1 && array13[0] == -1 && array14[0] == -1 && array15[0] == -1 ) {
      // tendencia de venda
      tendenciaVenda = true;
   } else if (array11[0] == 1  && array12[0] == 1 && array13[0] == 1 && array14[0] == 1 && array15[0] == 1 ) {
      // tendencia de compra
      tendenciaCompra = true;
   }
//---
   if(tendenciaCompra) {
      if(( array1[0] == 1) && ( array2[0] == 1) && ( array3[0] == 1)) {
         indicaCompra   = true;
         indicaVenda    = false;
         acionaAlarme   = false;
      } else {
         indicaCompra   = false;
         indicaVenda    = false;
         acionaAlarme   = true;
      }
   } else if(tendenciaVenda) {
      if(( array1[0] == -1) && ( array2[0] == -1) && ( array3[0] == -1)) {
         indicaCompra   = false;
         indicaVenda    = true;
         acionaAlarme   = false;
      } else {
         indicaCompra   = false;
         indicaVenda    = false;
         acionaAlarme   = true;
      }
   } else {
      indicaCompra   = false;
      indicaVenda    = false;
      acionaAlarme   = true;
   }
//---
}

//+------------------------------------------------------------------+
