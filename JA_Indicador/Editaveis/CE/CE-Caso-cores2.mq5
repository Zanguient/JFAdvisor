//+------------------------------------------------------------------+
//|                                                  Caso-cores2.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      ""
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 9
#property indicator_plots   1
//--- plot Label1
#property indicator_label1  "Label1"
#property indicator_type1   DRAW_COLOR_CANDLES
#property indicator_color1  clrRed,clrDarkGreen,clrBisque,clrBlue,clrChocolate
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- indicator buffers
double         OpenBuf[];
double         HighBuf[];
double         LowBuf[];
double         CloseBuf[];
double         Dun[];
double         CandleColors[];

double         Compra[];
double         Venda[];

#define PI 3.141592654




int            handle;
double         MABuf[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,OpenBuf,INDICATOR_DATA);
   SetIndexBuffer(1,HighBuf,INDICATOR_DATA);
   SetIndexBuffer(2,LowBuf,INDICATOR_DATA);
   SetIndexBuffer(3,CloseBuf,INDICATOR_DATA);
   
   SetIndexBuffer(4,CandleColors,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(5,Dun,INDICATOR_DATA);   
   SetIndexBuffer(6,MABuf, INDICATOR_DATA);
   
   SetIndexBuffer(7,Compra, INDICATOR_DATA);
   SetIndexBuffer(8,Venda, INDICATOR_DATA);
   

   handle = iMA(NULL,0,20,0,MODE_EMA,PRICE_MEDIAN);
   if(handle==INVALID_HANDLE)
     {
         Comment("Erro ao abrir Media Movel");
     }   
//---

   Init_myLine("Line1");
 
   
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
   CopyBuffer(handle,0,0,rates_total,MABuf);
   
   double price_ask = SymbolInfoDouble(_Symbol,SYMBOL_LASTHIGH);
   double price_bid = SymbolInfoDouble(_Symbol,SYMBOL_BIDLOW);
   

   ObjectMove(0,"Line1",0,0,price_ask);
   

   
//--- return value of prev_calculated for next call

   for(int i=0;i<rates_total-1;i++)
     {
         OpenBuf[i] = open[i];
         HighBuf[i] = high[i];
         LowBuf[i] = low[i];
         CloseBuf[i] = close[i];
         
         //Padroniza todo o grafico para cor bisque
         CandleColors[i] = 2;
         
         if(high[i] < MABuf[i])
           {
            // Venda
            CandleColors[i] = 0;
            
           }else
         if(low[i] > MABuf[i])
           {
            CandleColors[i] = 1;
           }
           
         if((high[i] < MABuf[i]) && (low[i] > (MABuf[i]-60)))
           {
            CandleColors[i] = 2;
           }
           
         if((high[i] > MABuf[i]) && (low[i] < (MABuf[i]+60)))
           {
            CandleColors[i] = 2;
           }

           
         if((high[i] < MABuf[i]) && ( high[i] > (MABuf[i]-5)))
           {
            CandleColors[i] = 3;
           }
           
         if((high[i] > MABuf[i]) && (high[i] < (MABuf[i]+6)))
           {
            CandleColors[i] = 3;
           }
         if((high[i] > MABuf[i]) && (low[i] < MABuf[i]))
           {
            CandleColors[i] = 2;        
           }
           
// dunning
      

          

     }

   return(rates_total);
  }
//+------------------------------------------------------------------+

void Init_myLine(string name)
{
   ObjectCreate(0, name, OBJ_HLINE, 0,0,0);
   ObjectSetInteger(0,name, OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(0,name, OBJPROP_WIDTH, 1);
   ObjectSetInteger(0,name,OBJPROP_STYLE, STYLE_DASHDOTDOT);
} 

/*
void Init_myLabel()
{
   Obj
}
*/
