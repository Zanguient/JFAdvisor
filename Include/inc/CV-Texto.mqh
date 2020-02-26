//+------------------------------------------------------------------+
//|                                                     CV-Texto.mqh |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CvTexto
{
protected:
   string            ob_nome;
   int               ob_xx;
   int               ob_yy;
   ENUM_BASE_CORNER  ob_canto;
   ENUM_ANCHOR_POINT ob_ancora;
   int               ob_tamanho;
   string            ob_fonte;
   string            ob_texto;
   color             ob_cor;
   bool              ob_fundo;
   bool              ob_oculto;

public:
   void              Load(string nome,
                          int xx,
                          int yy,
                          ENUM_BASE_CORNER canto,
                          ENUM_ANCHOR_POINT ancora,
                          int tamanho,
                          string fonte,
                          string texto,
                          color cor,
                          bool fundo,
                          bool oculto
                         );
   void              Texto(string texto);
   void              Tamanho(int tamanho);
};

//+------------------------------------------------------------------+
//| Load Texto                                                       |
//+------------------------------------------------------------------+
void CvTexto::Load(  string nome,
                     int xx,
                     int yy,
                     ENUM_BASE_CORNER canto,
                     ENUM_ANCHOR_POINT ancora,
                     int tamanho,
                     string fonte,
                     string texto,
                     color cor,
                     bool fundo,
                     bool oculto)
{
   ObjectCreate      (0, nome, OBJ_LABEL, 0, 0, 0);
   ObjectSetInteger  (0, nome, OBJPROP_XDISTANCE, xx);
   ObjectSetInteger  (0, nome, OBJPROP_YDISTANCE, yy);
   ObjectSetInteger  (0, nome, OBJPROP_CORNER, canto);
   ObjectSetInteger  (0, nome, OBJPROP_ANCHOR, ancora);
   ObjectSetInteger  (0, nome, OBJPROP_FONTSIZE, tamanho);
   ObjectSetString   (0, nome, OBJPROP_FONT, fonte);
   ObjectSetString   (0, nome, OBJPROP_TEXT, texto);
   ObjectSetInteger  (0, nome, OBJPROP_COLOR, cor);
   ObjectSetInteger  (0, nome, OBJPROP_BACK, fundo);
   ObjectSetInteger  (0, nome, OBJPROP_HIDDEN, oculto);
}

