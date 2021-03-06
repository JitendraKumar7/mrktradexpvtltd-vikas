import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mrktradexpvtltd/ui/EditCard/AddBasicInformation/DrugLicense.dart';
import 'package:mrktradexpvtltd/ui/EditCard/AddBasicInformation/GalleryHeader.dart';
import 'package:mrktradexpvtltd/ui/EditCard/AddBasicInformation/GalleryImages.dart';
import 'package:mrktradexpvtltd/ui/EditCard/AddBasicInformation/WhatappMessage.dart';
import 'package:mrktradexpvtltd/ui/EditCard/AddBasicInformation/googlemap.dart';
import 'package:mrktradexpvtltd/ui/base/libraryExport.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'AddBasicInformation/About.dart';





class EditCardcreate extends StatefulWidget{

  final KonnectDetails konnectDetails;

  EditCardcreate(this.konnectDetails);


  @override
  State<StatefulWidget> createState() {
    return EditCardcreate1();
  }

}
class EditCardcreate1 extends State<EditCardcreate>{

  Color coronas= Colors.lightBlue;
  var Textnameq;

  var Emailq;

  var Org;

  var Phoneqq;

  var Busnessq;
  var konnectid=0;
  var Phonea;
  List<Location> location;
  List<CoverImage>coverimage;
  List<About>about;
  List<Bank>bank;
  List<GstIn>gst;
  List<WhatsAppHeader>whatsappheader;
  List<WhatsAppTemplate> wsptemp;
  List<GalleryHeader> galleryh;
  List<GalleryImages> galleryI;
  List<CustomerSupport>cuse;
  List<DrugLic>DrugL;
  @override
  void initState() {

 BasicInfo  basicInfo=widget.konnectDetails.basicInfo;
 location= widget.konnectDetails.location;
 bank=widget.konnectDetails.bank;
 gst= widget.konnectDetails.gstin;
 about=widget.konnectDetails.about;
 coverimage=widget.konnectDetails.coverImage;
 whatsappheader=widget.konnectDetails.whatsappheader;
  wsptemp=widget.konnectDetails.whatsappTemplate;
 cuse=widget.konnectDetails.customerSupport;
 DrugL=widget.konnectDetails.drugLic;

    super.initState();



    List list=[ konnectid,Textnameq, Emailq, Org,Phoneqq,Phonea,  Busnessq,];
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
  @override
  Widget build(BuildContext context) {
    final planetThumbnail = new Container(
        margin: new EdgeInsets.symmetric(
            vertical: 0.0

        ),

        alignment: FractionalOffset.centerLeft,
        child:InkWell(onTap: (){
          setState(() {
            _openPopup(context);
          });
        },
            child:Column(children: [

              Container(

                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(

                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image:AssetImage('assets/images/logow.jpg')





                    ),
                  )),Container(
                  height: 10,
                  width: 10,
                  child:
                  Icon(Icons.edit,))])));

    final planetCard = new Container(

      child: new InkWell(
        onTap: () {






          //  navigationPage();
        },


        child:
        Container(


          //elevation: 1.0,
          margin: EdgeInsets.all(3.0),
          child:
          Container(
            padding: const EdgeInsets.all(0.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                new Container(child:
                Row(
                  children: <Widget>[

                    planetThumbnail,
                    SizedBox(width: 10,),
                    Container(
                        width:MediaQuery.of(context).size.width/1.75,
                        child : Column(children: [


                          Padding(

                            padding: const EdgeInsets.only(left: 0.0),
                            child: new Row(

                              children: <Widget>[

                                new Text(  Org??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: coronas,fontFamily: "Product Sans" ),),
                              ],
                            ),
                          ),
                          Divider( height: 1,color: Colors.black,),
                          Padding(

                            padding: const EdgeInsets.only(left: 0.0),
                            child: new Row(

                              children: <Widget>[

                                new Text(Phonea??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: coronas,fontFamily: "Product Sans" ),),
                              ],
                            ),
                          ),
                          Divider( height: 1,color: Colors.black,),
                          Padding(

                            padding: const EdgeInsets.only(left: 0.0),
                            child: new Row(

                              children: <Widget>[

                                new Text(  Phoneqq??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: coronas,fontFamily: "Product Sans" ),),
                              ],
                            ),
                          ),

                        ],)),
                    Padding(

                      padding: const EdgeInsets.only(left: 0),

                    ),
                  ],
                ),),

                Container(

                  child:     Padding(
                    padding: const EdgeInsets.only(left:0, right: 0,top: 0, bottom: 0),

                    child:  Column(
                      children: <Widget>[

                        Divider( height: 1,color: Colors.black,),
                        SizedBox(height: 25,),
                        Padding(

                          padding: const EdgeInsets.only(left: 0.0,top: 8),
                          child: new Row(

                            children: <Widget>[

                              new Text( Textnameq??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,fontSize: 16,color: Colors.lightBlue,fontFamily: "Product Sans" ,),),
                            ],
                          ),
                        ),




                        Divider( height: 1,color: Colors.black,),

                        Padding(

                          padding: const EdgeInsets.only(left:0, right: 0,top: 0, bottom: 0),

                          child:  Row(
                            children: <Widget>[
                              Padding(

                                padding: const EdgeInsets.only(left: 0.0),
                                child: new Row(

                                  children: <Widget>[
                                    Container( width:MediaQuery.of(context).size.width/2,
                                      child :new Text(Emailq??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,fontSize: 16,color: Colors.lightBlue,fontFamily: "Product Sans" ),),
                                    ),  ],
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.only(left:90, right: 0,top: 0, bottom: 0),

                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  icon: Icon(Icons.create),
                                  iconSize: 25,
                                  color: Colors.black,
                                  splashColor: Colors.purple,
                                  onPressed: () {
                                    //   Navigator.of(context).pushReplacementNamed(EDITCREATE);
                                   /* Navigator.push(context, new MaterialPageRoute(
                                        builder: (context) =>
                                        new EditCard(item: konnectid,)));*/
                                  },
                                ),
                              ),
                              Divider(thickness: 2,),

                            ],
                          ),

                        ),
                      ],
                    ),

                  ),
                  width: MediaQuery.of(context).size.width,

                  alignment: Alignment.bottomCenter,
                ),





              ],
            ),
          ),



        ),


      ),

      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      margin: new EdgeInsets.only(left: 0.0),
      decoration: new BoxDecoration(
        image: DecorationImage(
            image: NetworkImage("https://meo.co.in//PhpScript/konnect/images/"),fit: BoxFit.cover
        ),
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(

            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );
    Widget card = Container(
        width: MediaQuery.of(context).size.width-20,
        height:MediaQuery.of(context).size.height/4.2,
        decoration: new BoxDecoration(
          image: DecorationImage(
              image: NetworkImage("https://meo.co.in//PhpScript/konnect/images/"),fit: BoxFit.cover
          ),
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(

              color: Colors.black12,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 15.0,
        ),
        child: new Stack(
          children: <Widget>[
            planetCard,

          ],
        )
    );
    return Scaffold(
      appBar:AppBar(
        title:const  Text(  " Add Basic Information "??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.white,fontFamily: "Product Sans",fontSize: 16 ),),),

      body: ListView(
           children: [
             Container(
               width: MediaQuery.of(context).size.width-20,
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
               child:
               ExpansionTile(
                 leading: Icon(Icons.arrow_drop_down),
                 children: [ListTile(
                   title: ListView(shrinkWrap:true,children:location.map((e) {return
                 Column(
                   children: [
                     Divider(color: Colors.grey,),
                     Text(' ${e.addressLine1 } ${e.addressLine2}${e.addressLine3}',style: TextStyle(fontSize: 12.1,fontWeight: FontWeight.bold),),

                   ],
                 );}).toList()

                 ,),
                   trailing:IconButton(icon:Icon(Icons.delete),color: Colors.red,),leading:IconButton(icon:Icon(Icons.edit,color: Colors.black,))  ,)],


                 title: Padding(

                   padding: const EdgeInsets.only(left: 0.0),
                   child: new Row(

                     children: <Widget>[


                       new Text(  "Office & Location"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),
                     ],
                   ),
                 ),
                 trailing: IconButton(
                   icon: Icon(Icons.add),
                   iconSize: 25,
                   color: Colors.black,
                   splashColor: Colors.purple,
                   onPressed: () {
                     Navigator.push(context, new MaterialPageRoute(
                         builder: (context) =>
                         new MapSample()));
                     //   Navigator.of(context).pushReplacementNamed(EDITCREATE);
                   },
                 ),
               ),),
             SizedBox(height: 5,),
             Container(
               width: MediaQuery.of(context).size.width-20,
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
               child:Column(
                 children: [
                   Container(
                     child:
                     ExpansionTile(
                       leading: Icon(Icons.arrow_drop_down),

                       title: Padding(

                         padding: const EdgeInsets.only(left: 0.0),
                         child: new Row(

                           children: <Widget>[


                             new Text(  "About"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),
                           ],
                         ),
                       ),
                       trailing: IconButton(
                         icon: Icon(Icons.add),
                         iconSize: 25,
                         color: Colors.black,
                         splashColor: Colors.purple,
                         onPressed: () {
                           Navigator.push(context, new MaterialPageRoute(
                               builder: (context) =>
                               new Aboutedit()));
                           //   Navigator.of(context).pushReplacementNamed(EDITCREATE);
                         },
                       ),
                       children: [ListTile(trailing:IconButton(icon:Icon(Icons.delete),color: Colors.red,)
    ,leading:IconButton(icon:Icon(Icons.edit,color: Colors.black,)),
                         title: ListView(shrinkWrap:true,children:about.map((e) {return
    Column(
    children: [
    Divider(color: Colors.grey,),
    Text(' ${e.description }',style: TextStyle(fontSize: 12.1,fontWeight: FontWeight.bold),),

    ],
    );}).toList()

    ,),)],


                     ),),
                   Divider(thickness: 1,color: Colors.black,),
                   ExpansionTile(
                     leading: Icon(Icons.arrow_drop_down),
                     children: [ListTile(trailing:IconButton(icon:Icon(Icons.delete),color: Colors.red,),leading:IconButton(icon:Icon(Icons.edit,color: Colors.black,)),
                         title: ListView(shrinkWrap:true,children:coverimage.map((e) {
                       return
                       Column(
                         children: [
                           Divider(color: Colors.grey,),
                          Image.network(e.image),

                         ],
                       );}).toList()

                       ,))],


                     title: Padding(

                       padding: const EdgeInsets.only(left: 0.0),
                       child: new Row(

                         children: <Widget>[


                           new Text(  "Cover Image"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),
                         ],
                       ),
                     ),
                     trailing: IconButton(
                       icon: Icon(Icons.add),
                       iconSize: 25,
                       color: Colors.black,
                       splashColor: Colors.purple,
                       onPressed: () {/*
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (context) =>
                            new CoverImage()));*/
                         //   Navigator.of(context).pushReplacementNamed(EDITCREATE);
                       },
                     ),
                   ),
                 ],
               ),),
             SizedBox(height: 5,),
             Container(
               width: MediaQuery.of(context).size.width-20,
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
               child:

               ExpansionTile(
                 leading: Icon(Icons.arrow_drop_down),
                 children: [ListTile(trailing:IconButton(icon:Icon(Icons.delete),color: Colors.red,),leading:IconButton(icon:Icon(Icons.edit,color: Colors.black,))  ,)],

                 title: Padding(

                   padding: const EdgeInsets.only(left: 0.0),
                   child: new Row(

                     children: <Widget>[


                       new Text(  "Web Link"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),
                     ],
                   ),
                 ),
                 trailing:IconButton(
                   icon: Icon(Icons.add),
                   iconSize: 25,
                   color: Colors.black,
                   splashColor: Colors.purple,
                   onPressed: () {/*
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                        new WabLink()));*/
                     //   Navigator.of(context).pushReplacementNamed(EDITCREATE);
                   },
                 ),
               ),),

             SizedBox(height: 5,),
             Container(
               width: MediaQuery.of(context).size.width-20,
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
               child:Column(
                 children: [
                   Container(
                     child:
                     ExpansionTile(
                       leading: Icon(Icons.arrow_drop_down),
                       children: [ListTile(trailing:IconButton(icon:Icon(Icons.delete),color: Colors.red,),leading:IconButton(icon:Icon(Icons.edit,color: Colors.black,))  ,)],


                       title: Padding(

                         padding: const EdgeInsets.only(left: 0.0),
                         child: new Row(

                           children: <Widget>[


                             new Text(  "WhatsApp Header"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),
                           ],
                         ),
                       ),
                       trailing:IconButton(
                         icon: Icon(Icons.add),
                         iconSize: 25,
                         color: Colors.black,
                         splashColor: Colors.purple,
                         onPressed: () {/*
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) =>
                              new WhatsappHeader(item:konnectid)));*/
                           //   Navigator.of(context).pushReplacementNamed(EDITCREATE);
                         },
                       ),
                     ),),
                   Divider(thickness: 1,color: Colors.black,),
                   ExpansionTile(
                     leading: Icon(Icons.arrow_drop_down),
                     children: [ListTile(trailing:IconButton(icon:Icon(Icons.delete),color: Colors.red,),leading:IconButton(icon:Icon(Icons.edit,color: Colors.black,))  ,)],


                     title: Padding(

                       padding: const EdgeInsets.only(left: 0.0),
                       child: new Row(

                         children: <Widget>[


                           new Text(  "WhatsApp Message"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),
                         ],
                       ),
                     ),
                     trailing:IconButton(
                       icon: Icon(Icons.add),
                       iconSize: 25,
                       color: Colors.black,
                       splashColor: Colors.purple,
                       onPressed: () {/*
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (context) =>
                            new WhatsappMessage(item:konnectid)));*/
                         //   Navigator.of(context).pushReplacementNamed(EDITCREATE);
                       },
                     ),
                   ),
                 ],
               ),),
             SizedBox(height: 5,),
             Container(
               width: MediaQuery.of(context).size.width-20,
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
               child:
               ExpansionTile(
                 leading: Icon(Icons.arrow_drop_down),
                 children: [ListTile( title: ListView(shrinkWrap:true,children:cuse.map((e) {return
    Column(
    children: [
    Divider(color: Colors.grey,),
    Text(' ${e.title }',style: TextStyle(fontSize: 12.1,fontWeight: FontWeight.bold),),

    ],
    );}).toList()

    ,),



                   trailing:IconButton(icon:Icon(Icons.delete),color: Colors.red,),
                   leading:IconButton(icon:Icon(Icons.edit,color: Colors.black,))  ,)],


                 title: Padding(

                   padding: const EdgeInsets.only(left: 0.0),
                   child: new Row(

                     children: <Widget>[


                       new Text(  "Customer Support"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),
                     ],
                   ),
                 ),
                 trailing: IconButton(
                   icon: Icon(Icons.add),
                   iconSize: 25,
                   color: Colors.black,
                   splashColor: Colors.purple,
                   onPressed: () {
                     /*  Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                        new CustomerSupport(item:konnectid)));*/
                     //   Navigator.of(context).pushReplacementNamed(EDITCREATE);
                   },
                 ),
               ),),
             SizedBox(height: 5,),
             Container(
               width: MediaQuery.of(context).size.width-20,
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
               child:Column(
                 children: [
                   Container(
                     child:
                     ExpansionTile(
                       leading: Icon(Icons.arrow_drop_down),
                       children: [ListTile(trailing:IconButton(icon:Icon(Icons.delete),color: Colors.red,),
                         leading:IconButton(icon:Icon(Icons.edit,color: Colors.black,)),  title: ListView(shrinkWrap:true,children:bank.map((e) {return
                             Column(crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Divider(color: Colors.grey,),
                                 Text(' ${e.bankName } \n ${e.accNo}\n${e.ifscCode}\n${e.upi}',style: TextStyle(fontSize: 12.1,fontWeight: FontWeight.bold),),

                               ],
                             );}).toList()

                             ,) ,)],

                       title: Padding(

                         padding: const EdgeInsets.only(left: 0.0),
                         child: new Row(

                           children: <Widget>[


                             new Text(  "Banking Details"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),
                           ],
                         ),
                       ),
                       trailing:IconButton(
                         icon: Icon(Icons.add),
                         iconSize: 25,
                         color: Colors.black,
                         splashColor: Colors.purple,
                         onPressed: () {

                           //   Navigator.of(context).pushReplacementNamed(EDITCREATE);
                         },
                       ),
                     ),),
                   Divider(thickness: 1,color: Colors.black,),
                   Container(
                     child:
                     ExpansionTile(
                       leading: Icon(Icons.arrow_drop_down),
                       children: [ListTile(trailing:IconButton(icon:Icon(Icons.delete),color: Colors.red,),leading:IconButton(icon:Icon(Icons.edit,color: Colors.black,))  ,)],


                       title: Padding(

                         padding: const EdgeInsets.only(left: 0.0),
                         child: new Row(

                           children: <Widget>[


                             new Text(  "GSTIN"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),
                           ],
                         ),
                       ),
                       trailing:IconButton(
                         icon: Icon(Icons.add),
                         iconSize: 25,
                         color: Colors.black,
                         splashColor: Colors.purple,
                         onPressed: () {

                           //   Navigator.of(context).pushReplacementNamed(EDITCREATE);
                         },
                       ),
                     ),),
                   Divider(thickness: 1,color: Colors.black,),
                   Container(
                     child:
                     ExpansionTile(
                       leading: Icon(Icons.arrow_drop_down),
                       children: [ListTile(trailing:IconButton(icon:Icon(Icons.delete),color: Colors.red,),leading:IconButton(icon:Icon(Icons.edit,color: Colors.black,))  ,)],

                       title: Padding(

                         padding: const EdgeInsets.only(left: 0.0),
                         child: new Row(

                           children: <Widget>[


                             new Text(  "MSME"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),
                           ],
                         ),
                       ),
                       trailing: IconButton(
                         icon: Icon(Icons.add),
                         iconSize: 25,
                         color: Colors.black,
                         splashColor: Colors.purple,
                         onPressed: () {

                           //   Navigator.of(context).pushReplacementNamed(EDITCREATE);
                         },
                       ),
                     ),),
                   Divider(thickness: 1,color: Colors.black,),
                   ExpansionTile(
                     leading: Icon(Icons.arrow_drop_down),
                     children: [ListTile(trailing:IconButton(icon:Icon(Icons.delete),color: Colors.red,),leading:IconButton(icon:Icon(Icons.edit,color: Colors.black,))  ,)],


                     title: Padding(

                       padding: const EdgeInsets.only(left: 0.0),
                       child: new Row(

                         children: <Widget>[


                           new Text(  "Drug License"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),
                         ],
                       ),
                     ),
                     trailing: IconButton(
                       icon: Icon(Icons.add),
                       iconSize: 25,
                       color: Colors.black,
                       splashColor: Colors.purple,
                       onPressed: () {

                         //   Navigator.of(context).pushReplacementNamed(EDITCREATE);
                       },
                     ),
                   ),
                 ],
               ),),
             SizedBox(height: 5,),
             Container(
               width: MediaQuery.of(context).size.width-20,
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
               child:Column(
                 children: [
                   Container(
                     child:
                     ExpansionTile(
                       leading: Icon(Icons.arrow_drop_down),
                       children: [ListTile(trailing:IconButton(icon:Icon(Icons.delete),color: Colors.red,),leading:IconButton(icon:Icon(Icons.edit,color: Colors.black,))  ,)],


                       title: Padding(

                         padding: const EdgeInsets.only(left: 0.0),
                         child: new Row(

                           children: <Widget>[


                             new Text(  "Gallery Header"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),
                           ],
                         ),
                       ),
                       trailing: IconButton(
                         icon: Icon(Icons.add),
                         iconSize: 25,
                         color: Colors.black,
                         splashColor: Colors.purple,
                         onPressed: () {
                           //   Navigator.of(context).pushReplacementNamed(EDITCREATE);

                         },
                       ),
                     ),),
                   Divider(thickness: 1,color: Colors.black,), ExpansionTile(
                     leading: Icon(Icons.arrow_drop_down),
                     children: [ListTile(trailing:IconButton(icon:Icon(Icons.delete),color: Colors.red,),leading:IconButton(icon:Icon(Icons.edit,color: Colors.black,))  ,)],

                     title: Padding(

                       padding: const EdgeInsets.only(left: 0.0),
                       child: new Row(

                         children: <Widget>[


                           new Text(  "Gallery Images"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),
                         ],
                       ),
                     ),
                     trailing: IconButton(
                       icon: Icon(Icons.add),
                       iconSize: 25,
                       color: Colors.black,
                       splashColor: Colors.purple,
                       onPressed: () {
                         //   Navigator.of(context).pushReplacementNamed(EDITCREATE);

                       },
                     ),
                   ),
                 ],
               ),),
             SizedBox(height: 5,),
             Container(
               width: MediaQuery.of(context).size.width-20,
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
               child:Column(
                 children: [
                   Container(
                     child:
                     ExpansionTile(
                       leading: Icon(Icons.arrow_drop_down),
                       children: [ListTile(trailing:IconButton(icon:Icon(Icons.delete),color: Colors.red,),leading:IconButton(icon:Icon(Icons.edit,color: Colors.black,))  ,)],


                       title: Padding(

                         padding: const EdgeInsets.only(left: 0.0),
                         child: new Row(

                           children: <Widget>[


                             new Text(  "Web Store Header"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),
                           ],
                         ),
                       ),
                       trailing: IconButton(
                         icon: Icon(Icons.add),
                         iconSize: 25,
                         color: Colors.black,
                         splashColor: Colors.purple,
                         onPressed: () {

                           //   Navigator.of(context).pushReplacementNamed(EDITCREATE);
                         },
                       ),
                     ),),
                   Divider(thickness: 1,color: Colors.black,),
                   ExpansionTile(
                     children: [ListTile(trailing:IconButton(icon:Icon(Icons.delete),color: Colors.red,),leading:IconButton(icon:Icon(Icons.edit,color: Colors.black,))  ,)],

                     leading: Icon(Icons.arrow_drop_down),

                     title: Padding(

                       padding: const EdgeInsets.only(left: 0.0),
                       child: new Row(

                         children: <Widget>[


                           new Text(  "Web Store Message"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),
                         ],
                       ),
                     ),
                     trailing:IconButton(
                       icon: Icon(Icons.add),
                       iconSize: 25,
                       color: Colors.black,
                       splashColor: Colors.purple,
                       onPressed: () {

                         //   Navigator.of(context).pushReplacementNamed(EDITCREATE);
                       },
                     ),
                   ),
                 ],
               ),),
             SizedBox(height: 5,),

             Container(
               width: MediaQuery.of(context).size.width-20,
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
               child:
               ExpansionTile(
                 children: [ListTile(trailing:IconButton(icon:Icon(Icons.delete),color: Colors.red,),leading:IconButton(icon:Icon(Icons.edit,color: Colors.black,))  ,)],

                 leading: Icon(Icons.arrow_drop_down),

                 title: Padding(

                   padding: const EdgeInsets.only(left: 0.0),
                   child: new Row(

                     children: <Widget>[


                       new Text(  "Master Category"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),
                     ],
                   ),
                 ),
                 trailing: IconButton(
                   icon: Icon(Icons.add),
                   iconSize: 25,
                   color: Colors.black,
                   splashColor: Colors.purple,
                   onPressed: () {
                     //   Navigator.of(context).pushReplacementNamed(EDITCREATE);

                   },
                 ),
               ),),
             SizedBox(height: 5,),
             Container(

               width: MediaQuery.of(context).size.width-20,
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
               child:
               ExpansionTile(
                 children: [ListTile(trailing:IconButton(icon:Icon(Icons.delete),color: Colors.red,),leading:IconButton(icon:Icon(Icons.edit,color: Colors.black,))  ,)],

                 leading: Icon(Icons.arrow_drop_down),



                 title: Padding(

                   padding: const EdgeInsets.only(left: 0.0),
                   child: new Row(

                     children: <Widget>[


                       new Text(  "Sub Category"??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),
                     ],
                   ),
                 ),
                 trailing: IconButton(
                   icon: Icon(Icons.add),
                   iconSize: 25,
                   color: Colors.black,
                   splashColor: Colors.purple,
                   onPressed: () {
                     //   Navigator.of(context).pushReplacementNamed(EDITCREATE);

                   },
                 ),
               ),),
             SizedBox(height: 5,),

           ],

            ),


    );
  }
}

