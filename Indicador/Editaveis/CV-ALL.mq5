//+------------------------------------------------------------------+
//|                                                       CV-ALL.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window

#property indicator_buffers   13
#property indicator_plots     2

#property indicator_label1 "Sinal"

#property indicator_label2 "Plot"
#property indicator_type2  DRAW_COLOR_HISTOGRAM
#property indicator_color2 clrRed, clrBlue, clrNONE
#property indicator_style2 STYLE_SOLID
#property indicator_width2 1
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+

int A;
int B;
int C;
int D;
int E;
int F;
int G;
int H;
int I;
int J;


double Sinal[];

double Plot[];
double PlotColor[];

string NameA;
string NameB;
string NameC;
string NameD;
string NameF;
string NameG;
string NameH;
string NameI;
string NameJ;

double ArrayA[];
double ArrayB[];
double ArrayC[];
double ArrayD[];
double ArrayF[];
double ArrayG[];
double ArrayH[];
double ArrayI[];
double ArrayJ[];

double Compra[];
double media   = 0;

input bool visible = true;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping

   SetIndexBuffer(0, Sinal, INDICATOR_DATA);
   SetIndexBuffer(1, Plot, INDICATOR_DATA);
   SetIndexBuffer(2, PlotColor, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(3, ArrayA, INDICATOR_DATA);
   SetIndexBuffer(4, ArrayB, INDICATOR_DATA);
   SetIndexBuffer(5, ArrayC, INDICATOR_DATA);
   SetIndexBuffer(6, ArrayD, INDICATOR_DATA);
   SetIndexBuffer(7, ArrayF, INDICATOR_DATA);
   SetIndexBuffer(8, ArrayG, INDICATOR_DATA);
   SetIndexBuffer(9, ArrayH, INDICATOR_DATA);
   SetIndexBuffer(10, ArrayI, INDICATOR_DATA);
   SetIndexBuffer(11, ArrayJ, INDICATOR_DATA);
   SetIndexBuffer(12, Compra, INDICATOR_DATA);

   A = iCustom(_Symbol, _Period, "estudo\\Rubro-Negro\\RB-HT-A");
   B = iCustom(_Symbol, _Period, "estudo\\Rubro-Negro\\RB-HT-B");
   C = iCustom(_Symbol, _Period, "estudo\\Rubro-Negro\\RB-HT-C");
   D = iCustom(_Symbol, _Period, "estudo\\Rubro-Negro\\RB-HT-D");
   F = iCustom(_Symbol, _Period, "estudo\\Rubro-Negro\\RB-HT-F");
   G = iCustom(_Symbol, _Period, "estudo\\Rubro-Negro\\RB-HT-G");
   H = iCustom(_Symbol, _Period, "estudo\\Rubro-Negro\\RB-HT-H");
   I = iCustom(_Symbol, _Period, "estudo\\Rubro-Negro\\RB-HT-I");
   J = iCustom(_Symbol, _Period, "estudo\\Rubro-Negro\\RB-HT-J");

//---
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
//---

   int inicio;
   int qtdCopy;
   if(prev_calculated == 0) {
      inicio = 10;
      qtdCopy = rates_total;
   } else {
      inicio = prev_calculated - 1;
      qtdCopy = 1;
   }

   CopyBuffer(A, 0, 1, qtdCopy, ArrayA);
   CopyBuffer(B, 0, 1, qtdCopy, ArrayB);
   CopyBuffer(C, 0, 1, qtdCopy, ArrayC);
   CopyBuffer(D, 0, 1, qtdCopy, ArrayD);
   CopyBuffer(F, 0, 1, qtdCopy, ArrayF);
   CopyBuffer(G, 0, 1, qtdCopy, ArrayG);
   CopyBuffer(H, 0, 1, qtdCopy, ArrayH);
   CopyBuffer(I, 0, 1, qtdCopy, ArrayI);
   CopyBuffer(J, 0, 1, qtdCopy, ArrayJ);

   for(int i = inicio; i < rates_total; i++) {

      Compra[i] = 0;
      Compra[i] += ArrayA[i];
      Compra[i] += ArrayB[i];
      
      
      Compra[i] += ArrayF[i];
      Compra[i] += ArrayG[i];
      Compra[i] += ArrayH[i];
      Compra[i] += ArrayI[i];
      Compra[i] += ArrayJ[i];

      media = (Compra[i] + Compra[i - 1] + Compra[i - 2]  ) / 3;

      Sinal[i] = 0;
      
      Plot[i]  = media;
      
      if(Plot[i] <= 0) {
         PlotColor[i] = 0;
         Sinal[i] = -1;
      } else if(Plot[i] > 0) {
         PlotColor[i] = 1;
         Sinal[i] = 1;
      }
   }
//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
