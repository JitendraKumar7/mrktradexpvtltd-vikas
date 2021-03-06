import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mrktradexpvtltd/modal/album.dart';

import 'package:shared_preferences/shared_preferences.dart';

class BankingDetails extends StatefulWidget{
  final int item;

  const BankingDetails ({Key key, this.item}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return BankingDetails1();
  }
}
class BankingDetails1 extends State<BankingDetails>{

  var  konnectid;
  int  _user, _catg;
var listbank =["1	SBI	 State Bank of India",
"2	RBI	 Reserve Bank of India",
"3	BOI	 Bank of India",
"4	ADB	 Asian Development Bank",
"5	ICICI	 Industrial Credit and Investment Corporation of India",
"6	HDFC	 Housing Development Finance Corporation",
"7	HSBC	 Hong-Kong and Shanghai Banking Corporation",
"8	UCO	 United Commercial Bank",
"9	PNB	 Punjab National Bank",
"10	IDBI	 Industrial Development Bank of India",
"11	BOB	 Bank of Baroda",
"12	IOB	 Indian Overseas Bank",
"13	CCB	 Central Co-operative Bank",
"14	UBI	 United Bank of India",
"15	UBI	 Union Bank of India",
"16	ECS	 Electronic Clearing Service",
"17	OBC	 Oriental Bank of Commerce",
"18	IRDA	 Insurance Regulatory and Development Authority",
"19	SEBI	 Securities and Exchange Board of India",
"20	SIDBI	 Small Industries Development Bank of India",
"21	BOM	 Bank Of Maharashtra",
"22	UCB	 Urban Cooperative bank",
"23	NABARD	 National Bank for Agriculture and Rural Development",
"24	KMB	 Kotak Mahindra Bank",
"25	DCB	 Development Credit Bank",
"26	RRB	 Regional Rural Bank",
"27	IVB	 ING Vysya Bank",
"28	PSB	 Punjab & Sind Bank",
"29	SVC	 Shamrao Vithal Co-operative Bank",
"30	BMB	 Bharatiya Mahila Bank",
"31	BOR	 Bank of Rajasthan"
"32	CUB	 City Union Bank"
"33	CSB	 Catholic Syrian Bank"
"34	KVB	 Karur Vysya Bank",
"35	LVB	 Lakshmi Vilas Bank",
"36	SIB	 South Indian Bank",
"37	TMB	 Tamilnad Mercantile Bank",
"38	EXIM	 Export Import(Bank of India)",
"39	DB	 Dena Bank",
"40	IIBI	 Industrial Investment Bank of India",
"41	NHB	 National Housing Bank",
"42	AB	 Allahabad Bank"
"43	AB	 Andhra Bank"
"44	CB	 Canara Bank"
"45	CBI	 Central Bank of India",
"46	CB	 Corporation Bank",
"47	IB	 Indian Bank",
"48	VB	 Vijaya Bank",
"49	JKB	 Jammu & Kashmir Bank",
"50	SCB	 Standard Chartered Bank",
"51	SDS	 Special Deposit Scheme",
"52	ECD	 European Central Bank",
"53	IPPB	 India Post Payments Bank",
"54	ABPB	 Aditya Birla Payments Bank",
"55	PPB	 Paytm Payments Bank",
"56	APB	 Airtel Payments Bank",
"57	JPB	 Jio Payments Bank",
"58	PBGB	 Paschim Banga Gramin Bank",
"59	BGVB	 Bangiya Gramin Vikash Bank",
"60	IBA	 Indian Banks' Association",
"61	EMI	 Equated Monthly Installment",
"62	LBD	 Land Development Bank",
"63	FRB	 Federal Reserve Banks",
"64	IDFC	 Infrastructure Development Finance Company","65	ECB	 External Commercial Borrowing",
"66	EMI	 Equated monthly installments","67	UOB	 United Overseas Bank",
"68	BIS	 Bank for International Settlement",
"69	IFSC	 Indian Financial System Code",
"70	NAB	 National Australia Bank",
"71	ICBC	 Industrial and Commercial Bank of China",
"72	DBS	 Development Bank of Singapore",
"73	RBC	  Royal Bank of Canada",
"74	ADCB	 Abu Dhabi Commercial Bank",
"75	MICB	 Mega International Commercial Bank",
"76	NEFT	 National Electronic Funds Transfer",
"77	DCCB	 District Central Co-operative Bank",
"78	OSCB	 Odisha State Co-operative Bank",
"79	RTGS	 Real-Time Gross Settlement",
"80	RBL	 Ratnakar Bank Limited",
"81	SLR	 Single Lens Reflex",
  "82	SLR	 Statutory Liquidity Ratio",
"83	S/D/W/H/o	 Son/Daughter/Wife/Husband of",
"84	PF	 Provident Funds",
"85	KYC	 Know Your Customer",
"86	TDS	 Tax Deducted at Source",
"87	ESI	 Employees' State Insurance",
"88	PAN	 Permanent Account Number",
"89	PO	 Post Office",
"90	INR	 Indian Rupee",
"91	Wdl	 Withdrawal"
"92	txn	  Transaction"
"93	TT	 Telegraph Transfer"
"94	SB	 Saving Book"
"95	A/C	 Account"
"96	CC	 Cash Credit"
"97	chq	 Cheque"
"98	bal	 Balance",
"99	csh	 Cash"
"100	dep	 Deposit"];

  var Textnameq="8233081931";
  @override
  void initState() {
    konnectid= widget.item;
  super.initState();

  }
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();


  String validateMobile(String value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
  return 'Please enter mobile number';
  }
  else if (!regExp.hasMatch(value)) {
  return 'Please enter valid mobile number';
  }
  return null;
  }


  static Future<List<String>> getDeviceDetails() async {
  String deviceName;
  String deviceVersion;
  String identifier;


//if (!mounted) return;
  return [deviceName, deviceVersion, identifier];
  }

  TextEditingController textbname = TextEditingController();
  TextEditingController tetacc =  TextEditingController();
  TextEditingController textbranch = TextEditingController();
  TextEditingController tetifsc =  TextEditingController();
  TextEditingController textupi = TextEditingController();


  Future<Album> _futureAlbum;


  Future<Album> createBank(String Konnectid,  BANKname,ACCOUNTNO,IFSC,BRANCH,UPICODE) async {


//if (!mounted) return;

  //var jsonResponse = null;
  final http.Response response = await http.post(
  'https://meo.co.in/meoApiPro/konnectBusiness/index.php/addBank',
  headers: <String, String>{
  'Content-Type': 'application/json; charset=UTF-8',
  },
  body: jsonEncode(<String, String  >{
  'konnect_id': Konnectid,
  'bank_name':BANKname,
  'acc_no':ACCOUNTNO,
  'ifsc_code':IFSC,
  'branch':BRANCH,
  'upi':UPICODE,
  }),
  );


  if (response.statusCode == 200 ) {

  Map<String,dynamic> responseJson = json.decode(response.body);

  Map result = responseJson['result'];




  var sucess= responseJson['message'];

  if (sucess=="success" ){

  navigationPage();
  Fluttertoast.showToast(
  msg: "Successfully login",
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.CENTER,
  timeInSecForIosWeb: 1,
  backgroundColor: Colors.red,
  textColor: Colors.white,
  fontSize: 16.0);
  }else{
  Fluttertoast.showToast(
  msg: "Register First !! u r not member ",
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.CENTER,
  timeInSecForIosWeb: 1,
  backgroundColor: Colors.red,
  textColor: Colors.white,
  fontSize: 16.0);
  }


  // If the server did return a 201 CREATED response,
  // then parse the JSON.
  return  Album.fromJson(json.decode(response.body));

  } else {
  Fluttertoast.showToast(
  msg: "Register First !! u r not member ",
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.CENTER,
  timeInSecForIosWeb: 1,
  backgroundColor: Colors.red,
  textColor: Colors.white,
  fontSize: 16.0);
  var  jsonResponse = json.decode(response.body);

  throw Exception('Failed to load album');
  }
  }

  void navigationPage() {
    Navigator.pop(context);

  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar:AppBar(
        title:const  Text(  "Bank Details "??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.lightBlue,fontFamily: "Product Sans" ),),),
  backgroundColor: Colors.white,
  body: SingleChildScrollView(
  child: Container(
  child: Column(
  children: <Widget>[
    Container(
      height: 250,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.fill
          )
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
              left: 30,
              width: 80,
              height: 150,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/light-1.png')
                    )
                ),
              )),

          Positioned(
            top: 30,
            left: 150,
            width: 80,
            height:80,
            child:  Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/logo.png')
                  )
              ),
            )),


        ],
      ),
    ),
  Padding(
  padding: EdgeInsets.all(30.0),
  child: Column(
  children: <Widget>[
   Container(
  padding: EdgeInsets.all(5),
  decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
  BoxShadow(
  color: Color.fromRGBO(143, 148, 251, .4),
  blurRadius: 20.0,
  offset: Offset(0, 10)
  )
  ]
  ),
  child: Column(
  children: <Widget>[
  Container(
  padding: EdgeInsets.all(8.0),
  decoration: BoxDecoration(
  border: Border(bottom: BorderSide(color: Colors.grey[100]))
  ),
  child:SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child:
    new DropdownButton<String>(
      dropdownColor: Colors.amber,
      hint: Text('Select Category of business'),

      value:  _catg == null ? null : listbank[_catg],

      items:listbank.map((String value){


        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (value) {

        setState(() {
          _catg = listbank.indexOf(value);
        });
      },

    ),
  ),),
    Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[100]))
      ),
      child: TextFormField(
        controller:tetacc ,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Account Number",
            hintStyle: TextStyle(color: Colors.grey[400])
        ),
      ),
    ),
    Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[100]))
      ),
      child: TextFormField(
        controller:textbname ,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Branch ",
            hintStyle: TextStyle(color: Colors.grey[400])
        ),
      ),
    ),
    Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[100]))
      ),
      child: TextFormField(
        controller:tetifsc ,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "IFSC No",
            hintStyle: TextStyle(color: Colors.grey[400])
        ),
      ),
    ),
    Container(

      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: textupi,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "UPI No",
            hintStyle: TextStyle(color: Colors.grey[400])
        ),
      ),
    ),
  ],
  ),
  ),
  SizedBox(height: 30,),
   Container(
  height: 50,
  decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  gradient: LinearGradient(
  colors: [
  Colors.lightBlueAccent,

  Colors.lightBlue
  ]
  )
  ),
  child: InkWell(child:
  Center(
  child: Text("Save", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
  ),onTap: () async {
    String knt=konnectid.toString();
  _futureAlbum = createBank(knt, listbank[_catg],
  tetacc.text,textbranch.text,tetifsc.text,textupi.text);


  //Navigator.of(context).pushReplacementNamed(HOME_SCREEN);
  },
  )),
  SizedBox(height: 70,),
  ],


  ),
  )
  ],
  ),
  ),
  ) );

  }


}