//+------------------------------------------------------------------+
//|                                                  PanelDialog.mqh |
//|                   Copyright 2009-2017, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include <Controls\Dialog.mqh>
#include <Controls\Button.mqh>
#include <Controls\ListView.mqh>
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
//--- indents and gaps
#define INDENT_LEFT                         (11)      // indent from left (with allowance for border width)
#define INDENT_TOP                          (11)      // indent from top (with allowance for border width)
#define INDENT_RIGHT                        (11)      // indent from right (with allowance for border width)
#define INDENT_BOTTOM                       (11)      // indent from bottom (with allowance for border width)
#define CONTROLS_GAP_X                      (10)      // gap by X coordinate
#define CONTROLS_GAP_Y                      (10)      // gap by Y coordinate
//--- for buttons
#define BUTTON_WIDTH                        (100)     // size by X coordinate
#define BUTTON_HEIGHT                       (20)      // size by Y coordinate
//--- for the indication area
#define EDIT_HEIGHT                         (20)      // size by Y coordinate
//+------------------------------------------------------------------+
//| Class CPanelDialog                                               |
//| Usage: main dialog of the SimplePanel application                |
//+------------------------------------------------------------------+
class CPanelDialog : public CAppDialog
  {
private:
   CButton           m_button1;                       // the button object
   CListView         m_list_view;                     // the list object
public:
                     CPanelDialog(void);
                    ~CPanelDialog(void);
   string            GetButtonName() {return m_button1.Name();}   
   long              GetStratID()    {return m_list_view.Value();}  
   string            GetStratName()  {return m_list_view.Select();}  
   
   void              AddStrategy(string name_strat, int ids) {m_list_view.AddItem(name_strat, ids);}               
   //--- create
   virtual bool      Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2);
   //--- chart event handler
   virtual bool      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);

protected:
   //--- create dependent controls
   bool              CreateButton1(void);
   bool              CreateListView(void);
   //--- handlers of the dependent controls events
  };
//+------------------------------------------------------------------+
//| Event Handling                                                   |
//+------------------------------------------------------------------+

EVENT_MAP_BEGIN(CPanelDialog)
EVENT_MAP_END(CAppDialog)

CPanelDialog::CPanelDialog(void)
  {
  }
CPanelDialog::~CPanelDialog(void)
  {
  }
bool CPanelDialog::Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2)
  {
   if(!CAppDialog::Create(chart,name,subwin,x1,y1,x2,y2))
      return(false);
   if(!CreateButton1())    return(false);
   if(!CreateListView())   return(false);
   return(true);
  }
bool CPanelDialog::CreateButton1(void)
  {
   int x1=ClientAreaWidth()-(INDENT_RIGHT+BUTTON_WIDTH);
   int y1=INDENT_TOP;
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
   if(!m_button1.Create(m_chart_id,m_name+"Applay",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_button1.Text("Applay"))
      return(false);
   if(!Add(m_button1))
      return(false);
   m_button1.Alignment(WND_ALIGN_RIGHT,0,0,INDENT_RIGHT,0); 
   Print("name: ",m_button1.Name()," ",CHARTEVENT_OBJECT_CLICK);
   return(true);
  }

//+------------------------------------------------------------------+
//| Create the "ListView" element                                    |
//+------------------------------------------------------------------+
bool CPanelDialog::CreateListView(void)
  {
   int sx=(ClientAreaWidth()-(INDENT_LEFT+INDENT_RIGHT+BUTTON_WIDTH))/3-CONTROLS_GAP_X;
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP;
   int x2=ClientAreaWidth()-(INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X);;//x1+sx;
   int y2=ClientAreaHeight()-INDENT_BOTTOM;
   if(!m_list_view.Create(m_chart_id,m_name+"ListView",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!Add(m_list_view))
      return(false);
   m_list_view.Alignment(WND_ALIGN_HEIGHT,0,y1,0,INDENT_BOTTOM);
   return(true);
  }
