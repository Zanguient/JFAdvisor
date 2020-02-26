//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2018, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#include "INCLUDES\\CV-HLine.mqh"
#include "Class\\JFNegociador.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class TradeLines
{
private:
   CvHLine           line;
public:
   string            name;
   bool              isVisible;
   int               id;
   int               isRomp;
   double            price;

   //---> Funcoes Graficas <---
   void              Load();
   void              Del();
};

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void TradeLines::Load()
{
   name = "trade-" + IntegerToString(id) + "-";
   line.Load(name, price, clrGray);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void TradeLines::Del()
{
   ObjectDelete(0, name + "line");
}


input int      qtd_lines   = 4;
input double   preco_nivel = 113100;
input int      passo       = 50;

TradeLines tl[];

JFNegociador Joao;

int   anterior = qtd_lines;
bool  first    = true;

int handle1;
int handle2;
int handle3;
int handle4;
int handle5;

double maArray1[];
double maArray2[];

double angArray1[];
double angArray2[];



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
{
   Joao.MagicNumber = 1234;


   handle1 = iCustom(_Symbol, PERIOD_M1, "estudo\\CV-MA-COMPOSTA3", 0,   11, 12, 13, PRICE_CLOSE, MODE_SMA);
   handle2 = iCustom(_Symbol, PERIOD_M1, "estudo\\CV-MA-COMPOSTA3", 0,   3, 4, 5, PRICE_CLOSE, MODE_SMA);
   handle3 = iCustom(_Symbol, PERIOD_M1, "estudo\\CV-MA-COMPOSTA3", 0,   5, 6, 7, PRICE_CLOSE, MODE_SMA);
   handle4 = iCustom(_Symbol, PERIOD_M1, "estudo\\CV-MA-COMPOSTA3", 0,   7, 8, 9, PRICE_CLOSE, MODE_SMA);
   handle5 = iCustom(_Symbol, PERIOD_M1, "estudo\\CV-MA-COMPOSTA3", 0,   9, 10, 11, PRICE_CLOSE, MODE_SMA);
   
   ArraySetAsSeries(maArray1, true);
   ArraySetAsSeries(maArray2, true);

   ArraySetAsSeries(angArray1, true);
   ArraySetAsSeries(angArray2, true);

   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   Comment(" ");
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
{

// Sinais
   CopyBuffer(handle1, 0, 0, 1, maArray1);
   CopyBuffer(handle2, 0, 0, 1, maArray2);

// Precos
   CopyBuffer(handle1, 1, 0, 2, angArray1);
   CopyBuffer(handle2, 1, 0, 2, angArray2);

   MqlRates rt[];
   ArraySetAsSeries(rt, true);
   CopyRates(_Symbol, PERIOD_M1, 0, 2, rt);

//---
   double anguloMa1 = (MathArctan((angArray1[0] - angArray1[1]) / 50)) * (180 / M_PI);
   double anguloMa2 = (MathArctan((angArray2[0] - angArray2[1]) / 50)) * (180 / M_PI);

   double anguloCaCC = (MathArctan((rt[0].close - rt[1].close) / 50)) * (180 / M_PI);
   double anguloCaOC = (MathArctan((rt[0].close - rt[0].open) / 50)) * (180 / M_PI);

   Comment(
      "\n+--------------------------+",
      "\nAngulo Media1: ", DoubleToString(anguloMa1, 1),
      //"\nAngulo Media2: ", DoubleToString(anguloMa2, 1),
      "\nAngulo Candle CC: ", DoubleToString(anguloCaCC, 1),
      "\nAngulo Candle OC: ", DoubleToString(anguloCaOC, 1),
      "\nSinal Longa: ", maArray1[0],
      //"\nSinal Curta: ", maArray2[0],
      "\n+--------------------------+",
      "\n"
      "\n+--------------------------+"
   );
// Joao fechando as posicoes
   if(Joao.Posicionamento() != 0) {
      Joao.FreeSell = false;
      if(Joao.Posicionamento() == -1) {
         if( maArray1[0] == 1) {            
            // Ativar  saida com tradeLine
            Joao.Fechamento();
         }
      }
   }
   
   //if(anguloMa2 < -5) {
   //   Joao.FreeSell = true;
   //} else {
   //   Joao.FreeSell = false;
   //}
   
// Joao Fazendo as negociacoes
   if(Joao.Posicionamento() == 0 && !Joao.OrdensPendentes()) {
      if( maArray1[0] == -1 && maArray2[0] == -1) {
         //Joao.Venda();
      }
   }
//---


}
//+------------------------------------------------------------------+
