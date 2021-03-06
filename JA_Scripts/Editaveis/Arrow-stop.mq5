//--- descrição
#property description "Script desenha sinal\"Stop\"."
#property description "Coordenadas do ponto de ancoragem é definido em"
#property description "porcentagem do tamanho da janela de gráfico."
//--- janela de exibição dos parâmetros de entrada durante inicialização do script
#property script_show_inputs
//--- entrada de parâmetros do script
input string            InpName="ArrowStop";     // Nome do sinal
input int               InpDate=10;              // Ponto de ancoragem da data em %
input int               InpPrice=50;             // Ponto de ancoragem do preço em %
input ENUM_ARROW_ANCHOR InpAnchor=ANCHOR_BOTTOM; // Tipo de ancoragem
input color             InpColor=clrRed;         // Cor do sinal
input ENUM_LINE_STYLE   InpStyle=STYLE_DOT;      // Estilo de linha da borda
input int               InpWidth=5;              // Tamanho do Sinal
input bool              InpBack=false;           // Fundo do sinal
input bool              InpSelection=false;      // Destaque para mover
input bool              InpHidden=true;          // Ocultar na lista de objetos
input long              InpZOrder=0;             // Prioridade para clique do mouse



bool ArrowStopCreate(const long              chart_ID=0,           // ID do gráfico
                     const string            name="ArrowStop",     // nome do sinal
                     const int               sub_window=0,         // índice da sub-janela
                     datetime                time=0,               // ponto de ancoragem do tempo
                     double                  price=0,              // ponto de ancoragem do preço
                     const ENUM_ARROW_ANCHOR anchor=ANCHOR_BOTTOM, // tipo de ancoragem
                     const color             clr=clrRed,           // cor do sinal
                     const ENUM_LINE_STYLE   style=STYLE_SOLID,    // estilo da linha da borda
                     const int               width=3,              // tamanho do sinal
                     const bool              back=false,           // no fundo
                     const bool              selection=true,       // destaque para mover
                     const bool              hidden=true,          // Ocultar na lista de objetos
                     const long              z_order=0)            // prioridade para clicar no mouse
  {


   ChangeArrowEmptyPoint(time,price);
   ResetLastError();
   if(!ObjectCreate(chart_ID,name,OBJ_ARROW_STOP,sub_window,time,price))
     {
      Print(__FUNCTION__,
            ": falha ao criar o sinal\"Stop\"! Código de erro = ",GetLastError());
      return(false);
     }
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);

   return(true);
  }
  
  
//+------------------------------------------------------------------+
//| Mover ponto de ancoragem                                         |
//+------------------------------------------------------------------+
bool ArrowStopMove(const long   chart_ID=0,       // ID do gráfico
                   const string name="ArrowStop", // nome do objeto
                   datetime     time=0,           // coordenada do ponto de ancoragem de tempo
                   double       price=0)          // coordenada do ponto de ancoragem de preço
  {

   if(!time)    time=TimeCurrent();
   if(!price)   price=SymbolInfoDouble(Symbol(),SYMBOL_BID);
   ResetLastError();

   if(!ObjectMove(chart_ID,name,0,time,price))
     {
      Print(__FUNCTION__,
            ": falha ao mover o ponto de ancoragem! Código de erro = ",GetLastError());
      return(false);
     }
   return(true);
  }
  
bool ArrowStopAnchorChange(const long              chart_ID=0,        // ID do gráfico
                           const string            name="ArrowStop",  // nome do objeto
                           const ENUM_ARROW_ANCHOR anchor=ANCHOR_TOP) // posição do ponto de ancoragem
  {
   ResetLastError();
   if(!ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor))
     {
      Print(__FUNCTION__,
            ": falha para alterar o tipo de ancoragem! Código de erro = ",GetLastError());
      return(false);
     }
   return(true);
  }
  
//+------------------------------------------------------------------+
//| Excluir sinal Stop                                               |
//+------------------------------------------------------------------+
bool ArrowStopDelete(const long   chart_ID=0,       // ID do gráfico
                     const string name="ArrowStop") // nome da etiqueta
  {

   ResetLastError();
   if(!ObjectDelete(chart_ID,name))
     {
      Print(__FUNCTION__,
            ": falha ao excluir o sinal \"Stop\"! Código de erro = ",GetLastError());
      return(false);
     }
   return(true);
  }
  
//+------------------------------------------------------------------+
//| Verificar valores de ponto de ancoragem e definir valores padrão |
//| para aqueles vazios                                              |
//+------------------------------------------------------------------+

void ChangeArrowEmptyPoint(datetime &time,double &price)
  {

   if(!time)    time=TimeCurrent(); //--- se o tempo do ponto não está definido, será na barra atual
   if(!price)   price=SymbolInfoDouble(Symbol(),SYMBOL_BID);//--- se o preço do ponto não está definido, ele terá valor Bid
  }
  
//+------------------------------------------------------------------+
//| Programa Script da função start (iniciar)                        |
//+------------------------------------------------------------------+
void OnStart()
  {
//--- verificar a exatidão dos parâmetros de entrada
   if(InpDate<0 || InpDate>100 || InpPrice<0 || InpPrice>100)
     {
      Print("Erro! Valores incorretos dos parâmetros de entrada!");
      return;
     }
//--- número de barras visíveis na janela do gráfico
   int bars=(int)ChartGetInteger(0,CHART_VISIBLE_BARS);
//--- tamanho do array de preço
   int accuracy=1000;
//--- arrays para armazenar data e valores de preço para serem usados
//--- para definir e alterar sinal das coordenadas do ponto de ancoragem
   datetime date[];
   double   price[];
//--- alocação de memória
   ArrayResize(date,bars);
   ArrayResize(price,accuracy);
//--- preencher o array das datas
   ResetLastError();
   if(CopyTime(Symbol(),Period(),0,bars,date)==-1)
     {
      Print("Falha ao copiar valores de tempo! Código de erro = ",GetLastError());
      return;
     }
    double max_price=ChartGetDouble(0,CHART_PRICE_MAX);
    double min_price=ChartGetDouble(0,CHART_PRICE_MIN);

   double step=(max_price-min_price)/accuracy;
   for(int i=0;i<accuracy;i++)  price[i]=min_price+i*step;

   int d=InpDate*(bars-1)/100;
   int p=InpPrice*(accuracy-1)/100;
   
   if(!ArrowStopCreate(0,InpName,0,date[d],price[p],InpAnchor,InpColor,
      InpStyle,InpWidth,InpBack,InpSelection,InpHidden,InpZOrder))
     {
      return;
     }

   ChartRedraw();
   Sleep(1000);


   int h_steps=bars*2/5;

   for(int i=0;i<h_steps;i++)
     {
      //--- usar o seguinte valor
      if(d<bars-1)
         d+=1;
      //--- mover o ponto
      if(!ArrowStopMove(0,InpName,date[d],price[p]))
         return;
      //--- verificar se o funcionamento do script foi desativado a força
      if(IsStopped())
         return;
      //--- redesenhar o gráfico
      ChartRedraw();
      // 0.025 segundos de atraso
      Sleep(25);
     }
//--- alterar a localização do ponto de ancoragem relativa ao sinal
   ArrowStopAnchorChange(0,InpName,ANCHOR_TOP);
//--- redesenhar o gráfico
   ChartRedraw();
//--- contador de loop
   h_steps=bars*2/5;
//--- mover o ponto de ancoragem
   for(int i=0;i<h_steps;i++)
     {
      //--- usar o seguinte valor
      if(d<bars-1)
         d+=1;
      //--- mover o ponto
      if(!ArrowStopMove(0,InpName,date[d],price[p]))
         return;
      //--- verificar se o funcionamento do script foi desativado a força
      if(IsStopped())
         return;
      //--- redesenhar o gráfico
      ChartRedraw();
      // 0.025 segundos de atraso
      Sleep(25);
     }
//--- 1 segundo de atraso
   Sleep(1000);
//--- deletar o sinal do gráfico
   ArrowStopDelete(0,InpName);
   ChartRedraw();
//--- 1 segundo de atraso
   Sleep(1000);
//---
  }