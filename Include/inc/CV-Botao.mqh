//+------------------------------------------------------------------+
//|                                                     CV-Botao.mqh |
//|                                           Miqueias da S. Miranda |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "https://www.mql5.com"


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CvBotao
{
public:
   void              Load( string nome,
                           int xx,
                           int yy,
                           int largura,
                           int altura,
                           ENUM_BASE_CORNER canto,
                           int tamanho,
                           string fonte,
                           string texto,
                           color corTexto,
                           color corFundo,
                           color corBorda,
                           bool fundo,
                           bool oculto,
                           bool selecionavel,
                           string dica = NULL);
};


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CvBotao::Load( string nome,
                    int xx,
                    int yy,
                    int largura,
                    int altura,
                    ENUM_BASE_CORNER canto,
                    int tamanho,
                    string fonte,
                    string texto,
                    color corTexto,
                    color corFundo,
                    color corBorda,
                    bool fundo,
                    bool oculto,
                    bool selecionavel,
                    string dica = NULL)
{
   ObjectCreate      (0, nome, OBJ_BUTTON, 0, 0, 0);
   ObjectSetInteger  (0, nome, OBJPROP_XDISTANCE, xx);
   ObjectSetInteger  (0, nome, OBJPROP_YDISTANCE, yy);
   ObjectSetInteger  (0, nome, OBJPROP_XSIZE, largura);
   ObjectSetInteger  (0, nome, OBJPROP_YSIZE, altura);
   ObjectSetInteger  (0, nome, OBJPROP_CORNER, canto);
   ObjectSetInteger  (0, nome, OBJPROP_FONTSIZE, tamanho);
   ObjectSetInteger  (0, nome, OBJPROP_COLOR, corTexto);
   ObjectSetInteger  (0, nome, OBJPROP_BGCOLOR, corFundo);
   ObjectSetInteger  (0, nome, OBJPROP_BORDER_COLOR, corBorda);
   ObjectSetInteger  (0, nome, OBJPROP_BACK, fundo);
   ObjectSetInteger  (0, nome, OBJPROP_HIDDEN, oculto);
   ObjectSetInteger  (0, nome, OBJPROP_SELECTABLE, selecionavel);
   ObjectSetInteger  (0, nome, OBJPROP_STATE, false);
   ObjectSetString   (0, nome, OBJPROP_FONT, fonte);
   ObjectSetString   (0, nome, OBJPROP_TEXT, texto);
   ObjectSetString   (0, nome, OBJPROP_TOOLTIP, dica);

}

//---