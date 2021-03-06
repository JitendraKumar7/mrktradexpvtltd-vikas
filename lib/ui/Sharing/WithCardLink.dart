import 'dart:io';

import 'package:http/http.dart';
import 'package:mrktradexpvtltd/ui/base/libraryExport.dart';
import 'package:path_provider/path_provider.dart';

class WithCardlink extends StatefulWidget{
  final KonnectDetails konnectDetails;

  WithCardlink(this.konnectDetails);
  @override
  State<StatefulWidget> createState() {
    return WithCardLinkState();
  }
}
class WithCardLinkState extends State<WithCardlink>{
  List<Map> _list;
  Widget _picture;
  String _upi;
  Map profile, response;
  Bank bankValue;
  BasicInfo basicInfo;
  List<Location>location= new List();
  List<Bank> bank = new List();
  List<GstIn>gst=new List();
  bool inside = false;

  UserProfile profiles;
  UserAdmin adminprofile;
  String adminkonnectid, linkkonnectid, linkuserid;
  Map linkresult;
  bool fileflag = false;
  bool flaglink= false;
  KonnectDetails details ;
  UserLogin login;
  String accountid, addfile = "";
  String name="";
  String noteweb;
  String notecard;

  @override
  void initState() {

    // pr.show();

    basicInfo = widget.konnectDetails.basicInfo;
    print('vikas${widget.konnectDetails.coverImage[0].image}');
    location = widget.konnectDetails.location;
    bank = widget.konnectDetails.bank;
    gst = widget.konnectDetails.gstin;
    setState(() {
      noteweb=AppConstants().SHARE_WEBVIEW;
      notecard=AppConstants().SHARE_CARDVIEW;



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

                  noteweb = 'https://meo.co.in/konnect-link/konnect-new/konnect-newlink.php?konnect_id=$linkkonnectid';
                  notecard='https://meo.co.in/konnect-pro/konnect-prolink.php?konnect_id=$linkkonnectid';

                  name=details.basicInfo.name;
                });

                print(name);


              } });
          })
        });
        print("vikas");
      })
    });



  }
  @override
  Widget build(BuildContext context) {
    print('${widget.konnectDetails}');
    BasicInfo basicInfo = widget.konnectDetails.basicInfo;
    print('vikas${widget.konnectDetails.coverImage[0].image}');

    double width = MediaQuery.of(context).size.height;
   return Scaffold(

     appBar: AppBar(title: Text('Share with Card Link'),),
     body: Column(
       children: [
     Expanded(
           child: Stack(
             children:<Widget> [

               Column(
                 mainAxisSize: MainAxisSize.max,
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: <Widget>[
                   Container(height: width*0.45,
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
         Padding(
           padding: const EdgeInsets.only(left:40.0,top:10,right:40,bottom: 20),
           child: Expanded(child:
           Container(
             padding: EdgeInsets.only(left: 10.0, right: 10.0),
             height: 50.0,
             child: GestureDetector(
               onTap: () async {

                 var url = '${widget.konnectDetails.coverImage[0].image}';
                 print(url);
                 var response = await get(url);
                 final documentDirectory = (await getExternalStorageDirectory()).path;
                 //  String desc = "<bold>Hello<bold> World";
                 //new Text(desc);
                 File imgFile = new File('$documentDirectory/productshare.jpg');
                 imgFile.writeAsBytesSync(response.bodyBytes);
                 print(imgFile);
                 Share.shareFiles([imgFile.path,],
                  // subject: '${AppConstants.SHARE_APP} ${AppConstants.SHARE_STORE} https://meo.co.in/konnect-link/konnect-new/productMart/singleProduct.php?kid=$AppConstants.konnect_id=&subcid=${""}&pid=MTU',
                   text: '*${  basicInfo.organisation} ,${basicInfo.categoryOfBusiness}*  ${notecard} ',
                   // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
                   //  text:''
                 );





               },
               child: Container(

                 decoration: BoxDecoration(
                   border: Border.all(
                     color: Color(0xFFF05A22),
                     style: BorderStyle.solid,
                     width: 1.0,
                   ),
                   color: Colors.transparent,
                   borderRadius: BorderRadius.circular(30.0),
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Center(
                       child: Text(
                         "Share Card View",
                         style: TextStyle(
                           color: Color(0xFFF05A22),
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
         ),

         Padding(
           padding: const EdgeInsets.only(left:40.0,top:10,right:40,bottom: 20),
           child: Expanded(child:
           Container(
             padding: EdgeInsets.only(left: 10.0, right: 10.0),
             height: 50.0,
             child: GestureDetector(
               onTap: () async {

                 var url = '${widget.konnectDetails.coverImage[0].image}';
                 print(url);
                 var response = await get(url);
                 final documentDirectory = (await getExternalStorageDirectory()).path;
                 //  String desc = "<bold>Hello<bold> World";
                 //new Text(desc);
                 File imgFile = new File('$documentDirectory/productshare.jpg');
                 imgFile.writeAsBytesSync(response.bodyBytes);
                 print(imgFile);
                 Share.shareFiles([imgFile.path,],
                 // subject: '${AppConstants.SHARE_APP} ${AppConstants.SHARE_STORE} https://meo.co.in/konnect-link/konnect-new/productMart/singleProduct.php?kid=$AppConstants.konnect_id=&subcid=${""}&pid=MTU',
                 text: '*${  basicInfo.organisation} ,${basicInfo.categoryOfBusiness}*  ${noteweb} ',
                 // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
                 //  text:''
                 );

               },
               child: Container(

                 decoration: BoxDecoration(
                   border: Border.all(
                     color: Color(0xFFF05A22),
                     style: BorderStyle.solid,
                     width: 1.0,
                   ),
                   color: Colors.transparent,
                   borderRadius: BorderRadius.circular(30.0),
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Center(
                       child: Text(
                         "Share Web View",
                         style: TextStyle(
                           color: Color(0xFFF05A22),
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
         ),

       ],
     ),
   );
  }
}