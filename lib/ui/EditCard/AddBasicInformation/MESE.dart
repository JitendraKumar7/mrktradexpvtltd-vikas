
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mrktradexpvtltd/ui/base/libraryExport.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MESE extends StatefulWidget{
  final int item;

  const MESE({Key key, this.item}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MESE1();
  }
}
class MESE1 extends State<MESE>{
  var  konnectid;
  var Textnameq="8233081931";
  @override
  void initState() {
    konnectid= widget.item;
    String knt=konnectid.toString();
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




  TextEditingController textphn = TextEditingController();
  TextEditingController tetpass =  TextEditingController();

  Future<Album> _futureAlbum;


  Future<Album> createAlbum(String knt, title, password) async {

//if (!mounted) return;

  //var jsonResponse = null;
  final http.Response response = await http.post(
  'https://meo.co.in/meoApiPro/konnectBusiness_v2/index.php/addMsmeKonnect',
  headers: <String, String>{
  'Content-Type': 'application/json; charset=UTF-8',
  },
  body: jsonEncode(<String, String  >{
  'konnect_id': knt,
  'enterprise':title,
'uan':password
  }),
  );


  if (response.statusCode == 200 ) {

  Map<String,dynamic> responseJson = json.decode(response.body);

  List result = responseJson['result'];




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
        title:const  Text(  "MESE"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.lightBlue,fontFamily: "Product Sans" ),),),
  backgroundColor: Colors.white,
  body: SingleChildScrollView(
  child: Container(
  child: Column(
  children: <Widget>[
    Container(
      height: 300,
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
            child: Container(
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
  child: TextFormField(
  controller:textphn ,
  decoration: InputDecoration(
  border: InputBorder.none,
  hintText: "Enterprise Name",
  hintStyle: TextStyle(color: Colors.grey[400])
  ),
  ),
  ),
  Container(

  padding: EdgeInsets.all(8.0),
  child: TextFormField(
  controller: tetpass,
  decoration: InputDecoration(
  border: InputBorder.none,
  hintText: "UAN No.",
  hintStyle: TextStyle(color: Colors.grey[400])
  ),
  ),
  )
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
  textphn.text=Textnameq;
  String knt=konnectid.toString();
  _futureAlbum = createAlbum(knt,textphn.text,
  tetpass.text);


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