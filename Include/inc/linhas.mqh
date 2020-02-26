//+------------------------------------------------------------------+
//|                                                       linhas.mqh |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"

bool criaLinha(

)
{       
        if(!ObjectCreate(symbol,nome,OBJ_HLINE,0,0,0))
          {
           Print(
            "Falha em criar linha! Codigo do erro = ", GetLastError());
           return(false);
          }
        ObjectSetInteger(symbol,nome,OBJPROP_COLOR,clr);
        ObjectSetInteger(symbol,nome,OBJPROP_WIDTH, 1);
        ObjectSetInteger(symbol,nome,OBJPROP_STYLE, STYLE_DASHDOTDOT);
        return true;   
}


bool movLinha(
        long    symbol=0,
        string  nome = "HLine",
        double  price=0
)
{
    ResetLastError();
    
    if(!ObjectMove(symbol,nome,0,0,price))
      {
        Print(__FUNCTION__,
            "falha ao mover a  linha horizontal! Codigo do erro = ", GetLastError());
        return(false);
      }
      return (true);
}