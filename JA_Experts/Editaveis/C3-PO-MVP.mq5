//+------------------------------------------------------------------+
//|                                                    C3-PO-MVP.mq5 |
//|                                           Miqueias da S. Miranda |
//|                                             GITHUB AQUI          |
//+------------------------------------------------------------------+
#property copyright "Miqueias da S. Miranda"
#property link      "" // Colocar meu GitHub
#property version   "1.30"


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
// _____ ____ _____ _   _ ____   ___  ____                           |
//| ____/ ___|_   _| | | |  _ \ / _ \/ ___|                          |
//|  _| \___ \ | | | | | | | | | | | \___ \                          |
//| |___ ___) || | | |_| | |_| | |_| |___) |                         |
//|_____|____/ |_|  \___/|____/ \___/|____/                          |
//                                                                   |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|   Ordens comentadas
//+------------------------------------------------------------------+
//
//    ORDER_TYPE_BUY          - Ordem de compra executada a mercado
//    ORDER_TYPE_SELL         - Ordem de venda executada a mercado
//
//    ORDER_TYPE_BUY_LIMIT    - Ordem de compra sera executada se e somente se, o preco for satisfeito
//    ORDER_TYPE_SELL_LIMIT   - Ordem de venda sera executada se e somente se, o preco for satisfeito
//
//    ORDER_TYPE_BUY_STOP     - Uma ordem de compra a mercado sera chamada quando o valor especificado for atingido
//    ORDER_TYPE_SELL_STOP    - Uma ordem de venda a mercado sera chamada quando o valor especificado for atingido
//
//    ORDER_TYPE_BUY_STOP_LIMIT  -
//    ORDER_TYPE_SELL_STOP_LIMIT -
//
//
//    ORDER_FILLING_FOK       - Esta politica de preenchimento sigifica que uma ordem pode ser preenchida somente na quantidade especificada.
//                              Se a quantidade desejada do ativo nao esta disponivel no mercado, a ordem nao sera executada. O volume requerido
//                              pode ser preenchido usando varias ofertas disponiveis no mercado.
//
//    ORDER_FILLING_IOC       - Este modo significa que um negociador concorda em executar uma operação com o volume máximo disponível
//                              no mercado conforme indicado na ordem. No caso do volume integral de uma ordem não puder ser preenchido,
//                              o volume disponível dele será preenchido, e o volume restante será cancelado.
//
//    ORDER_FILLING_RETURN    - Esta política é usada somente para ordens a mercado (ORDER_TYPE_BUY e ORDER_TYPE_SELL), ordens limit e stop limit
//                              (ORDER_TYPE_BUY_LIMIT, ORDER_TYPE_SELL_LIMIT, ORDER_TYPE_BUY_STOP_LIMIT e ORDER_TYPE_SELL_STOP_LIMIT ) e somente
//                              para os ativos com execução a Mercado ou execução em um sistema de negociação externo (Exchange)***. No caso de um
//                              preenchimento parcial, uma ordem a mercado ou do tipo limit com volume remanescente não é cancelada, mas processada posteriormente.
//                              Para a ativação das ordens ORDER_TYPE_BUY_STOP_LIMIT e ORDER_TYPE_SELL_STOP_LIMIT, uma ordem limit correspondente,
//                              ORDER_TYPE_BUY_LIMIT/ORDER_TYPE_SELL_LIMIT com o tipo de execução ORDER_FILLING_RETURN, é criada.
//

//+------------------------------------------------------------------+
//|   Funcoes de grafico                                             |
//+------------------------------------------------------------------+
//
//   ChartIndicatorAdd();     -
//   ChartIndicatorName();    - Retorna uma string
//   ChartIndicatorsTotal();  - retorna o total de indicadores em uma janela
//   ChartIndicatorDelete();  -
//

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//   >>> ENUM_BOOK_TYPE
//
//   BOOK_TYPE_BUY            - Ordem de compra
//   BOOK_TYPE_SELL           - Ordem de venda
//   BOOK_TYPE_BUY_MARKET     - Ordem de compra
//   BOOK_TYPE_SELL_MARKET    - Ordem de venda
//

//+------------------------------------------------------------------+
//|   ENUM_DEAL_TYPE                                                 |
//+------------------------------------------------------------------+
//
//   DEAL_TYPE_BUY
//   DEAL_TYPE_SELL
//   DEAL_TYPE_BALANCE
//   DEAL_TYPE_CREDIT
//   DEAL_TYPE_CHARGE
//   DEAL_TYPE_CORRECTION
//   DEAL_TYPE_BONUS
//   DEAL_TYPE_COMMISSION
//

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//   << Funcao - PositionGetInteger() >>
//
//   ENUM_POSITION_PROPERTY_INTEGER  - ENUMERADOR
//
//
//
//   INDENTIFICADOR          DESCRICAO                                                                                             TIPO
//
//   POSITION_TICKET      -  Bilhete da posicao. Um numero exclusivo atribuido a cada posicao. Geralmente, ele                   - long
//                           corresponde ao bilhete da ordem, segundo o qual a posicao foi aberta, exeto nos casos em
//                           que as operacoes de servico no servidor tenham alterado o bilhete da ordem. Por exemplo,
//                           quando os swaps se acumulam com reabertura de uma posicao. Para localizar a ordem,
//                           segundo a qual foi aberta a posicao, voce deve utilizar a propriedade POSITION_IDENTIFIER.
//                           O valor da POSITION_TICKET corresponde a MqlTradeRequest::position.
//
//   POSITION_TIME        -  Hora de abertura de uma  posicao                                                                    - datetime
//
//   POSITION_TIME_MSC    -  Posicao de tempo de abertura em milisegundos desde 01.01.1970                                       - long
//
//   POSITION_TIME_UPDATE -  Posicao de tempo de alteracao em segundos desde 01.01.1970                                          - long
//
//   POSITION_TIME_UPDATE_MSC - Posicao de alteracao em milisegundos desde 01.01.1970                                            - long
//
//   POSITION_TYPE        -  Tipo de posicao                                                                                     - ENUM_POSITION_TYPE
//
//   POSITION_MAGIC       -  Numero magico de uma posicao (veja ORDER_MAGIC)                                                     - long
//
//   POSITION_IDENTIFIER  -  Identificador de posicao e um numero unico que e atribuido para toda nova posicao aberta e nao      -
//                           se altera durante todo o tempo de vida da posicao. Movimentacoes de uma posicao nao alteram seu
//                           identificador.
//
//                           O identificador de posicao e indicado em cada ordem (ORDER_POSITION_ID) e transacao
//                           usada para abrir, alterar ou fecha-la. Utilize esta propriedade para procurar ordens e transacoes
//                           associadas com a posicao.
//
//                           Durante a reversao de uma posicao no modo de compensacao (usando uma unica transacao de
//                           saida/entrada) o identificador de posicao POSITION_IDENTIFIER nao e alterado. No entanto, o
//                           POSITION_TICKET e substituido pelo bilhete de ordem, que levou a reversao. No modo de
//                           cobertura, nao e fornecida a reversao de posicao.
//
//   POSITION_REASON      -  Razao para abertura da posicao.
//

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//   <<Funcao - ObjectCreate() >>
//
//   OBJ_VLINE   -  Linha Vertical
//
//      OBJPROP_RAY -  Renderizar linha vertical em todas as janelas.

//+------------------------------------------------------------------+
//|  FECHAMENTO DO BLOCO DE ESTUDOS                                  |
//+------------------------------------------------------------------+

#include       <Trade\Trade.mqh>
#include       "..\\INCLUDES\\CV-ActionLines.mqh"
#include       "..\\INCLUDES\\CV-HLine.mqh"
#include       "..\\INCLUDES\\CV-POO.mqh"
#include       "..\\INCLUDES\\CV-TRADE.mqh"

#define     ACTION_LINE 0

CVActionLine   precos[20];
CvHLine        lines[20];
CVCouter       contador;

MqlTick        ultimoTick;
int            passo;
bool init      = false;
input bool mostrar = true;


//+------------------------------------------------------------------+
//| INICIALIZA OS DADOS INICIAIS                                     |
//+------------------------------------------------------------------+
int OnInit()
{

   contador.vazio       = true;
   contador.qtd         = 0;
   
   return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{

   for(int i = 0; i < 20; i++) {
      ObjectDelete(0, lines[i].GetName());
   }
}
//---
//+------------------------------------------------------------------+
//|  FUNCAO PRINCIPAL DO PROGRAMA                                    |
//+------------------------------------------------------------------+
void OnTick()
{
   SymbolInfoTick(_Symbol, ultimoTick);
   int amp = 10;
   if(!init) {
      int range = 4;
      double price = ultimoTick.last;
      int i;
      for(i = 0; i < 20; i++) {
         passo = (range - i);
         precos[i].active  = false;
         precos[i].name    = "Action-";
         precos[i].id      = i;
         precos[i].price   = price + (amp * passo);                
      }
      
      init = true;
   }
//+------------------------------------------------------------------+
//| Inplemeetacao do Apontador                                       |
//+------------------------------------------------------------------+
   if(mostrar) {
      for(int i = 0; i < 20; i++) {
         string name = precos[i].name +"-"+ IntegerToString(i);
         lines[i].Load( name, precos[i].price, clrGray);
      }
   }
}
//---



//+------------------------------------------------------------------+
