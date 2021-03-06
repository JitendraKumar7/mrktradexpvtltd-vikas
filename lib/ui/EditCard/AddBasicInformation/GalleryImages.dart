import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mrktradexpvtltd/ui/base/libraryExport.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GalleryImages extends StatefulWidget{
  final int item;

  const GalleryImages({Key key, this.item}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return GalleryImages1();
  }
}
class GalleryImages1 extends State<GalleryImages>{




  var  konnectid;
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




  TextEditingController textphn = TextEditingController();
  TextEditingController tetpass =  TextEditingController();

  Future<Album> _futureAlbum;


  Future<Album> createAlbum(String  title, password) async {


  //var jsonResponse = null;
  final http.Response response = await http.post(
  'https://meo.co.in/KmcApi/index.php/login',
  headers: <String, String>{
  'Content-Type': 'application/json; charset=UTF-8',
  },
  body: jsonEncode(<String, String  >{
  'password': password,
  'mobile_number':title,
  'type':"KonnectBusiness",

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
  File _image;
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  _openPopup(context) {


    Alert(

        context: context,
        title: "Choose option",

        content: SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                Divider(color: Colors.black,),
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                Divider(color: Colors.black,),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        )  ,
        buttons: [

        ]
    ).show();
  }
  void navigationPage() {
    Navigator.pop(context);

  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar:AppBar(
        title:const  Text(  "Gallery Images"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.lightBlue,fontFamily: "Product Sans" ),),),
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
      height: 80,
      width: 212,
      padding: EdgeInsets.all(8.0),
      child:Row(
          children: <Widget>[
            Container(

              child:InkWell(onTap: (){
                setState(() {
                  _openPopup(context);
                });
              },
                  child: Icon(Icons.image)),
              height: 60,width: 60,),
            SizedBox(width: 10,),
            Divider(color: Colors.pink,),
            SizedBox(width: 10,),
            new Text(  "Upload Image"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),


          ]),

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
  _futureAlbum = createAlbum(knt,
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