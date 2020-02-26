//+------------------------------------------------------------------+
//|                                                Multi-Medias2.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 2


#define  PI 3.141592654

//--- plot Label1
#property indicator_label1  "Venda"
//--- plot Label2
#property indicator_label2  "Compra"


//--- indicator buffers
double         Label1Buffer[];
double         Label2Buffer[];
double         Label3Buffer[];
double         Label4Buffer[];
double         Label5Buffer[];
double         Label6Buffer[];
double         Label7Buffer[];
double         Label8Buffer[];
double         Label9Buffer[];

int handle_1;
int handle_2;
int handle_3;
int handle_4;

int     handle_sar;
double  sarArray[];

//--- Envelope

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
    
   SetIndexBuffer(0,Label1Buffer,INDICATOR_DATA); // h1
   SetIndexBuffer(1,Label2Buffer,INDICATOR_DATA); // h2
   SetIndexBuffer(2,Label3Buffer,INDICATOR_DATA); // h3
   SetIndexBuffer(3,Label4Buffer,INDICATOR_DATA); // Venda
   SetIndexBuffer(4,Label5Buffer,INDICATOR_DATA); // Compra
   SetIndexBuffer(5,Label6Buffer,INDICATOR_DATA); // 
   SetIndexBuffer(6,Label7Buffer,INDICATOR_DATA); // sup
   SetIndexBuffer(7,Label8Buffer,INDICATOR_DATA); // inf
   SetIndexBuffer(8,Label9Buffer,INDICATOR_DATA);
   SetIndexBuffer(9,sarArray, INDICATOR_DATA);
   
   handle_1 = iMA(_Symbol,_Period,3,0,    MODE_EMA,   PRICE_MEDIAN); // media Rapida
   handle_2 = iMA(_Symbol,_Period,4,0,    MODE_EMA,   PRICE_MEDIAN); // media central 
   handle_3 = iMA(_Symbol,_Period,6,0,    MODE_EMA,   PRICE_MEDIAN); // media lenta
   handle_4 = iMA(_Symbol,_Period,30,0,    MODE_EMA,   PRICE_MEDIAN); // media Super lenta
   
   handle_sar = iSAR(_Symbol,_Period,0.02,0.4);
   
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
//--- Inicio
 


   CopyBuffer(handle_sar,0,0,rates_total,sarArray);
   
   CopyBuffer(handle_1,0,0,rates_total,Label1Buffer);
   CopyBuffer(handle_2 ,0,0,rates_total,Label2Buffer);
   CopyBuffer(handle_3 ,0,0,rates_total,Label3Buffer);
   CopyBuffer(handle_4 ,0,0,rates_total,Label6Buffer);



   for(int i=3;i<rates_total;i++)
     {
     
           double angulo = (MathArctan(Label1Buffer[i] - Label1Buffer[i-1]))*(180/PI);
           Label9Buffer[i] = angulo;
           double angulo_medio1 = (MathArctan(((high[i] + low[i])/2) - ((high[i-1] + low[i-1])/2)))*(180/PI);
             // envelopes
             Label7Buffer[i] = Label6Buffer[i]+30;// Sup
             Label8Buffer[i] = Label6Buffer[i]-40;// Inf        
           // teste de reversao
           //---  Vendas
           if(Label1Buffer[i] < Label2Buffer[i] && Label2Buffer[i] < Label3Buffer[i] )
             {
                  Label4Buffer[i] = high[i];
                  //--- Envelopes
                  if(high[i] < Label7Buffer[i] && low[i] > Label8Buffer[i])
                    {
                        Label4Buffer[i] = 0;
                    }     
                  if(high[i] < Label7Buffer[i])
                    {
                        Label4Buffer[i] = 0;
                    }
                  //--- Conssolidacao
                  
             }
                
            else
              {
                  Label4Buffer[i] = 0;
              }
              if( angulo_medio1 < 0 && Label9Buffer[i-1] > 0)
                    {
                        Label4Buffer[i] = high[i];
                        if(high[i] < Label7Buffer[i] && low[i] > Label8Buffer[i])
                        {
                            Label4Buffer[i] = 0;
                        } 
                    }
              
              
            //--- Compras
            if(Label1Buffer[i] > Label2Buffer[i] && Label2Buffer[i] > Label3Buffer[i])
              {
                  Label5Buffer[i] = low[i]; 
                    //--- Envelopes               
                    if(high[i] < Label7Buffer[i] && low[i] > Label8Buffer[i])
                    {
                        Label5Buffer[i] = 0;
                    }
              }else
              if(angulo_medio1 > 0 && Label9Buffer[i-1] < 0)
              {
                   Label5Buffer[i] = low[i];
                   if(high[i] < Label7Buffer[i] && low[i] > Label8Buffer[i])
                    {
                        Label5Buffer[i] = 0;
                    }

              }else
              {
                  Label5Buffer[i] = 0;
              }

                
                
                //--- Sar
                if(sarArray[i] < Label1Buffer[i])
                {
                   Label4Buffer[i] = 0;                   
                }
                
                
                
                if((( Label1Buffer[i] - sarArray[i]) < 80) && (sarArray[i] < Label1Buffer[i]))
                  {
                    Label5Buffer[i] = 0;
                  }      
     }
//--- return value of prev_calculated for next call
   return(rates_total);
}//--- Fim
//+------------------------------------------------------------------+

bool isNewBar()
{
   static datetime last_time = 0;
   
   datetime lastbar_time = (datetime)SeriesInfoInteger(Symbol(),Period(),SERIES_LASTBAR_DATE);
   
   if(last_time==0)
   {
      last_time=lastbar_time;
      return false;
   }
   if(last_time!=lastbar_time)
     {
      last_time=lastbar_time;
      return true;
     }
     return false;
}