//+------------------------------------------------------------------+
//|                                                 TickColorCandles |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Denis Zyatkevich"
#property description "The indicator plots the 'Tick Candles'"
#property version   "1.00"




// O indicador é plotado em uma janela separada
#property indicator_separate_window
// Uma plotagem gráfica é usada, velas coloridas
#property indicator_plots 1
// Precisamos de 4 buffers para os preços da OHLC e um - para o índice de cores
#property indicator_buffers 5
// Especificando o tipo de desenho - velas coloridas
#property indicator_type1 DRAW_COLOR_CANDLES
// Especificando as cores para as velas
#property indicator_color1 clrGray,clrRed, clrGreen


// Declaração da enumeração
enum price_types {
   Bid,
   Ask
};

// A variável de entrada ticks_in_candle especifica o número de ticks,
// correspondente a uma vela
input int ticks_in_candle = 16; //Contagem de carrapatos em velas

// A variável de entrada preço_específico do tipo price_types indica
// o tipo de dados usado no indicador: preços de compra ou venda.
input price_types applied_price = 0; // Preço

// A variável de entrada path_prefix especifica o caminho e o prefixo do nome do arquivo
input string path_prefix = ""; // Prefixo FileName

// A variável ticks_stored contém o número de cotações armazenadas
int ticks_stored;

// A matriz TicksBuffer[] é usada para armazenar os preços recebidos
double TicksBuffer[];

// As matrizes OpenBuffer [], HighBuffer [], LowBuffer [] e CloseBuffer []
// são usados ​​para armazenar os preços OHLC das velas
double OpenBuffer[];
double HighBuffer[];
double LowBuffer[];
double CloseBuffer[];

// A matriz ColorIndexBuffer[] é usada para armazenar o índice de velas coloridas
double ColorIndexBuffer[];

//+------------------------------------------------------------------+
//| Indicator initialization function                                |
//+------------------------------------------------------------------+
void OnInit()
{

// A matriz OpenBuffer [] é um buffer indicador
   SetIndexBuffer(0, OpenBuffer, INDICATOR_DATA);
// A matriz HighBuffer [] é um buffer indicador
   SetIndexBuffer(1, HighBuffer, INDICATOR_DATA);
// A matriz LowBuffer [] é um buffer indicador
   SetIndexBuffer(2, LowBuffer, INDICATOR_DATA);
// A matriz CloseBuffer [] é um buffer indicador
   SetIndexBuffer(3, CloseBuffer, INDICATOR_DATA);
// A matriz ColorIndexBuffer [] é o buffer do índice de cores
   SetIndexBuffer(4, ColorIndexBuffer, INDICATOR_COLOR_INDEX);
// A matriz TicksBuffer [] é usada para cálculos intermediários
   SetIndexBuffer(5, TicksBuffer, INDICATOR_CALCULATIONS);


// A indexação da matriz OpenBuffer [] como séries temporais
   ArraySetAsSeries(OpenBuffer, true);
// A indexação da matriz HighBuffer [] como séries temporais
   ArraySetAsSeries(HighBuffer, true);
// A indexação da matriz LowBuffer [] como séries temporais
   ArraySetAsSeries(LowBuffer, true);
// A indexação da matriz CloseBuffer [] como séries temporais
   ArraySetAsSeries(CloseBuffer, true);
// A indexação da matriz ColorIndexBuffer [] como séries temporais
   ArraySetAsSeries(ColorIndexBuffer, true);
   
// Os valores nulos dos preços em aberto (0º gráfico) não devem ser plotados
   PlotIndexSetDouble(0, PLOT_EMPTY_VALUE, 0);
// Os valores nulos de preços altos (1º gráfico) não devem ser plotados
   PlotIndexSetDouble(1, PLOT_EMPTY_VALUE, 0);
// Os valores nulos de Preços baixos (2º gráfico) não devem ser plotados
   PlotIndexSetDouble(2, PLOT_EMPTY_VALUE, 0);
// Os valores nulos dos preços de fechamento (terceiro gráfico) não devem ser plotados
   PlotIndexSetDouble(3, PLOT_EMPTY_VALUE, 0);
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
// a variável file_handle é um identificador de arquivo
   int file_handle;

// BidPosition e AskPosition - são posições dos preços Bid e Ask na string;
   int BidPosition;
   int AskPosition;

// o line_string_len é o comprimento de uma string, lida no arquivo,
   int line_string_len;

// CandleNumber - número de velas para as quais os preços OHLC são determinados,
   int CandleNumber;

// i - contador de loop;
   int i;

// A variável last_price_bid é o preço de lance recebido recente
   double last_price_bid = SymbolInfoDouble(Symbol(), SYMBOL_BID);

// A variável last_price_ask é o preço de venda recebido recentemente
   double last_price_ask = SymbolInfoDouble(Symbol(), SYMBOL_ASK);

// o nome do arquivo é o nome de um arquivo, o file_buffer é uma sequência,
// usado como um buffer para leitura e gravação de dados de string
   string filename, file_buffer;
   
// Definindo o tamanho da matriz TicksBuffer []
   ArrayResize(TicksBuffer, ArraySize(CloseBuffer));
   
// Formação do nome do arquivo a partir da variável path_prefix, name
// do instrumento financeiro e símbolos ".txt"
   StringConcatenate(filename, path_prefix, Symbol(), ".txt");

// Abrindo um arquivo para leitura e gravação, 
// página de código ANSI, modo de leitura compartilhada
   file_handle = FileOpen(filename, FILE_READ | FILE_WRITE | FILE_ANSI | FILE_SHARE_READ);
   if(prev_calculated == 0) {
      
      // Lendo a primeira linha do arquivo e determinando o comprimento de uma string
      line_string_len = StringLen(FileReadString(file_handle)) + 2;
      // se o arquivo for grande (contém mais aspas que rates_total / 2)
      if(FileSize(file_handle) > (ulong)line_string_len * rates_total / 2) {
         // Configurando o ponteiro do arquivo para ler as últimas cotações rates_total / 2
         FileSeek(file_handle, -line_string_len * rates_total / 2, SEEK_END);
         // Movendo o ponteiro do arquivo para o início da próxima linha
         FileReadString(file_handle);
      }
      // se o tamanho do arquivo for pequeno
      else {
         // Movendo o ponteiro do arquivo no início de um arquivo
         FileSeek(file_handle, 0, SEEK_SET);
      }
      // Redefinir o contador de cotações armazenadas
      ticks_stored = 0;
      // Lendo até o final do arquivo
      while(FileIsEnding(file_handle) == false) {
         // Lendo uma string do arquivo
         file_buffer = FileReadString(file_handle);
         // Processamento de sequência se seu comprimento for maior que 6 caracteres
         if(StringLen(file_buffer) > 6) {
            // Localizando a posição inicial do preço do lance na linha
            BidPosition = StringFind(file_buffer, " ", StringFind(file_buffer, " ") + 1) + 1;
            // Encontrando a posição inicial do preço Ask na linha
            AskPosition = StringFind(file_buffer, " ", BidPosition) + 1;
            // Se os preços dos lances forem usados, adicionar o preço do lance à matriz TicksBuffer []
            if(applied_price == 0) TicksBuffer[ticks_stored] = StringToDouble(StringSubstr(file_buffer, BidPosition, AskPosition - BidPosition - 1));
            // Se os preços Ask forem usados, adicione o preço Ask ao array TicksBuffer []
            if(applied_price == 1) TicksBuffer[ticks_stored] = StringToDouble(StringSubstr(file_buffer, AskPosition));
            // Aumentando o contador de cotações armazenadas
            ticks_stored++;
         }
      }
   }
// Se os dados foram lidos antes
   else {
      // Movendo o ponteiro do arquivo no final do arquivo
      FileSeek(file_handle, 0, SEEK_END);
      // Formando uma string, que deve ser gravada no arquivo
      StringConcatenate(file_buffer, TimeCurrent(), " ", DoubleToString(last_price_bid, _Digits), " ", DoubleToString(last_price_ask, _Digits));
      // Escrevendo uma string no arquivo
      FileWrite(file_handle, file_buffer);
      // Se os preços dos lances forem usados, adicione o último preço do lance ao array TicksBuffer []
      if(applied_price == 0) TicksBuffer[ticks_stored] = last_price_bid;
      // Se os preços Ask forem usados, adicione o último preço Ask ao array TicksBuffer []
      if(applied_price == 1) TicksBuffer[ticks_stored] = last_price_ask;
      // Aumentando o contador de cotações
      ticks_stored++;
   }
// Closing the file
   FileClose(file_handle);
// Se o número de aspas for maior ou igual ao número de barras no gráfico
   if(ticks_stored >= rates_total) {
      // Removendo as primeiras cotações tick_stored / 2 e deslocando as cotações restantes
      for(i = ticks_stored / 2; i < ticks_stored; i++) {
         // Mudando os dados para o início na matriz TicksBuffer [] em tick_stored / 2
         TicksBuffer[i - ticks_stored / 2] = TicksBuffer[i];
      }
      // Alterando o contador de cotações
      ticks_stored -= ticks_stored / 2;
   }
// Atribuímos o CandleNumber com um número de velas inválidas
   CandleNumber = -1;
// Pesquise todos os dados de preços disponíveis para a formação de velas
   for(i = 0; i < ticks_stored; i++) {
      // Se esta vela já estiver se formando
      if(CandleNumber == (int)(MathFloor((ticks_stored - 1) / ticks_in_candle) - MathFloor(i / ticks_in_candle))) {
         // A cotação atual ainda está fechando o preço da vela atual
         CloseBuffer[CandleNumber] = TicksBuffer[i];
         // Se o preço atual for maior que o preço mais alto da vela atual, será um novo preço mais alto da vela
         if(TicksBuffer[i] > HighBuffer[CandleNumber]) HighBuffer[CandleNumber] = TicksBuffer[i];
         // Se o preço atual for menor que o preço mais baixo da vela atual, será um novo preço mais baixo da vela
         if(TicksBuffer[i] < LowBuffer[CandleNumber]) LowBuffer[CandleNumber] = TicksBuffer[i];
         // Se a vela for de alta, ela terá uma cor com o índice 2 (verde)
         if(CloseBuffer[CandleNumber] > OpenBuffer[CandleNumber]) ColorIndexBuffer[CandleNumber] = 2;
         // Se a vela for de baixa, ela terá uma cor com o índice 1 (vermelho)
         if(CloseBuffer[CandleNumber] < OpenBuffer[CandleNumber]) ColorIndexBuffer[CandleNumber] = 1;
         // Se os preços de abertura e fechamento forem iguais, a vela terá uma cor com o índice 0 (cinza)
         if(CloseBuffer[CandleNumber] == OpenBuffer[CandleNumber]) ColorIndexBuffer[CandleNumber] = 0;
      }
      // Se esta vela ainda não foi calculada
      else {
         // Vamos determinar o índice de uma vela
         CandleNumber = (int)(MathFloor((ticks_stored - 1) / ticks_in_candle) - MathFloor(i / ticks_in_candle));
         // A cotação atual será o preço de abertura de uma vela
         OpenBuffer[CandleNumber] = TicksBuffer[i];
         // A cotação atual será o preço mais alto de uma vela
         HighBuffer[CandleNumber] = TicksBuffer[i];
         // A cotação atual será o preço mais baixo de uma vela
         LowBuffer[CandleNumber] = TicksBuffer[i];
         // A cotação atual será o preço de fechamento de uma vela
         CloseBuffer[CandleNumber] = TicksBuffer[i];
         // A vela terá uma cor com o índice 0 (cinza)
         ColorIndexBuffer[CandleNumber] = 0;
      }
   }
// Retorne de OnCalculate (), retorne um valor diferente de zero
   return(rates_total);
}
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
