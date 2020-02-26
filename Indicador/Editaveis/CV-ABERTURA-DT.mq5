//+------------------------------------------------------------------+
//|                                                  CV-ABERTURA.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                                DEUS SEJA LOUVADO |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "2.0"
#property indicator_chart_window
#property indicator_buffers 35
#property indicator_plots   14


#property indicator_label1 "(0) Compra"
#property indicator_label2 "(1) Venda"


//--- plot Principal 1
#property indicator_label3  "(2) MM_Principal 1"
#property indicator_type3   DRAW_COLOR_LINE
#property indicator_color3  clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style3  STYLE_SOLID
#property indicator_width3  2

//--- plot Media 1
#property indicator_label4  "(4) MM_Rapida 1"
#property indicator_type4   DRAW_COLOR_LINE
#property indicator_color4  clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style4  STYLE_SOLID
#property indicator_width4  1

//--- plot Media 2
#property indicator_label5  "(6) MM_Rapida 2"
#property indicator_type5   DRAW_COLOR_LINE
#property indicator_color5  clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style5  STYLE_SOLID
#property indicator_width5  1

//--- plot Media 3
#property indicator_label6  "(8) MM_Rapida 3"
#property indicator_type6   DRAW_COLOR_LINE
#property indicator_color6  clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style6  STYLE_SOLID
#property indicator_width6  1

//--- plot Principal 2
#property indicator_label7  "(10) MM_Principal 2"
#property indicator_type7   DRAW_COLOR_LINE
#property indicator_color7  clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style7  STYLE_SOLID
#property indicator_width7  2

//--- plot Media 4
#property indicator_label8  "(12) MM_Rapida 4"
#property indicator_type8   DRAW_COLOR_LINE
#property indicator_color8  clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style8  STYLE_SOLID
#property indicator_width8  1

//--- plot Media 5
#property indicator_label9  "(14) MM_Rapida 5"
#property indicator_type9   DRAW_COLOR_LINE
#property indicator_color9  clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style9  STYLE_SOLID
#property indicator_width9  1

//--- plot Media 6
#property indicator_label10  "(16) MM_Rapida 6"
#property indicator_type10   DRAW_COLOR_LINE
#property indicator_color10  clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style10  STYLE_SOLID
#property indicator_width10  1

//--- plot Principal 3
#property indicator_label11  "(18) MM_Principal 3"
#property indicator_type11   DRAW_COLOR_LINE
#property indicator_color11  clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style11  STYLE_SOLID
#property indicator_width11  2

//--- plot Media 7
#property indicator_label12  "(20) MM_Rapida 7"
#property indicator_type12   DRAW_COLOR_LINE
#property indicator_color12  clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style12  STYLE_SOLID
#property indicator_width12  1

//--- plot Media 8
#property indicator_label13  "(22) MM_Rapida 8"
#property indicator_type13   DRAW_COLOR_LINE
#property indicator_color13  clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style13  STYLE_SOLID
#property indicator_width13  1

//--- plot Media 9
#property indicator_label14  "(24) MM_Rapida 9"
#property indicator_type14   DRAW_COLOR_LINE
#property indicator_color14  clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style14  STYLE_SOLID
#property indicator_width14  1

double         CCompra[];
double         VVenda[];

double         MM_Principal_1[];
double         MM_Principal_1_Color[];
double         MM_Parcial_1[];
double         MM_CALC1[];
double         MM_CALC1_Color[];
double         MM_CALC2[];
double         MM_CALC2_Color[];
double         MM_CALC3[];
double         MM_CALC3_Color[];

double         MM_Principal_2[];
double         MM_Principal_2_Color[];
double         MM_Parcial_2[];
double         MM_CALC4[];
double         MM_CALC4_Color[];
double         MM_CALC5[];
double         MM_CALC5_Color[];
double         MM_CALC6[];
double         MM_CALC6_Color[];

double         MM_Principal_3[];
double         MM_Principal_3_Color[];
double         MM_Parcial_3[];
double         MM_CALC7[];
double         MM_CALC7_Color[];
double         MM_CALC8[];
double         MM_CALC8_Color[];
double         MM_CALC9[];
double         MM_CALC9_Color[];


double         Compra_cor1[];
double         Compra_cor2[];
double         Compra_cor3[];

double         Venda_cor1[];
double         Venda_cor2[];
double         Venda_cor3[];

input string   med1 = "---------------------------------"; //PERIODOS BASE DE CALCULO MEDIA - PERIODO RAPIDO (1)

input int                  MM_periodo1       = 3;// Periodo Rapido
input int                  MM_periodo2       = 4;// Periodo Medio
input int                  MM_periodo3       = 5;// Periodo Longo



input bool                 MM_uso1           = true;//Uso para calculos?
input int                  MM_CALC1_periodo  = 3;//Periodo de Calculo Media Movel Maior
input bool                 setColor1         = false;//Mostrar Base?

input string   med2 = "---------------------------------"; //PERIODOS BASE DE CALCULO MEDIA RAPIDA (2)

input int                  MM_periodo4       = 4;// Periodo Rapido
input int                  MM_periodo5       = 5;// Periodo Medio
input int                  MM_periodo6       = 6;// Periodo Longo


input bool                 MM_uso2           = true;//Uso para calculos?
input int                  MM_CALC2_periodo  = 3;//Periodo de Calculo Media Movel Maior
input bool                 setColor2         = false;//Mostrar Base?

input string   med3 = "---------------------------------"; //PERIODOS BASE DE CALCULO MEDIA RAPIDA (3)

input int                  MM_periodo7       = 5;// Periodo Rapido
input int                  MM_periodo8       = 6;// Periodo Medio
input int                  MM_periodo9       = 7;// Periodo Longo


input bool                 MM_uso3           = true;//Uso para calculos?
input int                  MM_CALC3_periodo  = 3;//Periodo de Calculo Media Movel Maior
input bool                 setColor3         = false;//Mostrar Base?

input string   med4 = "---------------------------------"; //ANGULO DE ZONA DE REVERCAO

input int                  ang = 0;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//+------------------------------------------------------------------+
//|   Set Media 1                                                    |
//+------------------------------------------------------------------+
//--- indicator buffers mapping
   SetIndexBuffer(0, CCompra, INDICATOR_DATA);
   SetIndexBuffer(1, VVenda,  INDICATOR_DATA);
   SetIndexBuffer(2, MM_Principal_1, INDICATOR_DATA);
   SetIndexBuffer(3, MM_Principal_1_Color, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(4, MM_CALC1, INDICATOR_DATA);
   SetIndexBuffer(5, MM_CALC1_Color, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(6, MM_CALC2, INDICATOR_DATA);
   SetIndexBuffer(7, MM_CALC2_Color, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(8, MM_CALC3, INDICATOR_DATA);
   SetIndexBuffer(9, MM_CALC3_Color, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(10, MM_Principal_2, INDICATOR_DATA);
   SetIndexBuffer(11, MM_Principal_2_Color, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(12, MM_CALC4, INDICATOR_DATA);
   SetIndexBuffer(13, MM_CALC4_Color, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(14, MM_CALC5, INDICATOR_DATA);
   SetIndexBuffer(15, MM_CALC5_Color, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(16, MM_CALC6, INDICATOR_DATA);
   SetIndexBuffer(17, MM_CALC6_Color, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(18, MM_Principal_3, INDICATOR_DATA);
   SetIndexBuffer(19, MM_Principal_3_Color, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(20, MM_CALC7, INDICATOR_DATA);
   SetIndexBuffer(21, MM_CALC7_Color, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(22, MM_CALC8, INDICATOR_DATA);
   SetIndexBuffer(23, MM_CALC8_Color, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(24, MM_CALC9, INDICATOR_DATA);
   SetIndexBuffer(25, MM_CALC9_Color, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(26, MM_Parcial_1, INDICATOR_DATA);
   SetIndexBuffer(27, MM_Parcial_2, INDICATOR_DATA);
   SetIndexBuffer(28, MM_Parcial_3, INDICATOR_DATA);
   SetIndexBuffer(29, Compra_cor1, INDICATOR_DATA);
   SetIndexBuffer(30, Compra_cor2, INDICATOR_DATA);
   SetIndexBuffer(31, Compra_cor3, INDICATOR_DATA);
   SetIndexBuffer(32, Venda_cor1, INDICATOR_DATA);
   SetIndexBuffer(33, Venda_cor2, INDICATOR_DATA);
   SetIndexBuffer(34, Venda_cor3, INDICATOR_DATA);
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
//--- MEDIAS 1
   if(MM_uso1 == true) {
 
//---
//+------------------------------------------------------------------+
//|  MEDIAS 1                                                        |
//+------------------------------------------------------------------+
      for(int i = MM_periodo1; i < rates_total; i++) {
         
         double media = 0;
         for(int j = 0; j < MM_periodo1; j++) {
            media = media + close[i - j] / MM_periodo1;
         }
         
         MM_CALC1[i]  = media;
         MM_CALC1_Color[i] = setColor1 ? 0 : 3;
      }
      
      for(int i = MM_periodo2 - 1; i < rates_total; i++) {
         double media = 0;
         for(int j = 0; j < MM_periodo2; j++) {
            media = media + close[i - j] / MM_periodo2;
         }
         MM_CALC2[i]  = media;
         MM_CALC2_Color[i] = setColor1 ? 0 : 3;
      }
      
      for(int i = MM_periodo3 - 1; i < rates_total; i++) {
         double media = 0;
         for(int j = 0; j < MM_periodo3; j++) {
            media = media + close[i - j] / MM_periodo3;
         }
         MM_CALC3[i]  = media;
         MM_CALC3_Color[i] = setColor1 ? 0 : 3;
      }
//--- Calculo de parciais 1
      for(int i = MM_periodo3; i < rates_total; i++) {
         MM_Parcial_1[i] = (MM_CALC1[i] + MM_CALC2[i] + MM_CALC3[i]) / 3;
      }
//--- Media Movel da Final 1
      for(int i = MM_CALC1_periodo - 1; i < rates_total; i++) {
         double mediaMov = 0;
         for(int j = 0; j < MM_CALC1_periodo; j++) {
            mediaMov = mediaMov + MM_Parcial_1[i - j] / MM_CALC1_periodo;
         }
         MM_Principal_1[i] = mediaMov;
//+------------------------------------------------------------------+
//|  Calcular Angulos                                                |
//+------------------------------------------------------------------+
         double angulo = (MathArctan(MM_Principal_1[i] - MM_Principal_1[i - 1] )) * (180 / 3.1415);
         if(angulo < -ang) {
            MM_Principal_1_Color[i] = 1;
            Compra_cor1[i] = 0;
            Venda_cor1[i]  = 1;
         } else if(angulo >= ang) {
            MM_Principal_1_Color[i] = 0;
            Compra_cor1[i] = 1;
            Venda_cor1[i]  = 0;
         }
//---
      }
   } else {
      for(int i = 0; i < rates_total; i++) {
         MM_CALC1[i]       = 0;
         MM_CALC2[i]       = 0;
         MM_CALC3[i]       = 0;
         MM_Parcial_1[i]   = 0;
         MM_Principal_1[i] = 0;
      }
   }
//--- MEDIAS 2
   if(MM_uso2 == true) {
//+------------------------------------------------------------------+
//|  MEDIAS 2                                                        |
//+------------------------------------------------------------------+
      for(int i = MM_periodo4 - 1; i < rates_total; i++) {
         double media = 0;
         for(int j = 0; j < MM_periodo4; j++) {
            media = media + close[i - j] / MM_periodo4;
         }
         MM_CALC4[i]  = media;
         MM_CALC4_Color[i] = setColor2 == true ? 0 : 3;
      }
      for(int i = MM_periodo5 - 1; i < rates_total; i++) {
         double media = 0;
         for(int j = 0; j < MM_periodo5; j++) {
            media = media + close[i - j] / MM_periodo5;
         }
         MM_CALC5[i]  = media;
         MM_CALC5_Color[i] = setColor2 == true ? 0 : 3;
      }
      for(int i = MM_periodo6 - 1; i < rates_total; i++) {
         double media = 0;
         for(int j = 0; j < MM_periodo6; j++) {
            media = media + close[i - j] / MM_periodo6;
         }
         MM_CALC6[i]  = media;
         MM_CALC6_Color[i] = setColor2 == true ? 0 : 3;
      }
//--- Calculo de parciais 2
      for(int i = MM_periodo6; i < rates_total; i++) {
         MM_Parcial_2[i] = (MM_CALC4[i] + MM_CALC5[i] + MM_CALC6[i]) / 3;
      }
//--- Media Movel da Final 2
      for(int i = MM_CALC2_periodo - 1; i < rates_total; i++) {
         double mediaMov = 0;
         for(int j = 0; j < MM_CALC2_periodo; j++) {
            mediaMov = mediaMov + MM_Parcial_2[i - j] / MM_CALC2_periodo;
         }
         MM_Principal_2[i] = mediaMov;
         MM_Principal_2_Color[i] = 1;
//+------------------------------------------------------------------+
//|  Calcular Angulos                                                |
//+------------------------------------------------------------------+
         double angulo = (MathArctan(MM_Principal_2[i] - MM_Principal_2[i - 1] )) * (180 / 3.1415);
         if(angulo < -ang) {
            MM_Principal_2_Color[i] = 1;
            Compra_cor2[i] = 0;
            Venda_cor2[i]  = 1;
         } else if(angulo >= ang) {
            MM_Principal_2_Color[i] = 0;
            Compra_cor2[i] = 1;
            Venda_cor2[i]  = 0;
         }
//---
      }
   } else {
      for(int i = 0; i < rates_total; i++) {
         MM_CALC4[i]       = 0;
         MM_CALC5[i]       = 0;
         MM_CALC6[i]       = 0;
         MM_Parcial_2[i]   = 0;
         MM_Principal_2[i] = 0;
      }
   }
//--- MEDIAS 3
   if(MM_uso3 == true) {
//+------------------------------------------------------------------+
//|  MEDIAS 3                                                        |
//+------------------------------------------------------------------+
      for(int i = MM_periodo7 - 1; i < rates_total; i++) {
         double media = 0;
         for(int j = 0; j < MM_periodo7; j++) {
            media = media + close[i - j] / MM_periodo7;
         }
         MM_CALC7[i]  = media;
         MM_CALC7_Color[i] = setColor3 == true ? 0 : 3;
      }
      for(int i = MM_periodo8 - 1; i < rates_total; i++) {
         double media = 0;
         for(int j = 0; j < MM_periodo8; j++) {
            media = media + close[i - j] / MM_periodo8;
         }
         MM_CALC8[i]  = media;
         MM_CALC8_Color[i] = setColor3 == true ? 0 : 3;
      }
      for(int i = MM_periodo9 - 1; i < rates_total; i++) {
         double media = 0;
         for(int j = 0; j < MM_periodo9; j++) {
            media = media + close[i - j] / MM_periodo9;
         }
         MM_CALC9[i]  = media;
         MM_CALC9_Color[i] = setColor3 == true ? 0 : 3;
      }
//--- Calculo de parciais 3
      for(int i = MM_periodo9; i < rates_total; i++) {
         MM_Parcial_3[i] = (MM_CALC7[i] + MM_CALC8[i] + MM_CALC9[i]) / 3;
      }
//--- Media Movel da Final 3
      for(int i = MM_CALC3_periodo - 1; i < rates_total; i++) {
         double mediaMov = 0;
         for(int j = 0; j < MM_CALC3_periodo; j++) {
            mediaMov = mediaMov + MM_Parcial_3[i - j] / MM_CALC3_periodo;
         }
         MM_Principal_3[i] = mediaMov;
         
//+------------------------------------------------------------------+
//|  Calcular Angulos                                                |
//+------------------------------------------------------------------+
         double angulo = (MathArctan(MM_Principal_3[i] - MM_Principal_3[i - 1] )) * (180 / 3.1415);
         if(angulo < -ang) {
            MM_Principal_3_Color[i] = 1;
            Compra_cor3[i] = 0;
            Venda_cor3[i]  = 1;
         } else if(angulo >= ang) {
            MM_Principal_3_Color[i] = 0;
            Compra_cor3[i] = 1;
            Venda_cor3[i]  = 0;
         }
//---
      }
   } else {
      for(int i = 0; i < rates_total; i++) {
         MM_CALC7[i]       = 0;
         MM_CALC8[i]       = 0;
         MM_CALC9[i]       = 0;
         MM_Parcial_3[i]   = 0;
         MM_Principal_3[i] = 0;
      }
   }
   
//+------------------------------------------------------------------+
//|  Avaliar Compra e venda  Com 3 habilitados                                                              |
//+------------------------------------------------------------------+
      
   for(int i = 0 ; i < rates_total; i++) {
      CCompra[i] = 0;
      VVenda[i]   = 0;
      if(Compra_cor1[i] == 1 && Compra_cor2[i] == 1  && Compra_cor3[i] == 1) {
         CCompra[i]  = 1;
         VVenda[i]   = 0;
      } else if(Venda_cor1[i] == 1 && Venda_cor2[i] == 1 && Venda_cor3[i] == 1) {
         CCompra[i]  = 0;
         VVenda[i]   = 1;
      }else{
         CCompra[i]  = 0;
         VVenda[i]   = 0;
         
         MM_Principal_1_Color[i] = 2;
         MM_Principal_2_Color[i] = 2;
         MM_Principal_3_Color[i] = 2;
         
      }
   }
   return(rates_total);
}


//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double modulo(double num)
{
   double mod = num < 0 ? num * -1 : num;
   return mod;
}
//+------------------------------------------------------------------+
