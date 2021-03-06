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




class withbankQr extends StatefulWidget {
  final KonnectDetails konnectDetails;

  withbankQr(this.konnectDetails);
  @override
  _withbankQrState createState() => new _withbankQrState();
}

class _withbankQrState extends State<withbankQr> {
  GlobalKey _globalKey = new GlobalKey();
  //String dropdownValue = "ICCI";
  Bank bankValue;
  BasicInfo basicInfo;
  List<Location>location= new List();
  List<Bank> bank = new List();
  List<GstIn>gst=new List();
  bool inside = false;
  Uint8List imageInMemory;

  List<Map> _list;
  Widget _picture;
  String _upi;
  bool flaglink=false;
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

  @override
  void initState() {

    // pr.show();

    basicInfo = widget.konnectDetails.basicInfo;
    print('vikas${widget.konnectDetails.coverImage[0].image}');
    location = widget.konnectDetails.location;
    bank = widget.konnectDetails.bank;
    gst = widget.konnectDetails.gstin;

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
      bankValue = bank[0];
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
      String note =  'konnect';
      String name = basicInfo.organisation.replaceAll(' ', '+');
      String bankaa = '${bankValue.accNo}@${bankValue.ifscCode}.ifsc.npci';
      String upi = bankValue.upi.isEmpty ? bankaa : bankValue.upi;

      _upi = 'upi://pay?pa=$upi&pn=$name&tn=$note';
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
                     text: ' Here my BUSINESS CARD with \n a banking QR code to pay \n *${ basicInfo.organisation}* \n'
                         'Get a similar Business card for  yourself at konnectmybusiness.com',
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
            title: new Text(' Share UPI QR '),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<Bank>(
                  isExpanded: true,
                  value: bankValue,
                  hint: Text('Select bank UPI'),
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black87, fontSize: 18),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0)),
                  ),
                  onChanged: (Bank data) {
                    setState(() {
                      bankValue = data;
                     onChanged();
                    });
                  },
                  items: widget.konnectDetails.bank.map<DropdownMenuItem<Bank>>((Bank value) {
                    return DropdownMenuItem<Bank>(
                      value: value,
                      child: Text(
                        value.upi.isEmpty ? value.bankName : value.upi,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height:20),

              RepaintBoundary(
                key: _globalKey,
              child:
              Card(shadowColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0,10,10,10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(basicInfo.organisation,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(flaglink?details.basicInfo.name:basicInfo.name,style: TextStyle(color: Colors.blue,fontSize: 14,fontWeight: FontWeight.bold),),
                      ),
                      Row(
                        children: [

                             Container(
                                width:Width*0.65,
                                child:Column(children: [
                                 Row(children: [
                                  Icon(Icons.phone),
                                  Text(flaglink?details.basicInfo.mobileNumber:basicInfo.mobileNumber)

                                ],
                                ),
                                SizedBox(height: 10,),
                                Row(children: [
                                  Icon(Icons.email),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(flaglink?details.basicInfo.email:basicInfo.email),
                                      ],
                                    ),
                                  )

                                ],
                                ),
                                 SizedBox(height: 10,),
                                 Row(children: [
                                  Icon(Icons.location_on),

                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text('${location[0].addressLine1}\n ${location[0].addressLine2} \n${location[0].addressLine3}'),
                                            ],
                                          ),
                                        ),




                                ],
                                ),
                              ],)),

                          Expanded(child: Container(child: QrImage(
                              data: _upi,
                              version: QrVersions.auto,
                              size: 120.0,
                            ),)),

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

