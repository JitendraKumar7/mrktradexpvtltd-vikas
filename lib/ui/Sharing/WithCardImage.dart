
import 'dart:io';
import 'package:http/http.dart';
import 'package:mrktradexpvtltd/ui/base/libraryExport.dart';
class WithCardImage extends StatefulWidget{
  final KonnectDetails konnectDetails;

  WithCardImage(this.konnectDetails);
  @override
  State<StatefulWidget> createState() {
    return WithCardImageState();
  }
}
class WithCardImageState extends State<WithCardImage>{
  Bank bankValue;
  BasicInfo basicInfo;
  List<Location>location= new List();
  List<Bank> bank = new List();
  List<GstIn>gst=new List();
  bool gstValue=true;
  bool headValue=true;
  bool branchValue=true;
  bool bank1Value=true;
  bool bank2Value=true;
  bool bank3Value=true;
  String noteweb;
  String notecard;
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
String Gst="";
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
List<Location>location= widget.konnectDetails.location;
List<Bank> bank=widget.konnectDetails.bank;
List<GstIn>gst=widget.konnectDetails.gstin;
    double width = MediaQuery.of(context).size.height;
    return Scaffold(
floatingActionButton:     Padding(
  padding: const EdgeInsets.only(left:40.0,top:10,right:40,bottom: 0),
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
        File imgFile = new File('$documentDirectory/sharewithimage.jpg');
        imgFile.writeAsBytesSync(response.bodyBytes);
        print(imgFile);
        Share.shareFiles([imgFile.path,],
          // subject: '${AppConstants.SHARE_APP} ${AppConstants.SHARE_STORE} https://meo.co.in/konnect-link/konnect-new/productMart/singleProduct.php?kid=$AppConstants.konnect_id=&subcid=${""}&pid=MTU',
          text: '*${  basicInfo.organisation}* \n'
              '\n'
              '${basicInfo.categoryOfBusiness} \n'
              '\n'
              '\n'
              '${headValue==true?'*HEAD OFFICE :* \n${location[0].addressLine1}${location[0].addressLine2}${location[0].addressLine3}\n'
          '\n'
              '\n':''}'
              '${branchValue==true?'*BRANCH OFFICE:*\n ${ gstValue==true?location[1].addressLine1:"Rohit"}${location[1].addressLine2}${location[1].addressLine3}'
              '\n'
              '\n':""}'
              '*BANKING*\n '
              '${bank1Value==true?'Bank: ${bank[0].bankName },\nIFSC Code:${bank[0].ifscCode},\nAccount No:${bank[0].accNo} ,\n UPI ID:${bank[0].upi}'
              '\n':""}'


              '${bank2Value==true?'Bank: ${bank[1].bankName },\nIFSC Code:${bank[1].ifscCode},\nAccount No:${bank[1].accNo} ,\n UPI ID:${bank[1].upi}':""}'
              '\n'

              '${bank3Value==true?"Bank:":""}: ${bank3Value==true?bank[2].bankName:"" },\n${bank3Value==true?"IFSC:":""}${bank3Value==true?bank[2].ifscCode:""},\n${bank3Value==true?"Account No.:":""}${bank3Value==true?bank[2].accNo:""} ,\n ${bank3Value==true?"UPI ID":""}${bank3Value==true?bank[2].upi:""}'

              ' \n'
          '\n'
              '${gstValue==true?"*GST IN:*":""}\n'
              '${gstValue==true?"gst in:":""} ${gstValue==true?gst[0].gstin:""}\n ${gstValue==true?"State:":""}${gstValue==true?gst[0].state:""},\n'
              ' \n'
              '\n'
              ' \n'
              '\n'
              ''
              'To Create & share Similar Business card for your business,Download\n *KONNECT MY  BUSINESS*  \n application'
              ' ${AppConstants.SHARE_KMB} ',
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
),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(title: Text('Share with Card Image'),),
      body: ListView(
        children: [
          Expanded(
            child: Stack(
              children:<Widget> [

                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(height: width*0.25,
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
            padding: const EdgeInsets.all(8.0),
            child: Text("HEAD OFFICE:",style: TextStyle(color:Colors.grey,fontWeight: FontWeight.bold),),
          ),
          Card(
            shadowColor: Colors.grey,
            child: Container(padding: const EdgeInsets.all(8.0),
              child: CheckboxListTile(
                title: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${location[0].addressLine1} ,${location[0].addressLine2},${location[0].addressLine3}'),

                    ],
                  ),
                ),
                value: headValue,
                onChanged: (newValue) {
                  setState(() {
                    headValue = newValue;

                  });
                },
                controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("BRANCH OFFICE:",style: TextStyle(color:Colors.grey,fontWeight: FontWeight.bold),),
          ),
          Card(
            shadowColor: Colors.grey,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: CheckboxListTile(
                title: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${location[1].addressLine1} ,${location[1].addressLine2},${location[1].addressLine3}'),

                    ],
                  ),
                ),
                value: branchValue,
                onChanged: (newValue) {
                  setState(() {
                    branchValue = newValue;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
              ),
            ),
          ),
          Divider(color: Colors.grey,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("BANKING:",style: TextStyle(color:Colors.grey,fontWeight: FontWeight.bold),),
          ),
          Divider(color: Colors.grey,),
          Card(shadowColor: Colors.grey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 4),
              child: CheckboxListTile(
                title:Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bank: ${bank[0].bankName },\nIFSC Code:${bank[0].ifscCode},\nAccount No:${bank[0].accNo} ,\n UPI ID:${bank[0].upi}'),

                    ],
                  ),
                ),
                value: bank1Value,
                onChanged: (newValue) {
                  setState(() {
                    bank1Value = newValue;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
              ),
            ),
          ),
          Card(shadowColor: Colors.grey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 4),
              child: CheckboxListTile(
                title:Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bank: ${bank[1].bankName },\nIFSC Code: ${bank[1].ifscCode},\nAccount No: ${bank[1].accNo} ,\n UPI ID:${bank[1].upi}'),

                    ],
                  ),
                ),
                value: bank2Value,
                onChanged: (newValue) {
                  setState(() {
                    bank2Value = newValue;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
              ),
            ),
          ),
          Card(shadowColor: Colors.grey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 4),
              child: CheckboxListTile(
                title: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bank: ${bank[2].bankName },\nIFSC Code:${bank[2].ifscCode},\nAccount No:${bank[2].accNo} ,\n UPI ID:${bank[2].upi}'),

                    ],
                  ),
                ),
                value: bank3Value,
                onChanged: (newValue) {
                  setState(() {
                    bank3Value = newValue;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
              ),
            ),
          ),
          Divider(color: Colors.grey,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("GSTIN:",style: TextStyle(color:Colors.grey,fontWeight: FontWeight.bold),),
          ),
          Divider(color: Colors.grey,),
          Card(shadowColor: Colors.grey,
            child: Container( padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 4),
              child: CheckboxListTile(
                title:Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('GST IN: ${gst[0].gstin},\n STATE:${gst[0].state.toLowerCase()},\n '),

                    ],
                  ),
                ),
                value: gstValue,
                onChanged: (newValue) {
                  setState(() {
                    gstValue = newValue;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
              ),
            ),
          ),
SizedBox(height: 90,),



        ],
      ),
    );
  }
}