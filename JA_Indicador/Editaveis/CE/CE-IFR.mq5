//+------------------------------------------------------------------+
//|                                                       CV-IFR.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      ""
#property version   "1.00"

#property indicator_separate_window

#property indicator_height 20
#property indicator_minimum 0
#property indicator_maximum 1
#property indicator_buffers 5
#property indicator_plots   5


#property indicator_label1 "COMPRA"
#property indicator_label2 "VENDA"

//--- plot Mostrador
#property indicator_label3      "Mostrador"
#property indicator_type3       DRAW_COLOR_HISTOGRAM
#property indicator_levelwidth  3
#property indicator_color3      clrRed,clrLime,clrDimGray
#property indicator_style3      STYLE_SOLID
#property indicator_width3      1

//--- indicator buffers
double         Mostrador[];
double         MostradorColors[];

double          COMPRA[], 
                VENDA[];

double          IFRArray[];
int             IFRHandle;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
    SetIndexBuffer(0,COMPRA,INDICATOR_DATA);
    SetIndexBuffer(1,VENDA,INDICATOR_DATA);
    SetIndexBuffer(2,IFRArray,INDICATOR_DATA);
    SetIndexBuffer(3, MostradorColors, INDICATOR_COLOR_INDEX);    
    SetIndexBuffer(4, Mostrador, INDICATOR_DATA);
    
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
    
    CopyBuffer(iRSI(_Symbol,_Period,14,PRICE_CLOSE),0,0,rates_total,IFRArray);
    
    
    
    for(int i=0;i<rates_total;i++)
      {
        
        Mostrador[i] =1;
        COMPRA[i] = IFRArray[i] < 30? 1 : 0 ;
        VENDA[i] = IFRArray[i] > 70? 1 : 0 ;
        
        if(COMPRA[i] == 1)
          {
           MostradorColors[i] = 1;
          }else
        if(VENDA[i] == 1)
          {
           MostradorColors[i] = 0;
          }
        else
          {
           MostradorColors[i] = 2;
          }
        
        
      }
      
    
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
