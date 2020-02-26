//+------------------------------------------------------------------+
//|                                                    Neuronios.mqh |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
class Neuronios
{
public:
   double            array[][9];
   double            entradas[2];
   double            oculta1[3];
   void              AdicaoVetor(double& A[], double& B[], int tam);
   void              MultiplicaMatriz(double& A[][9], int m, int n, double& B[][9], int o, int p);
};
//+------------------------------------------------------------------+
void Neuronios::AdicaoVetor(double &A[], double &B[] , int tam)
{
   for(int i = 0; i < tam; i++) {
      oculta1[i] = A[i] + B[i];
   }
}

void Neuronios::MultiplicaMatriz(double &A[][9],int m,int n,double &B[][9],int o,int p)
{
}
//+------------------------------------------------------------------+
