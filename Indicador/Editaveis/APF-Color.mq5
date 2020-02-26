//+------------------------------------------------------------------+
//|                                                    APF-Color.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      ""
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 5
#property indicator_plots   1
//--- plot Label1
#property indicator_label1  "Label1"
#property indicator_type1   DRAW_COLOR_CANDLES
#property indicator_color1  clrRed,clrForestGreen,clrBisque
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- indicator buffers
double         OpenBuffer1[];
double         HighBuffer2[];
double         LowBuffer3[];
double         CloseBuffer4[]; 
double         CandleColors[];



int bars_calculated = 0;

int handle;
double buf_MA[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,OpenBuffer1,INDICATOR_DATA);
   SetIndexBuffer(1,HighBuffer2,INDICATOR_DATA);
   SetIndexBuffer(2,LowBuffer3,INDICATOR_DATA);
   SetIndexBuffer(3,CloseBuffer4,INDICATOR_DATA);
   SetIndexBuffer(4,CandleColors,INDICATOR_COLOR_INDEX);
   
   ArraySetAsSeries(buf_MA, true);
   
   handle=iMA(_Symbol,_Period,20,0,MODE_EMA,PRICE_CLOSE);
   if(handle==INVALID_HANDLE)
     {
         PrintFormat("Falha ao criar o indicador iMA para simbilo %s%s, Codigo do erro %d",_Symbol, EnumToString(_Period), GetLastError());
         return(INIT_FAILED);
     }
     

     
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                
                const double &open[],  //0
                const double &high[],  //1 
                const double &low[],   //2
                const double &close[], //3
                
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---

   

   int start =0, values_to_copy=rates_total;
   
      
   int calculated = BarsCalculated(handle);
   
   if(calculated<=0)
     {
         PrintFormat("BarsCAlculated() retornado %d, codigo do erro %d", calculated, GetLastError());
         return(0);
     }
   
   //---
   if(prev_calculated==0 || calculated==bars_calculated || rates_total>prev_calculated+1)
     {
     if(calculated>rates_total)
       {
        values_to_copy=rates_total;
       }
       else values_to_copy=calculated;
     }
     else
       {
        values_to_copy=(rates_total-prev_calculated)+1;
       }
   
   if(prev_calculated>0)start =rates_total-1;
   else start=0;  
     
     
     
     
     
     
   for(int i=start;i<rates_total;i++)
     {
         OpenBuffer1[i] = open[i];
         HighBuffer2[i] = high[i];
         LowBuffer3[i] = low[i];
         CloseBuffer4[i] = close[i];
         
         CandleColors[i] = 2;
         
         if(open[i]<close[i])
           {
            CandleColors[i] = 1;
           }else
         if(open[i]>close[i])
           {
            CandleColors[i] = 0;
           }
           
           
         if((high[i]>buf_MA[i] ) && (low[i] < buf_MA[i]))
           {
            CandleColors[i] = 2;
           }

         
     }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
