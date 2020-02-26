//+------------------------------------------------------------------+
//|                                                     CV-HLine.mqh |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CvHLine
{
protected:
   string            cv_name;
   double            cv_price;
   color             cv_corBase;
public:
   void              Load( string name, double price, color corBase);
   void              Move(double price);
   string            GetName()
   {
      return cv_name;
   };
   void              Delete();
   void              Color(color cor);
};

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CvHLine::Color(color cor)
{
   ObjectSetInteger(0, cv_name, OBJPROP_COLOR, cor);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CvHLine::Load(   string name,
                      double price,
                      color corBase
                  )
{
   cv_name     = name + "line";
   ObjectCreate      (0, name + "line", OBJ_HLINE, 0, 0, price);
   ObjectSetInteger  (0, name + "line", OBJPROP_COLOR,  corBase);
   ObjectSetInteger  (0, name + "line", OBJPROP_STYLE, STYLE_DASHDOTDOT);
   ObjectSetInteger  (0, name + "line", OBJPROP_WIDTH, 1);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CvHLine::Move(double price)
{
   cv_price = price;
   ObjectMove(0, cv_name, 0, 0, price);
}


void CvHLine::Delete(void)
{
   ObjectDelete(0,cv_name);
}
//+------------------------------------------------------------------+
