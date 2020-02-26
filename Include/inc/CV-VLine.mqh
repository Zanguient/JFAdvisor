//+------------------------------------------------------------------+
//|                                                     CV-VLine.mqh |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"




//+------------------------------------------------------------------+
//|  CvVLine                                                         |
//+------------------------------------------------------------------+
class CvVLine
{
protected:
   string            name;
   datetime          time;
public:
   void              Load( string name,
                           datetime time
                         );
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Load(   string   name,
             datetime time
         )
{

   ObjectCreate      (0, name, OBJ_VLINE, 0, time, 0);
   ObjectSetInteger  (0, name, OBJPROP_RAY, true);
   ObjectSetInteger  (0, name, OBJPROP_STYLE, STYLE_DASHDOTDOT);
   ObjectSetInteger  (0, name, OBJPROP_WIDTH, 2);

}
//---

