//+------------------------------------------------------------------+
//|                                                  CV-ABERTURA.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                                DEUS SEJA LOUVADO |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 21
#property indicator_plots   6
//--- plot Media

#property indicator_label1  "Compra"
#property indicator_type1   DRAW_COLOR_ARROW
#property indicator_color1  clrRoyalBlue, clrNONE
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1

#property indicator_label2  "Venda"
#property indicator_type2   DRAW_COLOR_ARROW
#property indicator_color2  clrHotPink, clrNONE
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1

#property indicator_label3  "Media1"
#property indicator_type3   DRAW_COLOR_LINE
#property indicator_color3  clrRoyalBlue,clrHotPink
#property indicator_style3  STYLE_SOLID
#property indicator_width3  1

#property indicator_label4  "Media2"
#property indicator_type4   DRAW_COLOR_LINE
#property indicator_color4  clrRoyalBlue,clrHotPink
#property indicator_style4  STYLE_SOLID
#property indicator_width4  1

#property indicator_label5  "Media3"
#property indicator_type5   DRAW_COLOR_LINE
#property indicator_color5  clrRoyalBlue,clrHotPink
#property indicator_style5  STYLE_SOLID
#property indicator_width5  1

#property indicator_label6  "MediaMedia"
#property indicator_type6   DRAW_LINE
#property indicator_color6  clrRed
#property indicator_style6  STYLE_SOLID
#property indicator_width6  1
//--- input parameters
//--- indicator buffers
double         CompraBuffer[];
double         CompraColor[];
double         VendaBuffer[];
double         VendaColor[];
double         MediaBuffer1[];
double         MediaColors1[];
double         MediaBuffer2[];
double         MediaColors2[];
double         MediaBuffer3[];
double         MediaColors3[];

double         MMBuffer[];

//--- Arrays de medias

double media_periodoLongo[];
double media_periodoMedio[];
double media_periodoRapido[];

double media_media[];

//---
input int periodoLongo  =  15;//Longo
input int periodoMedio  =  10; //Medio
input int periodoRapido =  5;//Rapido

double media = 0;

double         V_L[],
               V_M[],
               V_R[];

double         C_L[],
               C_M[],
               C_R[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping

   SetIndexBuffer(0,CompraBuffer,INDICATOR_DATA);
   SetIndexBuffer(1,CompraColor,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(2,VendaBuffer,INDICATOR_DATA);
   SetIndexBuffer(3,VendaColor,INDICATOR_COLOR_INDEX);

   SetIndexBuffer(4,MediaBuffer1,INDICATOR_DATA);
   SetIndexBuffer(5,MediaColors1,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(6,MediaBuffer2,INDICATOR_DATA);
   SetIndexBuffer(7,MediaColors2,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(8,MediaBuffer3,INDICATOR_DATA);
   SetIndexBuffer(9,MediaColors3,INDICATOR_COLOR_INDEX);

   SetIndexBuffer(10,MMBuffer,INDICATOR_DATA);  
   SetIndexBuffer(11,V_L,INDICATOR_DATA);
   SetIndexBuffer(12,V_M,INDICATOR_DATA);
   SetIndexBuffer(13,V_R,INDICATOR_DATA);
   SetIndexBuffer(14,C_L,INDICATOR_DATA);
   SetIndexBuffer(15,C_M,INDICATOR_DATA);
   SetIndexBuffer(16,C_R,INDICATOR_DATA);
   SetIndexBuffer(17,media_periodoLongo,INDICATOR_DATA);
   SetIndexBuffer(18,media_periodoMedio,INDICATOR_DATA);
   SetIndexBuffer(19,media_periodoRapido,INDICATOR_DATA);
   SetIndexBuffer(20,media_media,INDICATOR_DATA);
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
//--- Periodo Longo
   for(int i=periodoLongo-1; i<rates_total; i++) {
      media = 0;
      for(int j=0; j<periodoLongo; j++) {
         media = media + close[i-j]/periodoLongo;
      }
      MediaBuffer1[i] = media;
      media_periodoLongo[i] = media;
      int angulo = (MathArctan(MediaBuffer1[i]-MediaBuffer1[i-1]))*(180/3.14);
      if(angulo >= 0) {
         MediaColors1[i] = 0;
         C_L[i] = 1;
         V_L[i] = 0;
      } else if(angulo < 0) {
         MediaColors1[i] = 1;
         C_L[i] = 0;
         V_L[i] = 1;
      }
   }
//---
//--- Periodo Medio
   for(int i=periodoMedio-1; i<rates_total; i++) {
      media = 0;
      for(int j=0; j<periodoMedio; j++) {
         media = media + close[i-j]/periodoMedio;
      }
      MediaBuffer2[i] = media;
      media_periodoMedio[i] = media;
      int angulo = (MathArctan(MediaBuffer2[i]-MediaBuffer2[i-1]))*(180/3.14);
      if(angulo >= 0) {
         MediaColors2[i] = 0;
         C_M[i] = 1;
         V_M[i] = 0;
      } else if(angulo < 0) {
         MediaColors2[i] = 1;
         C_M[i] = 0;
         V_M[i] = 1;
      }
   }
//---
//--- Periodo Rapido
   for(int i=periodoRapido-1; i<rates_total; i++) {
      media = 0;
      for(int j=0; j<periodoRapido; j++) {
         media = media + close[i-j]/periodoRapido;
      }
      MediaBuffer3[i] = media;
      media_periodoRapido[i] = media;
      int angulo = (MathArctan(MediaBuffer3[i]-MediaBuffer3[i-1]))*(180/3.14);
      if(angulo >= 0) {
         MediaColors3[i] = 0;
         C_R[i] = 1;
         V_R[i] = 0;
      } else if(angulo < 0) {
         MediaColors3[i] = 1;
         C_R[i] = 0;
         V_R[i] = 1;
      }
   }
//--- Media das Medias
   for(int i=periodoLongo; i<rates_total; i++) {
      media = 0;
   
         media += (media_periodoLongo[i] + media_periodoMedio[i] + media_periodoRapido[i])/3;
    
      MMBuffer[i] = media;
      media_media[i] = media;
   }
//---
   for(int i=periodoLongo; i<rates_total; i++) {
      if(C_L[i] == 1 && C_M[i] == 1 && C_R[i] == 1) {
         CompraBuffer[i] = MediaBuffer1[i];
         CompraColor[i] = 0 ;
         VendaBuffer[i] = 0;
      } else if(V_L[i] == 1 && V_M[i] == 1 && V_R[i] == 1) {
         VendaBuffer[i] = MediaBuffer1[i];
         VendaColor[i] = 0;
         CompraBuffer[i] = 0;
      } else {
         CompraBuffer[i] = 0;
         VendaBuffer[i] = 0;
         CompraColor[i] = 1;
         VendaColor[i] = 1;
      }
   }
//---
//--- Validacao de Compra/Venda
//--- return value of prev_calculated for next call
   return(rates_total);
}

//+------------------------------------------------------------------+
