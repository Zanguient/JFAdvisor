//+------------------------------------------------------------------+
//|                                                   CV-CANDLES.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window

#property indicator_buffers   126
#property indicator_plots     0

#property indicator_label1 "Sinal"

#property indicator_label2 "Candles"
#property indicator_type2  DRAW_COLOR_CANDLES
#property indicator_style2 STYLE_SOLID
#property indicator_color2 clrGray, clrRoyalBlue
#property indicator_width2 1

//double medio;

double Open[];
double High[];
double Close[];
double Low[];

double Colors[];

input ENUM_MA_METHOD method = MODE_SMA;
input ENUM_APPLIED_PRICE price = PRICE_CLOSE;

//---
int ma_handle1;
int ma_handle2;
int ma_handle3;
int ma_handle4;
int ma_handle5;
int ma_handle6;
int ma_handle7;
int ma_handle8;
int ma_handle9;
int ma_handle10;
int ma_handle11;
int ma_handle12;
int ma_handle13;
int ma_handle14;
int ma_handle15;
int ma_handle16;
int ma_handle17;
int ma_handle18;
int ma_handle19;
int ma_handle20;

//---
double maArray1[];
double maArray2[];
double maArray3[];
double maArray4[];
double maArray5[];
double maArray6[];
double maArray7[];
double maArray8[];
double maArray9[];
double maArray10[];
double maArray11[];
double maArray12[];
double maArray13[];
double maArray14[];
double maArray15[];
double maArray16[];
double maArray17[];
double maArray18[];
double maArray19[];
double maArray20[];

//---
double ma_Sinal1[];
double ma_Sinal2[];
double ma_Sinal3[];
double ma_Sinal4[];
double ma_Sinal5[];
double ma_Sinal6[];
double ma_Sinal7[];
double ma_Sinal8[];
double ma_Sinal9[];
double ma_Sinal10[];
double ma_Sinal11[];
double ma_Sinal12[];
double ma_Sinal13[];
double ma_Sinal14[];
double ma_Sinal15[];
double ma_Sinal16[];
double ma_Sinal17[];
double ma_Sinal18[];
double ma_Sinal19[];
double ma_Sinal20[];

//---
int mo_ma_handle1;
int mo_ma_handle2;
int mo_ma_handle3;
int mo_ma_handle4;
int mo_ma_handle5;
int mo_ma_handle6;
int mo_ma_handle7;
int mo_ma_handle8;
int mo_ma_handle9;
int mo_ma_handle10;
int mo_ma_handle11;
int mo_ma_handle12;
int mo_ma_handle13;
int mo_ma_handle14;
int mo_ma_handle15;
int mo_ma_handle16;
int mo_ma_handle17;
int mo_ma_handle18;
int mo_ma_handle19;
int mo_ma_handle20;
//---
double mo_ma_array1[];
double mo_ma_array2[];
double mo_ma_array3[];
double mo_ma_array4[];
double mo_ma_array5[];
double mo_ma_array6[];
double mo_ma_array7[];
double mo_ma_array8[];
double mo_ma_array9[];
double mo_ma_array10[];
double mo_ma_array11[];
double mo_ma_array12[];
double mo_ma_array13[];
double mo_ma_array14[];
double mo_ma_array15[];
double mo_ma_array16[];
double mo_ma_array17[];
double mo_ma_array18[];
double mo_ma_array19[];
double mo_ma_array20[];

//---
double mo_ma_sinal1[];
double mo_ma_sinal2[];
double mo_ma_sinal3[];
double mo_ma_sinal4[];
double mo_ma_sinal5[];
double mo_ma_sinal6[];
double mo_ma_sinal7[];
double mo_ma_sinal8[];
double mo_ma_sinal9[];
double mo_ma_sinal10[];
double mo_ma_sinal11[];
double mo_ma_sinal12[];
double mo_ma_sinal13[];
double mo_ma_sinal14[];
double mo_ma_sinal15[];
double mo_ma_sinal16[];
double mo_ma_sinal17[];
double mo_ma_sinal18[];
double mo_ma_sinal19[];
double mo_ma_sinal20[];
//---
int mo_pr_handle1;
int mo_pr_handle2;
int mo_pr_handle3;
int mo_pr_handle4;
int mo_pr_handle5;
int mo_pr_handle6;
int mo_pr_handle7;
int mo_pr_handle8;
int mo_pr_handle9;
int mo_pr_handle10;
int mo_pr_handle11;
int mo_pr_handle12;
int mo_pr_handle13;
int mo_pr_handle14;
int mo_pr_handle15;
int mo_pr_handle16;
int mo_pr_handle17;
int mo_pr_handle18;
int mo_pr_handle19;
int mo_pr_handle20;
//---
double mo_pr_sinal1[];
double mo_pr_sinal2[];
double mo_pr_sinal3[];
double mo_pr_sinal4[];
double mo_pr_sinal5[];
double mo_pr_sinal6[];
double mo_pr_sinal7[];
double mo_pr_sinal8[];
double mo_pr_sinal9[];
double mo_pr_sinal10[];
double mo_pr_sinal11[];
double mo_pr_sinal12[];
double mo_pr_sinal13[];
double mo_pr_sinal14[];
double mo_pr_sinal15[];
double mo_pr_sinal16[];
double mo_pr_sinal17[];
double mo_pr_sinal18[];
double mo_pr_sinal19[];
double mo_pr_sinal20[];
//---
double mo_pr_array1[];
double mo_pr_array2[];
double mo_pr_array3[];
double mo_pr_array4[];
double mo_pr_array5[];
double mo_pr_array6[];
double mo_pr_array7[];
double mo_pr_array8[];
double mo_pr_array9[];
double mo_pr_array10[];
double mo_pr_array11[];
double mo_pr_array12[];
double mo_pr_array13[];
double mo_pr_array14[];
double mo_pr_array15[];
double mo_pr_array16[];
double mo_pr_array17[];
double mo_pr_array18[];
double mo_pr_array19[];
double mo_pr_array20[];
//---
int handleOHLC;
int handleMediasMoveis;
int handleMomentumMedias;
int handleMomentumPrecos;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
   SetIndexBuffer(0, Open,  INDICATOR_DATA);
   SetIndexBuffer(1, High,  INDICATOR_DATA);
   SetIndexBuffer(2, Low,   INDICATOR_DATA);
   SetIndexBuffer(3, Close, INDICATOR_DATA);
   SetIndexBuffer(4, Colors, INDICATOR_COLOR_INDEX);
//---
   SetIndexBuffer(5,  maArray1, INDICATOR_DATA);
   SetIndexBuffer(6,  maArray2, INDICATOR_DATA);
   SetIndexBuffer(7,  maArray3, INDICATOR_DATA);
   SetIndexBuffer(8,  maArray4, INDICATOR_DATA);
   SetIndexBuffer(9,  maArray5, INDICATOR_DATA);
   SetIndexBuffer(10, maArray6, INDICATOR_DATA);
   SetIndexBuffer(12, maArray7, INDICATOR_DATA);
   SetIndexBuffer(13, maArray8, INDICATOR_DATA);
   SetIndexBuffer(14, maArray9, INDICATOR_DATA);
   SetIndexBuffer(15, maArray10, INDICATOR_DATA);
   SetIndexBuffer(16, maArray11, INDICATOR_DATA);
   SetIndexBuffer(17, maArray12, INDICATOR_DATA);
   SetIndexBuffer(18, maArray13, INDICATOR_DATA);
   SetIndexBuffer(19, maArray14, INDICATOR_DATA);
   SetIndexBuffer(20, maArray15, INDICATOR_DATA);
   SetIndexBuffer(21, maArray16, INDICATOR_DATA);
   SetIndexBuffer(22, maArray17, INDICATOR_DATA);
   SetIndexBuffer(23, maArray18, INDICATOR_DATA);
   SetIndexBuffer(24, maArray19, INDICATOR_DATA);
   SetIndexBuffer(25, maArray20, INDICATOR_DATA);
//---
   SetIndexBuffer(26, ma_Sinal1, INDICATOR_DATA);
   SetIndexBuffer(27, ma_Sinal2, INDICATOR_DATA);
   SetIndexBuffer(28, ma_Sinal3, INDICATOR_DATA);
   SetIndexBuffer(29, ma_Sinal4, INDICATOR_DATA);
   SetIndexBuffer(30, ma_Sinal5, INDICATOR_DATA);
   SetIndexBuffer(31, ma_Sinal6, INDICATOR_DATA);
   SetIndexBuffer(32, ma_Sinal7, INDICATOR_DATA);
   SetIndexBuffer(33, ma_Sinal8, INDICATOR_DATA);
   SetIndexBuffer(34, ma_Sinal9, INDICATOR_DATA);
   SetIndexBuffer(35, ma_Sinal10, INDICATOR_DATA);
   SetIndexBuffer(36, ma_Sinal11, INDICATOR_DATA);
   SetIndexBuffer(37, ma_Sinal12, INDICATOR_DATA);
   SetIndexBuffer(38, ma_Sinal13, INDICATOR_DATA);
   SetIndexBuffer(39, ma_Sinal14, INDICATOR_DATA);
   SetIndexBuffer(40, ma_Sinal15, INDICATOR_DATA);
   SetIndexBuffer(41, ma_Sinal16, INDICATOR_DATA);
   SetIndexBuffer(42, ma_Sinal17, INDICATOR_DATA);
   SetIndexBuffer(43, ma_Sinal18, INDICATOR_DATA);
   SetIndexBuffer(44, ma_Sinal19, INDICATOR_DATA);
   SetIndexBuffer(45, ma_Sinal20, INDICATOR_DATA);
//---
   SetIndexBuffer(46, mo_ma_array1, INDICATOR_DATA);
   SetIndexBuffer(47, mo_ma_array2, INDICATOR_DATA);
   SetIndexBuffer(48, mo_ma_array3, INDICATOR_DATA);
   SetIndexBuffer(49, mo_ma_array4, INDICATOR_DATA);
   SetIndexBuffer(50, mo_ma_array5, INDICATOR_DATA);
   SetIndexBuffer(51, mo_ma_array6, INDICATOR_DATA);
   SetIndexBuffer(52, mo_ma_array7, INDICATOR_DATA);
   SetIndexBuffer(53, mo_ma_array8, INDICATOR_DATA);
   SetIndexBuffer(54, mo_ma_array9, INDICATOR_DATA);
   SetIndexBuffer(55, mo_ma_array10, INDICATOR_DATA);
   SetIndexBuffer(56, mo_ma_array11, INDICATOR_DATA);
   SetIndexBuffer(57, mo_ma_array12, INDICATOR_DATA);
   SetIndexBuffer(58, mo_ma_array13, INDICATOR_DATA);
   SetIndexBuffer(59, mo_ma_array14, INDICATOR_DATA);
   SetIndexBuffer(60, mo_ma_array15, INDICATOR_DATA);
   SetIndexBuffer(61, mo_ma_array16, INDICATOR_DATA);
   SetIndexBuffer(62, mo_ma_array17, INDICATOR_DATA);
   SetIndexBuffer(63, mo_ma_array18, INDICATOR_DATA);
   SetIndexBuffer(64, mo_ma_array19, INDICATOR_DATA);
   SetIndexBuffer(65, mo_ma_array20, INDICATOR_DATA);
//---
   SetIndexBuffer(66, mo_ma_sinal1, INDICATOR_DATA);
   SetIndexBuffer(67, mo_ma_sinal2, INDICATOR_DATA);
   SetIndexBuffer(68, mo_ma_sinal3, INDICATOR_DATA);
   SetIndexBuffer(69, mo_ma_sinal4, INDICATOR_DATA);
   SetIndexBuffer(70, mo_ma_sinal5, INDICATOR_DATA);
   SetIndexBuffer(71, mo_ma_sinal6, INDICATOR_DATA);
   SetIndexBuffer(72, mo_ma_sinal7, INDICATOR_DATA);
   SetIndexBuffer(73, mo_ma_sinal8, INDICATOR_DATA);
   SetIndexBuffer(74, mo_ma_sinal9, INDICATOR_DATA);
   SetIndexBuffer(75, mo_ma_sinal10, INDICATOR_DATA);
   SetIndexBuffer(76, mo_ma_sinal11, INDICATOR_DATA);
   SetIndexBuffer(77, mo_ma_sinal12, INDICATOR_DATA);
   SetIndexBuffer(78, mo_ma_sinal13, INDICATOR_DATA);
   SetIndexBuffer(79, mo_ma_sinal14, INDICATOR_DATA);
   SetIndexBuffer(80, mo_ma_sinal15, INDICATOR_DATA);
   SetIndexBuffer(81, mo_ma_sinal16, INDICATOR_DATA);
   SetIndexBuffer(82, mo_ma_sinal17, INDICATOR_DATA);
   SetIndexBuffer(83, mo_ma_sinal18, INDICATOR_DATA);
   SetIndexBuffer(84, mo_ma_sinal19, INDICATOR_DATA);
   SetIndexBuffer(85, mo_ma_sinal20, INDICATOR_DATA);
//---
   SetIndexBuffer(86, mo_pr_array1, INDICATOR_DATA);
   SetIndexBuffer(87, mo_pr_array2, INDICATOR_DATA);
   SetIndexBuffer(88, mo_pr_array3, INDICATOR_DATA);
   SetIndexBuffer(89, mo_pr_array4, INDICATOR_DATA);
   SetIndexBuffer(90, mo_pr_array5, INDICATOR_DATA);
   SetIndexBuffer(91, mo_pr_array6, INDICATOR_DATA);
   SetIndexBuffer(92, mo_pr_array7, INDICATOR_DATA);
   SetIndexBuffer(93, mo_pr_array8, INDICATOR_DATA);
   SetIndexBuffer(94, mo_pr_array9, INDICATOR_DATA);
   SetIndexBuffer(95, mo_pr_array10, INDICATOR_DATA);
   SetIndexBuffer(96, mo_pr_array11, INDICATOR_DATA);
   SetIndexBuffer(97, mo_pr_array12, INDICATOR_DATA);
   SetIndexBuffer(98, mo_pr_array13, INDICATOR_DATA);
   SetIndexBuffer(99, mo_pr_array14, INDICATOR_DATA);
   SetIndexBuffer(100, mo_pr_array15, INDICATOR_DATA);
   SetIndexBuffer(101, mo_pr_array16, INDICATOR_DATA);
   SetIndexBuffer(102, mo_pr_array17, INDICATOR_DATA);
   SetIndexBuffer(103, mo_pr_array18, INDICATOR_DATA);
   SetIndexBuffer(104, mo_pr_array19, INDICATOR_DATA);
   SetIndexBuffer(105, mo_pr_array20, INDICATOR_DATA);
//---
   SetIndexBuffer(106, mo_pr_sinal1, INDICATOR_DATA);
   SetIndexBuffer(107, mo_pr_sinal2, INDICATOR_DATA);
   SetIndexBuffer(108, mo_pr_sinal3, INDICATOR_DATA);
   SetIndexBuffer(109, mo_pr_sinal4, INDICATOR_DATA);
   SetIndexBuffer(110, mo_pr_sinal5, INDICATOR_DATA);
   SetIndexBuffer(111, mo_pr_sinal6, INDICATOR_DATA);
   SetIndexBuffer(112, mo_pr_sinal7, INDICATOR_DATA);
   SetIndexBuffer(113, mo_pr_sinal8, INDICATOR_DATA);
   SetIndexBuffer(114, mo_pr_sinal9, INDICATOR_DATA);
   SetIndexBuffer(115, mo_pr_sinal10, INDICATOR_DATA);
   SetIndexBuffer(116, mo_pr_sinal11, INDICATOR_DATA);
   SetIndexBuffer(117, mo_pr_sinal12, INDICATOR_DATA);
   SetIndexBuffer(118, mo_pr_sinal13, INDICATOR_DATA);
   SetIndexBuffer(119, mo_pr_sinal14, INDICATOR_DATA);
   SetIndexBuffer(120, mo_pr_sinal15, INDICATOR_DATA);
   SetIndexBuffer(121, mo_pr_sinal16, INDICATOR_DATA);
   SetIndexBuffer(122, mo_pr_sinal17, INDICATOR_DATA);
   SetIndexBuffer(123, mo_pr_sinal18, INDICATOR_DATA);
   SetIndexBuffer(124, mo_pr_sinal19, INDICATOR_DATA);
   SetIndexBuffer(125, mo_pr_sinal20, INDICATOR_DATA);
//---
   ma_handle1  = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 2, price, method);
   ma_handle2  = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 3, price, method);
   ma_handle3  = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 4, price, method);
   ma_handle4  = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 5, price, method);
   ma_handle5  = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 6, price, method);
   ma_handle6  = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 7, price, method);
   ma_handle7  = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 8, price, method);
   ma_handle8  = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 9, price, method);
   ma_handle9  = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 10, price, method);
   ma_handle10 = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 11, price, method);
   ma_handle11 = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 12, price, method);
   ma_handle12 = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 13, price, method);
   ma_handle13 = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 14, price, method);
   ma_handle14 = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 15, price, method);
   ma_handle15 = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 16, price, method);
   ma_handle16 = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 17, price, method);
   ma_handle17 = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 18, price, method);
   ma_handle18 = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 19, price, method);
   ma_handle19 = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 20, price, method);
   ma_handle20 = iCustom(_Symbol, _Period, "estudo\\CV-MA-COMPOSTA3", 0, 21, price, method);
//---
   mo_ma_handle1  = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosMedias", 1, 3);
   mo_ma_handle2  = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosMedias", 2, 3);
   mo_ma_handle3  = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosMedias", 3, 3);
   mo_ma_handle4  = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosMedias", 4, 3);
   mo_ma_handle5  = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosMedias", 5, 3);
   mo_ma_handle6  = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosMedias", 6, 3);
   mo_ma_handle7  = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosMedias", 7, 3);
   mo_ma_handle8  = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosMedias", 8, 3);
   mo_ma_handle9  = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosMedias", 9, 3);
   mo_ma_handle10 = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosMedias", 10, 3);
   mo_ma_handle11 = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosMedias", 11, 3);
   mo_ma_handle12 = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosMedias", 12, 3);
   mo_ma_handle13 = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosMedias", 13, 3);
   mo_ma_handle14 = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosMedias", 14, 3);
   mo_ma_handle15 = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosMedias", 15, 3);
   mo_ma_handle16 = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosMedias", 16, 3);
   mo_ma_handle17 = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosMedias", 17, 3);
   mo_ma_handle18 = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosMedias", 18, 3);
   mo_ma_handle19 = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosMedias", 19, 3);
   mo_ma_handle20 = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosMedias", 20, 3);
//---
   mo_pr_handle1   = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosPrecos", 1);
   mo_pr_handle2   = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosPrecos", 2);
   mo_pr_handle3   = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosPrecos", 3);
   mo_pr_handle4   = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosPrecos", 4);
   mo_pr_handle5   = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosPrecos", 5);
   mo_pr_handle6   = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosPrecos", 6);
   mo_pr_handle7   = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosPrecos", 7);
   mo_pr_handle8   = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosPrecos", 8);
   mo_pr_handle9   = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosPrecos", 9);
   mo_pr_handle10  = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosPrecos", 10);
   mo_pr_handle11  = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosPrecos", 11);
   mo_pr_handle12  = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosPrecos", 12);
   mo_pr_handle13  = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosPrecos", 13);
   mo_pr_handle14  = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosPrecos", 14);
   mo_pr_handle15  = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosPrecos", 15);
   mo_pr_handle16  = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosPrecos", 16);
   mo_pr_handle17  = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosPrecos", 17);
   mo_pr_handle18  = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosPrecos", 18);
   mo_pr_handle19  = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosPrecos", 19);
   mo_pr_handle20  = iCustom(_Symbol, _Period, "estudo\\CV-MomentumMultiplosPrecos", 20);   
//---
   handleOHLC           = FileOpen(Symbol() + "_OHLC.csv", FILE_READ | FILE_WRITE | FILE_CSV );
   handleMediasMoveis   = FileOpen(Symbol() + "_MediasMoveis.csv", FILE_READ | FILE_WRITE | FILE_CSV );
   handleMomentumMedias = FileOpen(Symbol() + "_MomentumMedias.csv", FILE_READ | FILE_WRITE | FILE_CSV );
   handleMomentumPrecos = FileOpen(Symbol() + "_MomentumPrecos.csv", FILE_READ | FILE_WRITE | FILE_CSV );
//---
//FileWrite(handleArquivo,
//          "\"Time\"",
//          "\"Open\"",
//          "\"Close\"",
//          "\"Volume\"",
//          "\"Ma-" + IntegerToString(ma1) + "\"",
//          "\"Ma-" + IntegerToString(ma2) + "\"",
//          "\"Ma-" + IntegerToString(ma3) + "\"",
//          "\"Ma-" + IntegerToString(ma4) + "\"",
//          "\"Ma-Sinal-" + IntegerToString(ma1) + "\"",
//          "\"Ma-Sinal-" + IntegerToString(ma2) + "\"",
//          "\"Ma-Sinal-" + IntegerToString(ma3) + "\"",
//          "\"Ma-Sinal-" + IntegerToString(ma4) + "\""
//         );
//---
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   FileClose(handleOHLC);
   FileClose(handleMediasMoveis);
   FileClose(handleMomentumMedias);
   FileClose(handleMomentumPrecos);
//---
//FileClose();
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
      inicio = 0;
      qtdCopy = rates_total;
   } else {
      inicio = prev_calculated - 1;
      qtdCopy = 1;
   }

//--- precos medias
   CopyBuffer(ma_handle1,  1, 0, qtdCopy, maArray1);
   CopyBuffer(ma_handle2,  1, 0, qtdCopy, maArray2);
   CopyBuffer(ma_handle3,  1, 0, qtdCopy, maArray3);
   CopyBuffer(ma_handle4,  1, 0, qtdCopy, maArray4);
   CopyBuffer(ma_handle5,  1, 0, qtdCopy, maArray5);
   CopyBuffer(ma_handle6,  1, 0, qtdCopy, maArray6);
   CopyBuffer(ma_handle7,  1, 0, qtdCopy, maArray7);
   CopyBuffer(ma_handle8,  1, 0, qtdCopy, maArray8);
   CopyBuffer(ma_handle9,  1, 0, qtdCopy, maArray9);
   CopyBuffer(ma_handle10, 1, 0, qtdCopy, maArray10);
   CopyBuffer(ma_handle11, 1, 0, qtdCopy, maArray11);
   CopyBuffer(ma_handle12, 1, 0, qtdCopy, maArray12);
   CopyBuffer(ma_handle13, 1, 0, qtdCopy, maArray13);
   CopyBuffer(ma_handle14, 1, 0, qtdCopy, maArray14);
   CopyBuffer(ma_handle15, 1, 0, qtdCopy, maArray15);
   CopyBuffer(ma_handle16, 1, 0, qtdCopy, maArray16);
   CopyBuffer(ma_handle17, 1, 0, qtdCopy, maArray17);
   CopyBuffer(ma_handle18, 1, 0, qtdCopy, maArray18);
   CopyBuffer(ma_handle19, 1, 0, qtdCopy, maArray19);
   CopyBuffer(ma_handle20, 1, 0, qtdCopy, maArray20);
//--- Sinal medias
   CopyBuffer(ma_handle1,  0, 0, qtdCopy, ma_Sinal1);
   CopyBuffer(ma_handle2,  0, 0, qtdCopy, ma_Sinal2);
   CopyBuffer(ma_handle3,  0, 0, qtdCopy, ma_Sinal3);
   CopyBuffer(ma_handle4,  0, 0, qtdCopy, ma_Sinal4);
   CopyBuffer(ma_handle5,  0, 0, qtdCopy, ma_Sinal5);
   CopyBuffer(ma_handle6,  0, 0, qtdCopy, ma_Sinal6);
   CopyBuffer(ma_handle7,  0, 0, qtdCopy, ma_Sinal7);
   CopyBuffer(ma_handle8,  0, 0, qtdCopy, ma_Sinal8);
   CopyBuffer(ma_handle9,  0, 0, qtdCopy, ma_Sinal9);
   CopyBuffer(ma_handle10, 0, 0, qtdCopy, ma_Sinal10);
   CopyBuffer(ma_handle11, 0, 0, qtdCopy, ma_Sinal11);
   CopyBuffer(ma_handle12, 0, 0, qtdCopy, ma_Sinal12);
   CopyBuffer(ma_handle13, 0, 0, qtdCopy, ma_Sinal13);
   CopyBuffer(ma_handle14, 0, 0, qtdCopy, ma_Sinal14);
   CopyBuffer(ma_handle15, 0, 0, qtdCopy, ma_Sinal15);
   CopyBuffer(ma_handle16, 0, 0, qtdCopy, ma_Sinal16);
   CopyBuffer(ma_handle17, 0, 0, qtdCopy, ma_Sinal17);
   CopyBuffer(ma_handle18, 0, 0, qtdCopy, ma_Sinal18);
   CopyBuffer(ma_handle19, 0, 0, qtdCopy, ma_Sinal19);
   CopyBuffer(ma_handle20, 0, 0, qtdCopy, ma_Sinal20);
//---
   CopyBuffer(mo_ma_handle1,  1, 0, qtdCopy, mo_ma_array1);
   CopyBuffer(mo_ma_handle2,  1, 0, qtdCopy, mo_ma_array2);
   CopyBuffer(mo_ma_handle3,  1, 0, qtdCopy, mo_ma_array3);
   CopyBuffer(mo_ma_handle4,  1, 0, qtdCopy, mo_ma_array4);
   CopyBuffer(mo_ma_handle5,  1, 0, qtdCopy, mo_ma_array5);
   CopyBuffer(mo_ma_handle6,  1, 0, qtdCopy, mo_ma_array6);
   CopyBuffer(mo_ma_handle7,  1, 0, qtdCopy, mo_ma_array7);
   CopyBuffer(mo_ma_handle8,  1, 0, qtdCopy, mo_ma_array8);
   CopyBuffer(mo_ma_handle9,  1, 0, qtdCopy, mo_ma_array9);
   CopyBuffer(mo_ma_handle10, 1, 0, qtdCopy, mo_ma_array10);
   CopyBuffer(mo_ma_handle11, 1, 0, qtdCopy, mo_ma_array11);
   CopyBuffer(mo_ma_handle12, 1, 0, qtdCopy, mo_ma_array12);
   CopyBuffer(mo_ma_handle13, 1, 0, qtdCopy, mo_ma_array13);
   CopyBuffer(mo_ma_handle14, 1, 0, qtdCopy, mo_ma_array14);
   CopyBuffer(mo_ma_handle15, 1, 0, qtdCopy, mo_ma_array15);
   CopyBuffer(mo_ma_handle16, 1, 0, qtdCopy, mo_ma_array16);
   CopyBuffer(mo_ma_handle17, 1, 0, qtdCopy, mo_ma_array17);
   CopyBuffer(mo_ma_handle18, 1, 0, qtdCopy, mo_ma_array18);
   CopyBuffer(mo_ma_handle19, 1, 0, qtdCopy, mo_ma_array19);
   CopyBuffer(mo_ma_handle20, 1, 0, qtdCopy, mo_ma_array20);
//---
   CopyBuffer(mo_ma_handle1,   0, 0, qtdCopy, mo_ma_sinal1);
   CopyBuffer(mo_ma_handle2,   0, 0, qtdCopy, mo_ma_sinal2);
   CopyBuffer(mo_ma_handle3,   0, 0, qtdCopy, mo_ma_sinal3);
   CopyBuffer(mo_ma_handle4,   0, 0, qtdCopy, mo_ma_sinal4);
   CopyBuffer(mo_ma_handle5,   0, 0, qtdCopy, mo_ma_sinal5);
   CopyBuffer(mo_ma_handle6,   0, 0, qtdCopy, mo_ma_sinal6);
   CopyBuffer(mo_ma_handle7,   0, 0, qtdCopy, mo_ma_sinal7);
   CopyBuffer(mo_ma_handle8,   0, 0, qtdCopy, mo_ma_sinal8);
   CopyBuffer(mo_ma_handle9,   0, 0, qtdCopy, mo_ma_sinal9);
   CopyBuffer(mo_ma_handle10,  0, 0, qtdCopy, mo_ma_sinal10);
   CopyBuffer(mo_ma_handle11,  0, 0, qtdCopy, mo_ma_sinal11);
   CopyBuffer(mo_ma_handle12,  0, 0, qtdCopy, mo_ma_sinal12);
   CopyBuffer(mo_ma_handle13,  0, 0, qtdCopy, mo_ma_sinal13);
   CopyBuffer(mo_ma_handle14,  0, 0, qtdCopy, mo_ma_sinal14);
   CopyBuffer(mo_ma_handle15,  0, 0, qtdCopy, mo_ma_sinal15);
   CopyBuffer(mo_ma_handle16,  0, 0, qtdCopy, mo_ma_sinal16);
   CopyBuffer(mo_ma_handle17,  0, 0, qtdCopy, mo_ma_sinal17);
   CopyBuffer(mo_ma_handle18,  0, 0, qtdCopy, mo_ma_sinal18);
   CopyBuffer(mo_ma_handle19,  0, 0, qtdCopy, mo_ma_sinal19);
   CopyBuffer(mo_ma_handle20,  0, 0, qtdCopy, mo_ma_sinal20);
//---
   CopyBuffer(mo_pr_handle1,    0, 0, qtdCopy, mo_pr_sinal1);
   CopyBuffer(mo_pr_handle2,    0, 0, qtdCopy, mo_pr_sinal2);
   CopyBuffer(mo_pr_handle3,    0, 0, qtdCopy, mo_pr_sinal3);
   CopyBuffer(mo_pr_handle4,    0, 0, qtdCopy, mo_pr_sinal4);
   CopyBuffer(mo_pr_handle5,    0, 0, qtdCopy, mo_pr_sinal5);
   CopyBuffer(mo_pr_handle6,    0, 0, qtdCopy, mo_pr_sinal6);
   CopyBuffer(mo_pr_handle7,    0, 0, qtdCopy, mo_pr_sinal7);
   CopyBuffer(mo_pr_handle8,    0, 0, qtdCopy, mo_pr_sinal8);
   CopyBuffer(mo_pr_handle9,    0, 0, qtdCopy, mo_pr_sinal9);
   CopyBuffer(mo_pr_handle10,   0, 0, qtdCopy, mo_pr_sinal10);
   CopyBuffer(mo_pr_handle11,   0, 0, qtdCopy, mo_pr_sinal11);
   CopyBuffer(mo_pr_handle12,   0, 0, qtdCopy, mo_pr_sinal12);
   CopyBuffer(mo_pr_handle13,   0, 0, qtdCopy, mo_pr_sinal13);
   CopyBuffer(mo_pr_handle14,   0, 0, qtdCopy, mo_pr_sinal14);
   CopyBuffer(mo_pr_handle15,   0, 0, qtdCopy, mo_pr_sinal15);
   CopyBuffer(mo_pr_handle16,   0, 0, qtdCopy, mo_pr_sinal16);
   CopyBuffer(mo_pr_handle17,   0, 0, qtdCopy, mo_pr_sinal17);
   CopyBuffer(mo_pr_handle18,   0, 0, qtdCopy, mo_pr_sinal18);
   CopyBuffer(mo_pr_handle19,   0, 0, qtdCopy, mo_pr_sinal19);
   CopyBuffer(mo_pr_handle20,   0, 0, qtdCopy, mo_pr_sinal20);

   for(int i = inicio; i < rates_total; i++) {
      //Sinal[i] = 0;
      ////---
      //Colors[i] = 0;
      //medio = (high[i] + low[i]) / 2;
      ////---
      //Open[i] = open[i] - maArray[i];
      //High[i] = high[i] - maArray[i];
      //Close[i]  = close[i] - maArray[i];
      //Low[i] = low[i] - maArray[i];
      ////---
      //if(open[i] < close[i]) {
      //   Colors[i] = 1;
      //}
      ////---
      FileWrite(
         handleOHLC,
         TimeToString(time[i]),
         (int)volume[i],
         (int)tick_volume[i],
         (int)open[i],
         (int)high[i],
         (int)low[i],
         (int)close[i]
      );
      FileWrite(
         handleMediasMoveis,
         TimeToString(time[i]),
         //---
         (int)maArray1[i],   // ma 2
         (int)maArray2[i],   // ma 3
         (int)maArray3[i],   // ma 4
         (int)maArray4[i],   // ma 5
         (int)maArray5[i],   // ma 6
         (int)maArray6[i],   // ma 7
         (int)maArray7[i],   // ma 8
         (int)maArray8[i],   // ma 9
         (int)maArray9[i],   // ma 10
         (int)maArray10[i],  // ma 15
         (int)maArray11[i],  // ma 20
         (int)maArray12[i],  // ma 25
         (int)maArray13[i],  // ma 30
         (int)maArray14[i],  // ma 35
         (int)maArray15[i],  // ma 40
         (int)maArray16[i],  // ma 45
         (int)maArray17[i],  // ma 50
         (int)maArray18[i],  // ma 55
         (int)maArray19[i],  // ma 60
         (int)maArray20[i],  // ma 65
         //---
         (int)ma_Sinal1[i],  // sinal ma 2
         (int)ma_Sinal2[i],  // sinal ma 3
         (int)ma_Sinal3[i],  // sinal ma 4
         (int)ma_Sinal4[i],  // sinal ma 5
         (int)ma_Sinal5[i],  // sinal ma 6
         (int)ma_Sinal6[i],  // sinal ma 7
         (int)ma_Sinal7[i],  // sinal ma 8
         (int)ma_Sinal8[i],  // sinal ma 9
         (int)ma_Sinal9[i],  // sinal ma 10
         (int)ma_Sinal10[i], // sinal ma 15
         (int)ma_Sinal11[i], // sinal ma 20
         (int)ma_Sinal12[i], // sinal ma 25
         (int)ma_Sinal13[i], // sinal ma 30
         (int)ma_Sinal14[i], // sinal ma 35
         (int)ma_Sinal15[i], // sinal ma 40
         (int)ma_Sinal16[i], // sinal ma 45
         (int)ma_Sinal17[i], // sinal ma 50
         (int)ma_Sinal18[i], // sinal ma 55
         (int)ma_Sinal19[i], // sinal ma 60
         (int)ma_Sinal20[i]  // sinal ma 65
      );
      //---
      FileWrite(
         handleMomentumMedias,
         TimeToString(time[i]),
         //---
         DoubleToString(mo_ma_array1[i], 5),
         DoubleToString(mo_ma_array2[i], 5),
         DoubleToString(mo_ma_array3[i], 5),
         DoubleToString(mo_ma_array4[i], 5),
         DoubleToString(mo_ma_array5[i], 5),
         DoubleToString(mo_ma_array6[i], 5),
         DoubleToString(mo_ma_array7[i], 5),
         DoubleToString(mo_ma_array8[i], 5),
         DoubleToString(mo_ma_array9[i], 5),
         DoubleToString(mo_ma_array10[i], 5),
         DoubleToString(mo_ma_array11[i], 5),
         DoubleToString(mo_ma_array12[i], 5),
         DoubleToString(mo_ma_array13[i], 5),
         DoubleToString(mo_ma_array14[i], 5),
         DoubleToString(mo_ma_array15[i], 5),
         DoubleToString(mo_ma_array16[i], 5),
         DoubleToString(mo_ma_array17[i], 5),
         DoubleToString(mo_ma_array18[i], 5),
         DoubleToString(mo_ma_array19[i], 5),
         DoubleToString(mo_ma_array20[i], 5),
         //---
         DoubleToString(mo_ma_sinal1[i],  0),
         DoubleToString(mo_ma_sinal2[i],  0),
         DoubleToString(mo_ma_sinal3[i],  0),
         DoubleToString(mo_ma_sinal4[i],  0),
         DoubleToString(mo_ma_sinal5[i],  0),
         DoubleToString(mo_ma_sinal6[i],  0),
         DoubleToString(mo_ma_sinal7[i],  0),
         DoubleToString(mo_ma_sinal8[i],  0),
         DoubleToString(mo_ma_sinal9[i],  0),
         DoubleToString(mo_ma_sinal10[i], 0),
         DoubleToString(mo_ma_sinal11[i], 0),
         DoubleToString(mo_ma_sinal12[i], 0),
         DoubleToString(mo_ma_sinal13[i], 0),
         DoubleToString(mo_ma_sinal14[i], 0),
         DoubleToString(mo_ma_sinal15[i], 0),
         DoubleToString(mo_ma_sinal16[i], 0),
         DoubleToString(mo_ma_sinal17[i], 0),
         DoubleToString(mo_ma_sinal18[i], 0),
         DoubleToString(mo_ma_sinal19[i], 0),
         DoubleToString(mo_ma_sinal20[i], 0)
      );
      //---
      FileWrite(
         handleMomentumPrecos,
         TimeToString(time[i]),
         //---
         DoubleToString(mo_pr_array1[i],  5),
         DoubleToString(mo_pr_array2[i],  5),
         DoubleToString(mo_pr_array3[i],  5),
         DoubleToString(mo_pr_array4[i],  5),
         DoubleToString(mo_pr_array5[i],  5),
         DoubleToString(mo_pr_array6[i],  5),
         DoubleToString(mo_pr_array7[i],  5),
         DoubleToString(mo_pr_array8[i],  5),
         DoubleToString(mo_pr_array9[i],  5),
         DoubleToString(mo_pr_array10[i], 5),
         DoubleToString(mo_pr_array11[i], 5),
         DoubleToString(mo_pr_array12[i], 5),
         DoubleToString(mo_pr_array13[i], 5),
         DoubleToString(mo_pr_array14[i], 5),
         DoubleToString(mo_pr_array15[i], 5),
         DoubleToString(mo_pr_array16[i], 5),
         DoubleToString(mo_pr_array17[i], 5),
         DoubleToString(mo_pr_array18[i], 5),
         DoubleToString(mo_pr_array19[i], 5),
         DoubleToString(mo_pr_array20[i], 5),
         //---
         DoubleToString(mo_pr_sinal1[i],  5),
         DoubleToString(mo_pr_sinal2[i],  5),
         DoubleToString(mo_pr_sinal3[i],  5),
         DoubleToString(mo_pr_sinal4[i],  5),
         DoubleToString(mo_pr_sinal5[i],  5),
         DoubleToString(mo_pr_sinal6[i],  5),
         DoubleToString(mo_pr_sinal7[i],  5),
         DoubleToString(mo_pr_sinal8[i],  5),
         DoubleToString(mo_pr_sinal9[i],  5),
         DoubleToString(mo_pr_sinal10[i], 5),
         DoubleToString(mo_pr_sinal11[i], 5),
         DoubleToString(mo_pr_sinal12[i], 5),
         DoubleToString(mo_pr_sinal13[i], 5),
         DoubleToString(mo_pr_sinal14[i], 5),
         DoubleToString(mo_pr_sinal15[i], 5),
         DoubleToString(mo_pr_sinal16[i], 5),
         DoubleToString(mo_pr_sinal17[i], 5),
         DoubleToString(mo_pr_sinal18[i], 5),
         DoubleToString(mo_pr_sinal19[i], 5),
         DoubleToString(mo_pr_sinal20[i], 5)
      );
   }
//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
