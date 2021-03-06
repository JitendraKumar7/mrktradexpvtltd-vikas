import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:mrktradexpvtltd/modal/KonnectDetails.dart';
import 'package:mrktradexpvtltd/ui/base/libraryExport.dart';




class withcardwebstorelink extends StatefulWidget {
  final KonnectDetails konnectDetails;

  withcardwebstorelink(this.konnectDetails);
  @override
  createState() => new _withcardwebstorelinkState();
}

class _withcardwebstorelinkState extends State<withcardwebstorelink> {
  GlobalKey _globalKey = new GlobalKey();
  //String dropdownValue = "ICCI";
  Bank bankValue;
  BasicInfo basicInfo;
  List<Location>location= new List();
  List<Bank> bank = new List();
  List<GstIn>gst=new List();
  bool inside = false;
  Uint8List imageInMemory;
  Map profile, response;
  UserProfile profiles;
  UserAdmin adminprofile;
  String adminkonnectid, linkkonnectid, linkuserid;
  Map linkresult;
  bool fileflag = false;
  KonnectDetails details ;
  UserLogin login;
  String accountid, addfile = "";
  String name="";
  String note;
  ProgressDialog pr;
  String _upi;
  bool  flaglink = false;

  @override
  void initState() {

    // pr.show();

    basicInfo = widget.konnectDetails.basicInfo;
    print('vikas${widget.konnectDetails.coverImage[0].image}');
    location = widget.konnectDetails.location;
    bank = widget.konnectDetails.bank;
    gst = widget.konnectDetails.gstin;
    setState(() {
      note=AppConstants().SHARE_STORE;


      _upi = '$note';
    });

    String keya = AppConstants.USER_LOGIN_DATA;
    AppPreferences.getString(keya).then((value) => {
      setState(() {
        Map<String, dynamic> response = jsonDecode(value);

        adminprofile = UserAdmin.fromJson(response);
        linkuserid = adminprofile.id.toString();

        ApiAdmin().getLinkUserKonnectid(adminprofile.id).then((value) => {
          setState(() {
            Map<String, dynamic> response = value.data;
            print(response);
            if(response['result'][0]!=null){
              linkresult = response['result'][0];}
            linkkonnectid = linkresult['link_user_konnect_id'].toString();
            adminkonnectid = linkresult['konnect_id'].toString();
            print(linkkonnectid);

            ApiClient().getCardLinkDetails(linkkonnectid, linkuserid).then((value) {
              Map response = value.data;


              if (response['status'] == '200') {
                Map result = response['result'];
                //  String expireresult = result['basicInfo']['expire'].toString();
                String key1 = AppConstants.KONNECT_DATA;
                AppPreferences.setString(key1, jsonEncode(result));

                details = KonnectDetails.fromJson(result);
                setState(() {
                  flaglink = true;
                  note = '$AppConstants.SHARE_STORE';
                  _upi = '$note';
                  name=details.basicInfo.name;
                });

                print(name);


              } });
          })
        });
        print("vikas");
      })
    });

    if (widget.konnectDetails.bank.length > 0) {
      bankValue = widget.konnectDetails.bank[0];
      onChanged();
    }

  }
  Future<Uint8List> _capturePng() async {
    try {
      print('inside');
      inside = true;
      RenderRepaintBoundary boundary = _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
//      String bs64 = base64Encode(pngBytes);
//      print(pngBytes);
//      print(bs64);
      print('png done');
      setState(() {
        imageInMemory = pngBytes;
        inside = false;
      });
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }
  void onChanged() {
    setState(() {

      print(_upi);
    });
  }
  @override
  Widget build(BuildContext context) {
    double Height = MediaQuery.of(context).size.height;
    double Width= MediaQuery.of(context).size.width;



    return
      new Scaffold(
          floatingActionButton:   Padding(
            padding: const EdgeInsets.only(left:40.0,top:10,right:40,bottom: 0),
            child: Row(
              children: [
                Expanded(child:
                Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  height: 50.0,
                  child: GestureDetector(
                    onTap: () async {
                      _capturePng();
                      if(   imageInMemory != null) {

                        final documentDirectory = (await getExternalStorageDirectory())
                            .path;

                        File imgFile = new File('$documentDirectory/sharewithimage.jpg');
                        imgFile.writeAsBytesSync(imageInMemory);
                        print(imgFile);
                        Share.shareFiles([imgFile.path,],
                          // subject: '${AppConstants.SHARE_APP} ${AppConstants.SHARE_STORE} https://meo.co.in/konnect-link/konnect-new/productMart/singleProduct.php?kid=$AppConstants.konnect_id=&subcid=${""}&pid=MTU',
                          text: ' Here WEB Store of \n'
                              '*${basicInfo.organisation}*'
                              'Please open to view  all the product & sevices . You can order online from here :'
                              '${note}',
                          // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
                          //  text:''
                        );
                      }
                    },
                    child: Container(

                      decoration: BoxDecoration(

                        border: Border.all(
                          color: Color(0xFFF05A22),
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        color: Color(0xFFF05A22),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text(
                              "Share ",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )


                ),
              ],
            ),
          ) ,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          appBar: new AppBar(
            title: new Text(' Share Card WebStore'),
          ),
          body: Column(
            children: [

              SizedBox(height:20),

              RepaintBoundary(
                key: _globalKey,
                child:
                Card(shadowColor: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0,10,10,10),
                    child: Column(
                      children: [

                        Row(
                          children: [

                            Expanded(
                              child: Stack(
                                children:<Widget> [

                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(height: Height*0.25,
                                        child: Expanded(
                                            child:Container(
                                              child: Image(
                                                fit: BoxFit.cover,
                                                image: NetworkImage('${widget.konnectDetails.coverImage[0].image}'),
                                              ),
                                            )
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, 8, 0, 5),
                                        child: Text(
                                          basicInfo.organisation,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, 5, 0, 12),
                                        child: Text(
                                          basicInfo.categoryOfBusiness,
                                          style: TextStyle(fontSize: 13, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Positioned.fill(
                                    left: 0.0,
                                    bottom: 30.0,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: FadeInImage.assetNetwork(
                                        image: basicInfo.konnectLogo,
                                        placeholder: 'images/ic_konnect.png',
                                        height: 80,
                                        width: 60,
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    left: 0.0,
                                    bottom: 30.0,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(height: 20,),
                                          Container(color: Colors.white.withOpacity(0.65),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(flaglink==true?details.basicInfo.name:basicInfo.name,style:TextStyle(color:Colors.red,fontWeight: FontWeight.bold,fontSize: 14),),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Container(color: Colors.white.withOpacity(0.65),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Text(flaglink==true?details.basicInfo.designation:basicInfo.designation,style:TextStyle(color:Colors.red,fontWeight: FontWeight.bold,fontSize: 12),),
                                                )),
                                          )
                                        ],)
                                    ),
                                  ),



                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(children: [
                          Text(""),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('powered by',style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold)
                                ),
                              ],
                            ),
                          ),




                        ],
                        ),
                        SizedBox(height: 10,),
                        Row(children: [
                          Text(""),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('KONNECT MY BUSINESS.COM',style: TextStyle(color: Colors.grey,fontSize: 12,fontWeight: FontWeight.bold)



                                ),
                              ],
                            ),
                          ),




                        ],
                        ),

                      ],
                    ),
                  ),
                ),),





            ],
          ));

  }
}

