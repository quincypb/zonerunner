/*
//+------------------------------------------------------------------+
//|                                              LearnCAppDialog.mq5 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <Controls\Dialog.mqh>



CAppDialog AppWindow;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {

//--- create application dialog
   if(!AppWindow.Create(0,"Zone Comfirmation Entry",0,20,20,360,324))

      return(INIT_FAILED);

//--- run application
   AppWindow.Run();
//--- succeed
   return(INIT_SUCCEEDED);


  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy dialog
   AppWindow.Destroy(reason);
  }
//+------------------------------------------------------------------+
//| Expert chart event function                                      |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,         // event ID
                  const long& lparam,   // event parameter of the long type
                  const double& dparam, // event parameter of the double type
                  const string& sparam) // event parameter of the string type
  {
   AppWindow.ChartEvent(id,lparam,dparam,sparam);
  }
//+------------------------------------------------------------------+
*/



























//+------------------------------------------------------------------+
//|                                                   ZoneRunner.mq5 |
//|                 Copyright 2023, Black Wall Street Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Black Wall Street Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property description "Supply and Demand Automated Comfrimation Entry"

//--- display window of the input parameters during the script's launch
//#property script_show_inputs

#include <Controls\Dialog.mqh>
#include <Controls\Button.mqh>
#include <Controls\Edit.mqh>
#include <Controls\Label.mqh>
#include <Trade\Trade.mqh>

CTrade trade;

//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
//--- indents and gaps
#define INDENT_LEFT                         (11)      // indent from left (with allowance for border width)
#define INDENT_TOP                          (11)      // indent from top (with allowance for border width)
#define INDENT_RIGHT                        (11)      // indent from right (with allowance for border width)
#define INDENT_BOTTOM                       (11)      // indent from bottom (with allowance for border width)
#define CONTROLS_GAP_X                      (5)       // gap by X coordinate
#define CONTROLS_GAP_Y                      (5)       // gap by Y coordinate
//--- for buttons
#define BUTTON_WIDTH                        (100)     // size by X coordinate
#define BUTTON_HEIGHT                       (20)      // size by Y coordinate
//--- for the indication area
#define EDIT_HEIGHT                         (20)      // size by Y coordinate
//--- for group controls
#define GROUP_WIDTH                         (150)     // size by X coordinate
#define LIST_HEIGHT                         (179)     // size by Y coordinate
#define RADIO_HEIGHT                        (56)      // size by Y coordinate
#define CHECK_HEIGHT                        (93)      // size by Y coordinate
//+------------------------------------------------------------------+
//| Class CControlsDialog                                            |
//| Usage: main dialog of the Controls application                   |
//+------------------------------------------------------------------+

CButton           m_button1;                       // the button object //2
CButton           m_button2;                       // the button object //2
CButton           m_button3;                       // the fixed button object //2



//test changin button name test succeed
const string Button2 = "Button2";
const string Button3 = "Button3";
//test end

// CEdit
CEdit             m_edit;    //stuggg
CEdit            m_edit1;    //stufff
CLabel            m_label;    //stuff
CLabel            m_label1;    // CLabel object
CLabel            m_label2;

//current price test    wont know if this works till sunday on market open.
double pricey =SymbolInfoDouble(_Symbol,SYMBOL_LAST);

MqlTick last_tick;
///
//test#1keep
const string           Meditname = "Edits";
const string           TextName     = "0.00000";
string           Demandtxt   = "Demand Zone Detected";
string           Supplytxt   = "Supply Zone Detected";
string           Returntxt   = "Waiting for Comfirmation";
string           Detecttxt   = "";


double    iPriceAmount = 0.00000;  ////highest point
//Test#1endkeep
//test#1keep
const string           Meditname1 = "Edits1";
const string           TextName1     = "0.00000";
double    iPriceAmount1 = 0.00000;  ////Lowest point
//Test#1endkeep

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CControlsDialog : public CAppDialog
  {
   //private:
   // CButton           m_button1;                       // the button object
   // CButton           m_button2;                       // the button object
   //CButton           m_button3;                       // the fixed button object

public:
                     CControlsDialog(void);
                    ~CControlsDialog(void);
   //--- create
   virtual bool      Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2);

protected:
   //--- create dependent controls
   bool              CreatePanel(void);


   //--- create dependent controls
   bool              CreateButton1(void);
   bool              CreateButton2(void);
   bool              CreateButton3(void);
   //--- handlers of the dependent controls events
   void              OnClickButton1(void);
   void              OnClickButton2(void);
   void              OnClickButton3(void);

   //--- create dependent controls
   bool              CreateEdit(void);
   bool              CreateEdit1(void);
   //--- create dependent controls
   bool              CreateLabel(void);
   bool              CreateLabel1(void);
   bool              CreateLabel2(void);

  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CControlsDialog::CControlsDialog(void)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CControlsDialog::~CControlsDialog(void)
  {
  }
//+------------------------------------------------------------------+
//| Create  this is the creation of the window + what goes inside it |
//+------------------------------------------------------------------+
bool CControlsDialog::Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2)
  {
   if(!CAppDialog::Create(chart,"Zone Runner",subwin,x1,y1,x2,y2))
      return(false);
//--- create dependent controls
  // if(!CreatePanel())
  //    return(false);
//--- create dependent controls
   if(!CreateButton1())
      return(false);
   if(!CreateButton2())
      return(false);
   if(!CreateButton3())
      return(false);
//--- create dependent controls
   if(!CreateEdit())
      return(false);
   if(!CreateEdit1())
      return(false);
//--- create dependent controls
   if(!CreateLabel())
      return(false);
   if(!CreateLabel1())
      return(false);
   if(!CreateLabel2())
      return(false);
//--- succeed
   return(true);
  }




//+------------------------------------------------------------------+
//| Create the "CPanel"   this is the shade box                      |
//+------------------------------------------------------------------+
bool CControlsDialog::CreatePanel(void)
  {
//--- coordinates
   int x1=3;
   int y1=231;
   int x2=ClientAreaWidth()-3;
   int y2=235;
//   int x2=ExtDialog.Width()/3;
//   int y2=ExtDialog.Height()/3;
//--- create
   if(!my_white_border.Create(0,ExtDialog.Name()+"MyWhiteBorder",m_subwin,x1,y1,x2,y2))
      return(false);
// if(!my_white_border.ColorBackground(CONTROLS_DIALOG_COLOR_BG))
   if(!my_white_border.ColorBackground(clrDarkGray))
      return(false);
   if(!my_white_border.ColorBorder(CONTROLS_DIALOG_COLOR_BORDER_LIGHT))
      return(false);
   if(!ExtDialog.Add(my_white_border))
      return(false);
   my_white_border.Alignment(WND_ALIGN_CLIENT,0,0,0,0);
//--- succeed
   return(true);
  }

//+------------------------------------------------------------------+
//| Create the display field    edit feild     testing on: Passed    |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateEdit(void)
  {
//--- coordinates
// button 2 config
   int x1=INDENT_LEFT+(BUTTON_WIDTH+CONTROLS_GAP_X);
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;

//1   int x1=INDENT_LEFT;
//1   int y1=INDENT_TOP;
//   int x1=10;
//   int y1=5;
//   int x2 =ExtDialog.Width()/4;
//   int y2 =ExtDialog.Width()/4;
//1   int x2=ClientAreaWidth()-INDENT_RIGHT;
//1   int y2=y1+EDIT_HEIGHT;
//--- create                   //m_name+"Edit"   replaced for test. test was successful. keeping name
   if(!m_edit.Create(m_chart_id,Meditname,m_subwin,x1,y1,x2,y2))
      return(false);
//--- allow editing the content
   if(!m_edit.ReadOnly(false))
      return(false);

   if(!m_edit.Text(string(TextName)))
      return(false);


   if(!Add(m_edit))
      return(false);
//--- succeed
   return(true);
  }



//-----test#2




//-----test#2end











//+------------------------------------------------------------------+
//| Create the "label1"new label                                     |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateLabel1(void)
  {
//--- coordinates
//   int x1=INDENT_RIGHT;
//   int y1=INDENT_TOP+CONTROLS_GAP_Y;
//   int x2=x1+100;
//   int y2=y1+20;
// button 1 config //second line config
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(50+CONTROLS_GAP_Y);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_label1.Create(m_chart_id,m_name+"Label1",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_label1.Text("Lowest point"))
      return(false);
   if(!Add(m_label1))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Edit1"    edit                                       |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateEdit1(void)
  {
//--- coordinates
// button 2 config
   int x1=INDENT_LEFT+(BUTTON_WIDTH+CONTROLS_GAP_X);
   int y1=INDENT_TOP+(50+CONTROLS_GAP_Y);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//1   int x1=INDENT_LEFT;
//1   int y1=INDENT_TOP;
//   int x1=10;
//   int y1=5;
//   int x2 =ExtDialog.Width()/4;
//   int y2 =ExtDialog.Width()/4;
//1   int x2=ClientAreaWidth()-INDENT_RIGHT;
//1   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_edit1.Create(m_chart_id,Meditname1,m_subwin,x1,y1,x2,y2))
      return(false);
//--- allow editing the content
   if(!m_edit1.ReadOnly(false))
      return(false);

   if(!m_edit1.Text(string(TextName1)))
      return(false);


   if(!Add(m_edit1))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Button3"new button                                   |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateButton3(void)
  {

//--- coordinates
   int x1=INDENT_LEFT+2*(BUTTON_WIDTH+CONTROLS_GAP_X);
   int y1=INDENT_TOP+(100+CONTROLS_GAP_Y);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_button3.Create(m_chart_id,Button3,m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_button3.Text("Cancel"))
      return(false);
   if(!Add(m_button3))
      return(false);
   m_button3.Locking(true);
//--- succeed

   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Button1" button                                      |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateButton1(void)
  {
   /*
   //--- coordinates
    int x1=INDENT_LEFT;
    int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y);
    int x2=x1+BUTTON_WIDTH;
    int y2=y1+BUTTON_HEIGHT;
   //--- create
    if(!m_button1.Create(m_chart_id,m_name+"Button1",m_subwin,x1,y1,x2,y2))
       return(false);
    if(!m_button1.Text("Button1"))
       return(false);
    if(!Add(m_button1))
       return(false);
       */
//--- succeed
   return(true);

  }
//+------------------------------------------------------------------+
//| Create the "Button2" button                                      |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateButton2(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+(BUTTON_WIDTH+CONTROLS_GAP_X);
   int y1=INDENT_TOP+(100+CONTROLS_GAP_Y);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create                      //testing button name test Passed
   if(!m_button2.Create(m_chart_id,Button2,m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_button2.Text("Start"))
      return(false);
   if(!Add(m_button2))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Button3" fixed button                                |
//+------------------------------------------------------------------+
/*
bool CControlsDialog::CreateButton3(void)
 {

//--- coordinates
  int x1=INDENT_LEFT+2*(BUTTON_WIDTH+CONTROLS_GAP_X);
  int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y);
  int x2=x1+BUTTON_WIDTH;
  int y2=y1+BUTTON_HEIGHT;
//--- create
  if(!m_button3.Create(m_chart_id,m_name+"Button3",m_subwin,x1,y1,x2,y2))
     return(false);
  if(!m_button3.Text("Locked"))
     return(false);
  if(!Add(m_button3))
     return(false);
  m_button3.Locking(true);
//--- succeed

  return(true);
 }
*/

//+------------------------------------------------------------------+
//| Create the "CLabel"                                              |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateLabel(void)
  {
//--- coordinates
//   int x1=INDENT_RIGHT;
//   int y1=INDENT_TOP+CONTROLS_GAP_Y;
//   int x2=x1+100;
//   int y2=y1+20;
// button 1 config
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_label.Create(m_chart_id,m_name+"Label",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_label.Text("Highest point"))
      return(false);
   if(!Add(m_label))
      return(false);
//--- succeed
   return(true);
  }


//+------------------------------------------------------------------+
//| Create the "label2"new label               testing stuff    ahhhhhhhhhhhhhhhhhhhhhhhhhhhhh        |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateLabel2(void)
  {
//--- coordinates
//   int x1=INDENT_RIGHT;
//   int y1=INDENT_TOP+CONTROLS_GAP_Y;
//   int x2=x1+100;
//   int y2=y1+20;
// button 1 config //second line config
   int x1=INDENT_LEFT+80;
   int y1=INDENT_TOP+(150+CONTROLS_GAP_Y);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_label2.Create(m_chart_id,m_name+"Label2",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_label2.Text(string(Detecttxt)))
      return(false);
   if(!Add(m_label2))
      return(false);
//--- succeed
   return(true);
  }






//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+




//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CControlsDialog::OnClickButton3(void)
  {
   if(m_button3.Pressed())
      Comment(__FUNCTION__+" State of the control: On");


   else
      Comment(__FUNCTION__+" State of the control: Off");
  }



//+------------------------------------------------------------------+
//| Global Variables                                                 |
//+------------------------------------------------------------------+
CControlsDialog ExtDialog;
//---
CPanel   my_white_border;        // object CPanel

bool     pause=true;             // true - pause
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   EventSetTimer(3);
   pause=true;
//--- create application dialog
   if(!ExtDialog.Create(0,"Controls",0,40,40,380,344))
      return(INIT_FAILED);
//--- run application
   ExtDialog.Run();
//--- succeed
//test price
//Print(iPriceAmount);
// price test was a success
// MqlTick last_tick;
//---
   if(SymbolInfoTick(Symbol(),last_tick))
     {
      Print(last_tick.time,": Bid = ",last_tick.bid,
            " Ask = ",last_tick.ask,"  Volume = ",last_tick.volume);
     }
   else
      Print("SymbolInfoTick() failed, error = ",GetLastError());




//price test ends


   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- clear comments
   Comment("");
//--- destroy dialog
   ExtDialog.Destroy(reason);
  }


//+------------------------------------------------------------------+
//| Expert chart event function                                      |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,         // event ID
                  const long& lparam,   // event parameter of the long type
                  const double& dparam, // event parameter of the double type
                  const string& sparam)  // event parameter of the string type
  {
   ExtDialog.ChartEvent(id,lparam,dparam,sparam);

   if(id == CHARTEVENT_OBJECT_ENDEDIT && sparam == Meditname)
     {
      string stringyText = ObjectGetString(0, Meditname, OBJPROP_TEXT);
      Switchy(stringyText);
      ObjectSetString(0, Meditname, OBJPROP_TEXT, string(iPriceAmount));
      return;
     }

   if(id == CHARTEVENT_OBJECT_ENDEDIT && sparam == Meditname1)
     {
      string stringyText1 = ObjectGetString(0, Meditname1, OBJPROP_TEXT);
      Switchy1(stringyText1);
      ObjectSetString(0, Meditname1, OBJPROP_TEXT, string(iPriceAmount1));
      return;
     }
//test need to be global
   if(id == CHARTEVENT_OBJECT_CLICK && sparam == Button2)
     {
      //   Print(iPriceAmount);
      if(last_tick.bid > iPriceAmount && last_tick.bid > iPriceAmount1)
        {
         Detecttxt = Demandtxt;  //deamand zone
         m_label2.Text(string(Detecttxt));
         //Print(Detecttxt);
         starterdemand = 0;  // this communicates with the on tick function

         //build a function that waits for price to return to demand zone and in that function make code only executes once with fore loop



        }
      else
         if(last_tick.bid < iPriceAmount && last_tick.bid < iPriceAmount1)
           {
            // Print("Supply Zone Detected");
            Detecttxt = Supplytxt;
            m_label2.Text(string(Detecttxt));
            startersupply = 0;
            //build a function that waits for price to return to supply zone and in that function make code only executes once with fore loop

           }


     }


   if(id == CHARTEVENT_OBJECT_CLICK && sparam == Button3) //our testing site
     {
  ExpertRemove();
     //  Print(  calcLotsdemand(50) );
    //  oneRRtakeprofitdemand();
     // oneRRtakeprofitsupply();
      // Print("current demand ",stldemand1, " last demand ", stldemand2);
      //  Print("current supply ",stlsupply1, " last supply ", stlsupply2);
      //  Print(" Tp supply ",takeprofitsupply);
      // Print(" low of last ",lowof1);
      //Print("Low of last",lowof1," ..High of last", highof1, " ..Low of current", lowof0," ..High of current", highof0);

      //   CTSK = 5;
       
    // StopLossDemandFunction();
    // StopLossSupplyFunction();
      //onepointsixpercentriskdemand();
    //  Print(riskdemand);
  //    Print(riskdemand + spreadDAS);
   //   Print(risksupply);
    //  Print(risksupply + spreadDAS);
    //  Print(spreadDAS);
      //   Print(stldemand1 / _Point);
      //  Print(stldemand2 / _Point);

      // Print(lotsdemand);

      //  Print(AccountInfoDouble(ACCOUNT_BALANCE) * 1 / 100);
      //   double mstep = riskdemand * tickvalue * lotstep;
      //    double rmoniess = 10000 * 1.6 / 100;  // account balance * percent risk / 100 idk.
      //  Print(mstep);
      // Print(ticksize);


      // Print(SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP));
      // double testelotss = NormalizeDouble((rmoniess / riskdemand),2);
      //   Print(rmonies / riskdemand);
      // Print(testelotss, " if this match it works ");
      // this simple approach is correct..

      //test complete passed.
     }
  }
//+------------------------------------------------------------------+
//|  Timer                                                           |
//+------------------------------------------------------------------+
/*
void OnTimer()
  {
   pause=!pause;
  }
*/

//+------------------------------------------------------------------+
//|  This text is to convert input feild into a number  .Beginning   |
//+------------------------------------------------------------------+
void Switchy(string stringyText)
  {
   double nummyText = StringToDouble(stringyText);
   if(nummyText < 0)
     {
      Print("Invalid volume specified");
      return;
     }
   iPriceAmount = nummyText;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Switchy1(string stringyText1)
  {
   double nummyText1 = StringToDouble(stringyText1);
   if(nummyText1 < 0)
     {
      Print("Invalid volume specified");
      return;
     }
   iPriceAmount1 = nummyText1;
  }

//+------------------------------------------------------------------+
//| Areas for all of the keys/Varibles                               |
//+------------------------------------------------------------------+

int starterdemand = 1;
int startersupply = 1;
int stopperdemand = 0;
int stoppersupply = 0;
int confrimdemand = 1;
int confrimsupply = 1;
int DZB = 1;
int SZB = 1;
double lowof1;
double highof1;
double lowof0;
double highof0;
//int buyTicket;                   int sellTicket;
double stldemand1;
double stldemand2;
double stlsupply1;
double stlsupply2;

long spreadDAS;


double CPSK = 0;
double CPDK = 0;
//+------------------------------------------------------------------+
//| Creates stoploss  calcualtions                                   |
//+------------------------------------------------------------------+
double riskdemand;
double risksupply;


double dstl1;
double dstl2;
double sstl1;
double sstl2;

double stoplossdemand;
double stoplosssupply;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void StopLossDemandFunction()
  {
   if(lowof0 < lowof1)
     {
      stoplossdemand = dstl1;
      riskdemand = NormalizeDouble(stldemand1 / _Point,_Digits);// + spreadDAS;
     }
   else
     {
      stoplossdemand = dstl2;
      riskdemand = NormalizeDouble(stldemand2 / _Point,_Digits);// + spreadDAS;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void StopLossSupplyFunction()
  {
   if(highof0 > highof1)
     {
      stoplosssupply = sstl1;
      risksupply = NormalizeDouble(stlsupply1 / _Point,_Digits);// + spreadDAS;
     }
   else
     {
      stoplosssupply = sstl2;
      risksupply = NormalizeDouble(stlsupply2 / _Point,_Digits);// + spreadDAS;
     }
  }
//+------------------------------------------------------------------+
//| Creates takeprofit  calcualtions                                 |
//+------------------------------------------------------------------+
double takeprofitdemand;
double takeprofitsupply;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void oneRRtakeprofitdemand()
  {
   if(lowof0 < lowof1)
     {
      takeprofitdemand = highof1 + stldemand1;
     }
   else
     {
      takeprofitdemand = highof1 + stldemand2;
     }
  }

//need to fix //this should be - not +
void oneRRtakeprofitsupply()
  {
   if(highof0 > highof1)
     {
      takeprofitsupply = lowof1 - stlsupply1;
      Print("take profit supply ", takeprofitsupply);
      
     }
   else
     {
      takeprofitsupply = lowof1 - stlsupply2;
       Print("take profit supply ", takeprofitsupply);
       
     }
     
  }

//+------------------------------------------------------------------+
//| Creates RISK  calcualtions  fixed  just do supply side                                 |
//+------------------------------------------------------------------+
double ticksize = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_SIZE);
double tickvalue = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE);
double lotstep = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);


//demand
double calcLotsdemand(double slDistance)
  {
  
   if(_Symbol == "US30" || _Symbol == "NASUSD" || _Symbol == "NAS100" || _Symbol == "SP500"){
   
      Print("nasdaqqq");
   double mstep = slDistance;
   double rmonies = 50000 * 2 / 100;  // account balance * percent risk / 100 idk.///// AccountInfoDouble(ACCOUNT_BALANCE) this is for compound
   rmonies = rmonies * 10;
   double testelots = NormalizeDouble((rmonies / mstep),2);
   return testelots;
     }
   else{
   
   Print("pairs");
   double mstep = slDistance;
   double rmonies = 50000 * 2 / 100;  // account balance * percent risk / 100 idk.///// AccountInfoDouble(ACCOUNT_BALANCE) this is for compound
   double testelots = NormalizeDouble((rmonies / mstep),2);
   return testelots;
   
   }
  }
// supply
double calcLotssupply(double slDistances)
  {
   if(_Symbol == "US30" || _Symbol == "NASUSD" || _Symbol == "NAS100" || _Symbol == "SP500"){
      Print("NASqqq");
      
      double msteps = slDistances;
      double rmoniess = 50000 * 2 / 100;  
      rmoniess = rmoniess * 10;
      double testelotss = NormalizeDouble((rmoniess / msteps),2);
      return testelotss;

     }
   else
     {
      Print("pairs");
     
   
   double msteps = slDistances;
   double rmoniess = 50000 * 2 / 100; // look above.
   double testelotss = NormalizeDouble((rmoniess / msteps),2);
   return testelotss;
}

   

  }






//+------------------------------------------------------------------+
//|           ///////START of Demand zone code stuff\\\\\\\\         |
//+------------------------------------------------------------------+
void ZoneRunnerDemand()
  {
   if(stopperdemand <=0)
     {
      Print("Price tapped demand zone");
      Print("Waiting for comfrimation...");
      confrimdemand = 0;
      DZB = 0;

     }
   if(stopperdemand <=0)
     {
      stopperdemand = 1;
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DemandComfrimation()
  {
   if(confrimdemand <= 0)
     {

      Print("Buy Comfrimation triggered: order placed");

     }

   if(confrimdemand <= 0)
     {
      confrimdemand = 1;
      //  DZB = 1;
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DemandZoneBreached()
  {
   if(DZB <= 0)
     {
      Print("Demand Zone Breached");
     }

   if(DZB <= 0)
     {
      DZB = 1;
     ExpertRemove();
      //   confrimdemand = 1;
     }
  }
//+------------------------------------------------------------------+
//|           \\\\\\\END of Demand zone code stuff////////           |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|           ///////START of Suppply zone code stuff\\\\\\\\        |
//+------------------------------------------------------------------+
void ZoneRunnerSupply()
  {
   if(stoppersupply <=0)
     {
      Print("Price tapped supply zone");
      Print("Waiting for Confrimation");
      confrimsupply = 0;
      SZB = 0;
     }
   if(stoppersupply <=0)
     {
      stoppersupply = 1;
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SupplyComfrimation()
  {
   if(confrimsupply <= 0)
     {
      Print("Sell Comfrimation triggered: order placed");

     }

   if(confrimsupply <= 0)
     {
      confrimsupply = 1;
      //  SZB = 1;
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SupplyZoneBreached()
  {
   if(SZB <= 0)
     {
      Print("Supply Zone Breached");
     }

   if(SZB <= 0)
     {
      SZB = 1;
    ExpertRemove();
      //  confrimsupply = 1;
     }
  }
//+------------------------------------------------------------------+
//|           \\\\\\\END of Supply zone code stuff////////           |
//+------------------------------------------------------------------+

//////--------partials & trailing demand ----------------


void closePartialsDemand(ulong ticnum, double lotsforDeez, double opender)
  {
   if(CPDK <= 0)
     {
       double lotsToClose = lotsforDeez / 2; // 2.0 is half for sure, the rest is more complicated....
              lotsToClose = NormalizeDouble(lotsToClose,2);
                       
                   
                                     
                if( trade.PositionModify(ticnum,opender,0) ){
                 Print("STL @ BE");
                }
                 if( trade.PositionClosePartial(ticnum,lotsToClose) ){
                 Print("Partials closed baby");
                 }     
                 CTSK = 5;
     }

   if(CPDK <= 0)
     {
      CPDK = 1;
     }
  }


//global keys & global vars
   double CTSK = 1;  // in partail code update the key to 0;
   double PTDK = 0;
   double pointstohunny;
   double lockinprice;

/// the trialing stop 


  void checkTrailingStopDemand(double price){
    double bidd = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
  
      for(int i = PositionsTotal()-1; i >= 0; i--){
         ulong posTicket = PositionGetTicket(i);
         string PosSymbol = PositionGetString(POSITION_SYMBOL);
        
       if(PositionSelectByTicket(posTicket) && _Symbol == PosSymbol ){
         double openp = PositionGetDouble(POSITION_PRICE_OPEN);
         double profitD = PositionGetDouble(POSITION_PROFIT);
         double CSloss = PositionGetDouble(POSITION_SL);
            
           
             
            if(profitD >= 500 && PTDK <= 0 ){ //change this to 1% of trialing stop take profit cause it split it in half yada yada ya
               pointstohunny = price - openp;
               pointstohunny = NormalizeDouble(pointstohunny,_Digits);
               lockinprice = price;  
               
              Print(pointstohunny);
              Print(lockinprice);
              Print("BOOM Baby!");
              if(PTDK <= 0){
                   PTDK = 1;
               }
            }   
          
            double closeingpoint = bidd - pointstohunny;

            if(bidd > lockinprice && PTDK ==1){
              trade.PositionModify(posTicket,closeingpoint,0);
              lockinprice = bidd;
            }
     }
    }
   }


//////--------partials & trailing supply ----------------


void closePartialsSupply(ulong ticnumm, double lotsforDeezz, double openderr)
  {
   if(CPSK <= 0) 
     {
       double lotsToClosee = lotsforDeezz / 2; 
              lotsToClosee = NormalizeDouble(lotsToClosee,2);
                       
    
       trade.PositionModify(ticnumm,openderr,0); 
         Print("STL @ BE");
                 
       trade.PositionClosePartial(ticnumm,lotsToClosee);
         Print("Partials closed baby");
    
       CTSKS = 5;
     }

   if(CPSK <= 0)
     {
      CPSK = 1;
     }
  }
/*
void supplyFix(ulong ticnumm, double openderr, double lotsToClosee){
         
}*/
//global keys & global vars
   double CTSKS = 1;  // in partail code update the key to 0;
   double PTSK = 0;
   double Spointstohunny;
   double Slockinprice;

/// the trialing stop 


  void checkTrailingStopSupply(double pricee){
    double biddd = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
  
      for(int i = PositionsTotal()-1; i >= 0; i--){
         ulong posTickett = PositionGetTicket(i);
         string PosSymboll = PositionGetString(POSITION_SYMBOL);
        
       if(PositionSelectByTicket(posTickett) && _Symbol == PosSymboll ){
         double openpp = PositionGetDouble(POSITION_PRICE_OPEN);
         double profitDD = PositionGetDouble(POSITION_PROFIT);
         double CSlosss = PositionGetDouble(POSITION_SL);
            
           
             
            if(profitDD >= 500 && PTSK <= 0 ){
               Spointstohunny = pricee - openpp;
               Spointstohunny = NormalizeDouble(Spointstohunny,_Digits);
               Slockinprice = pricee;  
               
              Print(Spointstohunny);
              Print(Slockinprice);
              Print("BOOM Baby!");
              if(PTSK <= 0){
                   PTSK = 1;
               }
            }   
          
            double closeingpointt = biddd - Spointstohunny;

            if(biddd < Slockinprice && PTSK ==1){
              trade.PositionModify(posTickett,closeingpointt,0);
              Slockinprice = biddd;
            }
     }
    }
   }














//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  OnTick()
  {
///////////////// a couple varibles and comments to start off
   double bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
   double ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);


   double highlast = iHigh(_Symbol, PERIOD_CURRENT, 1);
   double lowlast = iLow(_Symbol, PERIOD_CURRENT, 1);
   double highfirst = iHigh(_Symbol, PERIOD_CURRENT, 0);
   double lowfirst = iLow(_Symbol, PERIOD_CURRENT, 0);


   lowof1 = lowlast;
   highof1 = highlast;
   lowof0 = lowfirst;
   highof0 = highfirst;


   double demandingAlot =0;

    double spread = ask-bid;
    spread = NormalizeDouble(spread,_Digits);
    spreadDAS = SymbolInfoInteger(Symbol(),SYMBOL_SPREAD);
   Comment(spreadDAS);  
     
      
  // Comment("\nLast High: ", highlast,
  //         "\nCurrent High:", highfirst,
  //         "\nLast low: ",lowlast,
  //         "\nCurrent low:", lowfirst,
  //         "\nBid: ", bid);
//////////////// End of varibles and comments. now time for code.


// Demand stuff
   if(starterdemand <= 0 && SymbolInfoDouble(_Symbol,SYMBOL_BID) < iPriceAmount)
     {
      ZoneRunnerDemand();
     }                                         //switching out bid for high of last candle for test
   if(bid > iPriceAmount1 && confrimdemand <= 0 && bid >= highlast)
     {


      DemandComfrimation();
      StopLossDemandFunction();
      oneRRtakeprofitdemand();
      trade.SetDeviationInPoints(1);
      double lotsdemand = calcLotsdemand(riskdemand);

      //gotta global lotsdemand for partials
      // demandingAlot = 0.45; //whol thing is trash can
      // double lotsizedemand = calcLotsdemand(riskdemand);
      // test ask with highlast //******disabling stl momentarily replace 0 with stoplossdemand
      //take out takeprofitdemand and stoplossdemand to test partial code
      trade.Buy(lotsdemand,NULL,highlast,stoplossdemand);

     }
   else
      if(DZB <= 0 && bid < iPriceAmount1)
        {
         DemandZoneBreached();

        }
//       //            //  so far test was a sucess but we still see 2 points of slipage in first test may be due to slop market movment tho  so more test needed.


// Supply stuff
   if(startersupply <= 0 && SymbolInfoDouble(_Symbol,SYMBOL_BID) > iPriceAmount1)
     {
      ZoneRunnerSupply();
     }                                         //switching out bid for low of last candle for test
   if(bid < iPriceAmount && confrimsupply <= 0 && bid <= lowlast)
     {
      SupplyComfrimation();
      StopLossSupplyFunction();
      oneRRtakeprofitsupply();
      trade.SetDeviationInPoints(1);
      double lotsupply = calcLotssupply(risksupply);
      // testing out bid with lowlast //******disabling stl momentarily replace 0 with stoplosssupply
      // TAKE OUT takeprofitsupply so partials and trailing can work
      trade.Sell(lotsupply,NULL,lowlast,stoplosssupply);
      
     }
   else
      if(SZB <= 0 && bid > iPriceAmount)
        {
         SupplyZoneBreached();
        }













// still need this but not for stop loss,for lot calc

//if(lowof0 < lowof1)
// {
   stldemand1 = NormalizeDouble((lowof0 - highof1)*-1,_Digits);

//  }
//else
//  {
   stldemand2 = NormalizeDouble((lowof1 - highof1)*-1,_Digits);

//  }

// still need this but not for stop loss,for lot calc

//if(lowof0 < lowof1)
// {
   stlsupply1 = NormalizeDouble((highof0 - lowof1),_Digits);

//  }
//else
//  {
   stlsupply2 = NormalizeDouble((highof1 - lowof1),_Digits);

//  }





   dstl1 = lowfirst;
   dstl2 = lowlast;
   sstl1 = highfirst;
   sstl2 = highlast;



//DEMAND PARTIALS
             if(CPDK <= 0 && bid >= takeprofitdemand && confrimdemand > 0){
              
                 for(int i = PositionsTotal()-1; i >= 0; i--){
                     ulong posTicket = PositionGetTicket(i);
                     string PosSymbol = PositionGetString(POSITION_SYMBOL);
                     ENUM_POSITION_TYPE posType = (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
                    
                       // if( PositionSelectByTicket(posTicket) ){
                          if(posType == POSITION_TYPE_BUY && _Symbol == PosSymbol ){
                           double posOpenPrice = PositionGetDouble(POSITION_PRICE_OPEN);
                           double posVolume = PositionGetDouble(POSITION_VOLUME);
                           closePartialsDemand(posTicket, posVolume, posOpenPrice);
                           break;
                         }                        
                 }
             }



//SUPPLY PARTIALS                                      
            if(CPSK <= 0 && takeprofitsupply >= bid && confrimsupply > 0){
            
                 for(int ii = PositionsTotal()-1; ii >= 0; ii--){
                     ulong posTickett = PositionGetTicket(ii);
                     string PosSymboll = PositionGetString(POSITION_SYMBOL);
                     ENUM_POSITION_TYPE posTypee = (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
                     
                     
                      //  if(PositionSelectByTicket(posTickett)){
                          if(posTypee == POSITION_TYPE_SELL && _Symbol == PosSymboll ){
                           double posOpenPricee = PositionGetDouble(POSITION_PRICE_OPEN);
                           double posVolumee = PositionGetDouble(POSITION_VOLUME);
                           closePartialsSupply(posTickett, posVolumee, posOpenPricee);
                           break;
                         }                     
                 }
             }
//SUPPLY TRAILING          
               if(CTSKS == 5){
                  checkTrailingStopSupply(bid);
                 }


//DEMAND TRAILING          
               if(CTSK == 5){
                  checkTrailingStopDemand(bid);
                 }





  }



//+------------------------------END OF ZONE RUNNER 1.0 CODE------------------------------------+


