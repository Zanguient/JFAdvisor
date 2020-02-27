//+------------------------------------------------------------------+
//|                                                  CV-ABERTURA.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                                DEUS SEJA LOUVADO |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "2.0"
#property indicator_chart_window
#property indicator_buffers 38
#property indicator_plots   19


#property indicator_label1 "(0) Compra"
#property indicator_label2 "(1) Venda"


//--- plot 1
#property indicator_label3  "(2) "
#property indicator_type3   DRAW_COLOR_LINE
#property indicator_color3  clrGray, clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style3  STYLE_SOLID
#property indicator_width3  1

//--- plot 2
#property indicator_label4  "(2) "
#property indicator_type4   DRAW_COLOR_LINE
#property indicator_color4  clrGray, clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style4  STYLE_SOLID
#property indicator_width4  1

//--- plot 3
#property indicator_label5  "(2) "
#property indicator_type5   DRAW_COLOR_LINE
#property indicator_color5  clrGray, clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style5  STYLE_SOLID
#property indicator_width5  1

//--- plot 4
#property indicator_label6  "(2) "
#property indicator_type6   DRAW_COLOR_LINE
#property indicator_color6  clrGray, clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style6  STYLE_SOLID
#property indicator_width6  1

//--- plot 5
#property indicator_label7  "(2) "
#property indicator_type7   DRAW_COLOR_LINE
#property indicator_color7  clrGray, clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style7  STYLE_SOLID
#property indicator_width7  1

//--- plot 6
#property indicator_label8  "(2) "
#property indicator_type8   DRAW_COLOR_LINE
#property indicator_color8  clrGray, clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style8  STYLE_SOLID
#property indicator_width8  1

//--- plot 7
#property indicator_label9  "(2) "
#property indicator_type9   DRAW_COLOR_LINE
#property indicator_color9  clrGray, clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style9  STYLE_SOLID
#property indicator_width9  1

//--- plot 8
#property indicator_label10  "(2) "
#property indicator_type10   DRAW_COLOR_LINE
#property indicator_color10  clrGray, clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style10  STYLE_SOLID
#property indicator_width10  1

//--- plot 1to2
#property indicator_label11  "(2) "
#property indicator_type11   DRAW_COLOR_LINE
#property indicator_color11  clrGray, clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style11  STYLE_SOLID
#property indicator_width11  1

//--- plot 2to3
#property indicator_label12  "(2) "
#property indicator_type12   DRAW_COLOR_LINE
#property indicator_color12  clrGray, clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style12  STYLE_SOLID
#property indicator_width12  1

//--- plot 3to4
#property indicator_label13  "(2) "
#property indicator_type13   DRAW_COLOR_LINE
#property indicator_color13  clrGray, clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style13  STYLE_SOLID
#property indicator_width13  1

//--- plot 5to6
#property indicator_label14  "(2) "
#property indicator_type14   DRAW_COLOR_LINE
#property indicator_color14  clrGray, clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style14  STYLE_SOLID
#property indicator_width14  1

//--- plot 6to7
#property indicator_label15  "(2) "
#property indicator_type15   DRAW_COLOR_LINE
#property indicator_color15  clrGray, clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style15  STYLE_SOLID
#property indicator_width15  1

//--- plot 7to8
#property indicator_label16  "(2) "
#property indicator_type16   DRAW_COLOR_LINE
#property indicator_color16  clrGray, clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style16  STYLE_SOLID
#property indicator_width16  1

//--- plot CENTRAL
#property indicator_label17  "(2) "
#property indicator_type17   DRAW_COLOR_LINE
#property indicator_color17  clrGray, clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style17  STYLE_SOLID
#property indicator_width17  3

//--- plot MOVEL1
#property indicator_label18  "(2) "
#property indicator_type18   DRAW_COLOR_LINE
#property indicator_color18  clrGray, clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style18  STYLE_SOLID
#property indicator_width18  2

//--- plot MOVEL2
#property indicator_label19  "(2) "
#property indicator_type19   DRAW_COLOR_LINE
#property indicator_color19  clrGray, clrRoyalBlue,clrHotPink, clrYellow, clrNONE
#property indicator_style19  STYLE_SOLID
#property indicator_width19  2


double         CCompra[];
double         VVenda[];



input group "Grupo 1"

input int                  MM_periodo              = 3;  // Periodo Rapido
input int                  MM_periodo_base         = 20; // Periodo Base
input int                  deslocamento_plot_type1 = 100;
input int                  deslocamento_plot_type2 = 100;
input int                  passo                   = 1;  // Multiplicador de Periodo

input group "Grupo 2"
input bool                 visualizar1_primario    =  false;
input bool                 visualizar1_secundario  =  false;
input bool                 visualizar1_terciario   =  false;

input bool                 visualizar2_primario    =  false;
input bool                 visualizar2_secundario  =  false;
input bool                 visualizar2_terciario   =  false;

input ENUM_MA_METHOD       MM_type1_modo          = MODE_SMA;
input ENUM_MA_METHOD       MM_type2_modo          = MODE_SMA;
input ENUM_APPLIED_PRICE   MM_type1_price         = PRICE_CLOSE;
input ENUM_APPLIED_PRICE   MM_type2_price         = PRICE_MEDIAN;

//--- Linha de Media 1
int                        MM1_type1_handle;
double                     MM1_type1_Array[];
double                     MM1_type1_ArrayColor[];
double                     MM1_type1_BuyValid[];

//--- Linha de Media 2
int                        MM2_type1_handle;
double                     MM2_type1_Array[];
double                     MM2_type1_ArrayColor[];
double                     MM2_type1_BuyValid[];

//--- Linha de Media 3
int                        MM3_type1_handle;
double                     MM3_type1_Array[];
double                     MM3_type1_ArrayColor[];
double                     MM3_type1_BuyValid[];

//--- Linha de Media 4
int                        MM4_type1_handle;
double                     MM4_type1_Array[];
double                     MM4_type1_ArrayColor[];
double                     MM4_type1_BuyValid[];

//--- Linha de Media 5
int                        MM5_type2_handle;
double                     MM5_type2_Array[];
double                     MM5_type2_ArrayColor[];
double                     MM5_type2_BuyValid[];

//--- Linha de Media 6
int                        MM6_type2_handle;
double                     MM6_type2_Array[];
double                     MM6_type2_ArrayColor[];
double                     MM6_type2_BuyValid[];

//--- Linha de Media 7
int                        MM7_type2_handle;
double                     MM7_type2_Array[];
double                     MM7_type2_ArrayColor[];
double                     MM7_type2_BuyValid[];

//--- Linha de Media 8
int                        MM8_type2_handle;
double                     MM8_type2_Array[];
double                     MM8_type2_ArrayColor[];
double                     MM8_type2_BuyValid[];

//--- Media 1 com 2
double                     MM_1to2_Array[];
double                     MM_1to2_ArrayColor[];

//--- Media 2 com 3
double                     MM_2to3_Array[];
double                     MM_2to3_ArrayColor[];

//--- Media 3 com 4
double                     MM_3to4_Array[];
double                     MM_3to4_ArrayColor[];


//--- Media 5 com 6
double                     MM_5to6_Array[];
double                     MM_5to6_ArrayColor[];

//--- Media 6 com 7
double                     MM_6to7_Array[];
double                     MM_6to7_ArrayColor[];

//--- Media 7 com 8
double                     MM_7to8_Array[];
double                     MM_7to8_ArrayColor[];

//--- Media Central
double                     MM_CENTRAL_Array[];
double                     MM_CENTRAL_ArrayColor[];

//--- Media MOVEL1
double                     MM_MOVEL1_Array[];
double                     MM_MOVEL1_ArrayColor[];

//--- Media MOVEL2
double                     MM_MOVEL2_Array[];
double                     MM_MOVEL2_ArrayColor[];

double                     MediaMovel1Data[];
double                     MediaMovel2Data[];

// Lenha media media 1 = 3 + (3+1)
// Lenha media media 2 = (3+1) + (3+2)
// Lenha media media 3 = (3+2) + (3+3)

//---
double                     MMedia[];
double                     MMediaColor[];

double                     Touro[];
double                     TouroColor[];

double                     HighColor[];
double                     LowColor[];
double                     OpenColor[];
double                     CloseColor[];
double                     CandleColor[];

int                        DVhandle;
double                     DV[];
double                     DVColor[];
double                     DVData[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
{
   SetIndexBuffer(0,  CCompra,                  INDICATOR_DATA);
   SetIndexBuffer(1,  VVenda,                   INDICATOR_DATA);

   SetIndexBuffer(2,  MM1_type1_Array,          INDICATOR_DATA);
   SetIndexBuffer(3,  MM1_type1_ArrayColor,     INDICATOR_COLOR_INDEX);
   SetIndexBuffer(4,  MM2_type1_Array,          INDICATOR_DATA);
   SetIndexBuffer(5,  MM2_type1_ArrayColor,     INDICATOR_COLOR_INDEX);
   SetIndexBuffer(6,  MM3_type1_Array,          INDICATOR_DATA);
   SetIndexBuffer(7,  MM3_type1_ArrayColor,     INDICATOR_COLOR_INDEX);
   SetIndexBuffer(8,  MM4_type1_Array,          INDICATOR_DATA);
   SetIndexBuffer(9,  MM4_type1_ArrayColor,     INDICATOR_COLOR_INDEX);

   SetIndexBuffer(10, MM5_type2_Array,          INDICATOR_DATA);
   SetIndexBuffer(11, MM5_type2_ArrayColor,     INDICATOR_COLOR_INDEX);
   SetIndexBuffer(12, MM6_type2_Array,          INDICATOR_DATA);
   SetIndexBuffer(13, MM6_type2_ArrayColor,     INDICATOR_COLOR_INDEX);
   SetIndexBuffer(14, MM7_type2_Array,          INDICATOR_DATA);
   SetIndexBuffer(15, MM7_type2_ArrayColor,     INDICATOR_COLOR_INDEX);
   SetIndexBuffer(16, MM8_type2_Array,          INDICATOR_DATA);
   SetIndexBuffer(17, MM8_type2_ArrayColor,     INDICATOR_COLOR_INDEX);
   SetIndexBuffer(18, MM_1to2_Array,            INDICATOR_DATA);
   SetIndexBuffer(19, MM_1to2_ArrayColor,       INDICATOR_COLOR_INDEX);
   SetIndexBuffer(20, MM_2to3_Array,            INDICATOR_DATA);
   SetIndexBuffer(21, MM_2to3_ArrayColor,       INDICATOR_COLOR_INDEX);
   SetIndexBuffer(22, MM_3to4_Array,            INDICATOR_DATA);
   SetIndexBuffer(23, MM_3to4_ArrayColor,       INDICATOR_COLOR_INDEX);
   SetIndexBuffer(24, MM_5to6_Array,            INDICATOR_DATA);
   SetIndexBuffer(25, MM_5to6_ArrayColor,       INDICATOR_COLOR_INDEX);
   SetIndexBuffer(26, MM_6to7_Array,            INDICATOR_DATA);
   SetIndexBuffer(27, MM_6to7_ArrayColor,       INDICATOR_COLOR_INDEX);
   SetIndexBuffer(28, MM_7to8_Array,            INDICATOR_DATA);
   SetIndexBuffer(29, MM_7to8_ArrayColor,       INDICATOR_COLOR_INDEX);
   SetIndexBuffer(30, MM_CENTRAL_Array,         INDICATOR_DATA);
   SetIndexBuffer(31, MM_CENTRAL_ArrayColor,    INDICATOR_COLOR_INDEX);
   SetIndexBuffer(32, MM_MOVEL1_Array,          INDICATOR_DATA);
   SetIndexBuffer(33, MM_MOVEL1_ArrayColor,     INDICATOR_COLOR_INDEX);
   SetIndexBuffer(34, MM_MOVEL2_Array,          INDICATOR_DATA);
   SetIndexBuffer(35, MM_MOVEL2_ArrayColor,     INDICATOR_COLOR_INDEX);
   SetIndexBuffer(36, MediaMovel1Data,          INDICATOR_DATA);
   SetIndexBuffer(37, MediaMovel2Data,          INDICATOR_DATA);

   //ArraySetAsSeries(MediaMovel1Data, true);
   //ArraySetAsSeries(MediaMovel2Data, true);

   MM1_type1_handle  = iMA       (_Symbol, _Period, MM_periodo + (0 * passo), 0, MM_type1_modo, MM_type1_price);
   MM2_type1_handle  = iMA       (_Symbol, _Period, MM_periodo + (1 * passo), 0, MM_type1_modo, MM_type1_price);
   MM3_type1_handle  = iMA       (_Symbol, _Period, MM_periodo + (2 * passo), 0, MM_type1_modo, MM_type1_price);
   MM4_type1_handle  = iMA       (_Symbol, _Period, MM_periodo + (3 * passo), 0, MM_type1_modo, MM_type1_price);

   MM5_type2_handle  = iMA       (_Symbol, _Period, MM_periodo + (0 * passo), 0, MM_type2_modo, MM_type2_price);
   MM6_type2_handle  = iMA       (_Symbol, _Period, MM_periodo + (1 * passo), 0, MM_type2_modo, MM_type2_price);
   MM7_type2_handle  = iMA       (_Symbol, _Period, MM_periodo + (2 * passo), 0, MM_type2_modo, MM_type2_price);
   MM8_type2_handle  = iMA       (_Symbol, _Period, MM_periodo + (3 * passo), 0, MM_type2_modo, MM_type2_price);


   
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
   int for_periodo = (MM_periodo + (3 * passo));

   CopyBuffer(MM1_type1_handle, 0, 0, rates_total, MM1_type1_Array);
   CopyBuffer(MM2_type1_handle, 0, 0, rates_total, MM2_type1_Array);
   CopyBuffer(MM3_type1_handle, 0, 0, rates_total, MM3_type1_Array);
   CopyBuffer(MM4_type1_handle, 0, 0, rates_total, MM4_type1_Array);

   CopyBuffer(MM5_type2_handle, 0, 0, rates_total, MM5_type2_Array);
   CopyBuffer(MM6_type2_handle, 0, 0, rates_total, MM6_type2_Array);
   CopyBuffer(MM7_type2_handle, 0, 0, rates_total, MM7_type2_Array);
   CopyBuffer(MM8_type2_handle, 0, 0, rates_total, MM8_type2_Array);

   for(int i = 0; i < rates_total; i++) {

      MM1_type1_Array[i] += deslocamento_plot_type1;
      MM2_type1_Array[i] += deslocamento_plot_type1;
      MM3_type1_Array[i] += deslocamento_plot_type1;
      MM4_type1_Array[i] += deslocamento_plot_type1;

      if(visualizar1_primario == false) {
         MM1_type1_ArrayColor[i] = 4;
         MM2_type1_ArrayColor[i] = 4;
         MM3_type1_ArrayColor[i] = 4;
         MM4_type1_ArrayColor[i] = 4;
      } else {
         MM1_type1_ArrayColor[i] = 0;
         MM2_type1_ArrayColor[i] = 0;
         MM3_type1_ArrayColor[i] = 0;
         MM4_type1_ArrayColor[i] = 0;
      }


   }

   for(int i = 0 ; i < rates_total; i++) {
      MM5_type2_Array[i] -= deslocamento_plot_type2;
      MM6_type2_Array[i] -= deslocamento_plot_type2;
      MM7_type2_Array[i] -= deslocamento_plot_type2;
      MM8_type2_Array[i] -= deslocamento_plot_type2;
      
      
      if(visualizar2_primario == false) {
         MM5_type2_ArrayColor[i] = 4;
         MM6_type2_ArrayColor[i] = 4;
         MM7_type2_ArrayColor[i] = 4;
         MM8_type2_ArrayColor[i] = 4;
      } else {
         MM5_type2_ArrayColor[i] = 0;
         MM6_type2_ArrayColor[i] = 0;
         MM7_type2_ArrayColor[i] = 0;
         MM8_type2_ArrayColor[i] = 0;
      }
   }

   for(int i = 0; i < rates_total; i++) {
      MM_1to2_Array[i]      = MediaDe2(MM1_type1_Array[i], MM2_type1_Array[i]);
      MM_2to3_Array[i]      = MediaDe2(MM2_type1_Array[i], MM3_type1_Array[i]);
      MM_3to4_Array[i]      = MediaDe2(MM3_type1_Array[i], MM4_type1_Array[i]);

      if(visualizar1_secundario == false) {
         MM_1to2_ArrayColor[i] = 4;
         MM_2to3_ArrayColor[i] = 4;
         MM_3to4_ArrayColor[i] = 4;
      } else {
         MM_1to2_ArrayColor[i] = 3;
         MM_2to3_ArrayColor[i] = 3;
         MM_3to4_ArrayColor[i] = 3;
      }
   }

   for(int i = 0; i < rates_total; i++) {
      MM_5to6_Array[i]      = MediaDe2(MM5_type2_Array[i], MM6_type2_Array[i]);
      MM_6to7_Array[i]      = MediaDe2(MM6_type2_Array[i], MM7_type2_Array[i]);
      MM_7to8_Array[i]      = MediaDe2(MM7_type2_Array[i], MM8_type2_Array[i]);

      if(visualizar2_secundario == false) {
         MM_5to6_ArrayColor[i] = 4;
         MM_6to7_ArrayColor[i] = 4;
         MM_7to8_ArrayColor[i] = 4;
      } else {
         MM_5to6_ArrayColor[i] = 3;
         MM_6to7_ArrayColor[i] = 3;
         MM_7to8_ArrayColor[i] = 3;
      }
   }

   for(int i = 0; i < rates_total; i++) {
      MM_CENTRAL_Array[i] = MM1_type1_Array[i] - deslocamento_plot_type1;
      MM_CENTRAL_ArrayColor[i] = 1;
   }

   for(int i = 0; i < rates_total; i++) {
      MediaMovel1Data[i] = MediaDe3(MM_1to2_Array[i], MM_2to3_Array[i], MM_3to4_Array[i]);

      MediaMovel2Data[i] = MediaDe3(MM_5to6_Array[i], MM_6to7_Array[i], MM_7to8_Array[i]);
   }

   for(int i = for_periodo; i < rates_total; i++) {

      MM_MOVEL1_Array[i]       = (MediaMovel1Data[i] + MediaMovel1Data[i - 1] + MediaMovel1Data[i - 2]) / 3 ;
      MM_MOVEL2_Array[i]       = (MediaMovel2Data[i] + MediaMovel2Data[i - 1] + MediaMovel2Data[i - 2]) / 3 ;
      
      MM_MOVEL1_ArrayColor[i]  = 0;
      MM_MOVEL2_ArrayColor[i]  = 0;



   }
   return(rates_total);
}
//+------------------------------------------------------------------+









