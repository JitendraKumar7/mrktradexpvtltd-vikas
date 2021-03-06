import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:mrktradexpvtltd/ui/base/libraryExport.dart';

class wspbusiness extends StatefulWidget{
  final KonnectDetails konnectDetails;
  wspbusiness(this.konnectDetails);
  @override
  State<StatefulWidget> createState() {
   return wspbusinessstate();
  }
}
class wspbusinessstate extends State<wspbusiness>{
var height;
 List imageList;
 ProgressDialog pr;
@override
  void initState() {
imageList= new List();
    super.initState();
    BasicInfo basicInfo=widget.konnectDetails.basicInfo;
    imageList =basicInfo.imageWhatsappBusiness;

  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');

   // double width = MediaQuery.of(context).size.height;
    double Height = MediaQuery.of(context).size.height;
    double Width= MediaQuery.of(context).size.width;

    return Scaffold(
       appBar: AppBar(title: Text("Share on business Whatsapp"),),
     body:


        Container(
          height: Height,
          width: Width,
          child: Column(
            children: [
              imageList!=null?Container(
                height: Height*0.60,
                child:    GFCarousel(
                  height:Height*0.60,
                  items: imageList.map(
                        (url) {


                          return Container(


                        margin: EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Image.network(
                            url,
                           // fit: BoxFit.fitHeight,

                          ),
                        ),
                      );
                    },
                  ).toList(),
                  onPageChanged: (index) {
                    setState(() {
                      index;
                    });
                  },
                ),
              ): Container(
                width: MediaQuery.of(context).size.height,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: GFLoader(loaderColorOne: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(child:
                Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  height: 50.0,
                  child: GestureDetector(
                    onTap: () {
                      FlutterShareMe()
                          .shareToWhatsApp4Biz( msg: '${AppConstants().SHARE_CARDVIEW}');
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
                padding: const EdgeInsets.all(8.0),
                child: Expanded(child:
                Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  height: 50.0,
                  child: GestureDetector(
                    onTap: () {
                      FlutterShareMe()
                          .shareToWhatsApp4Biz( msg: '${AppConstants().SHARE_CARDVIEW}');

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
                              "Share Store View",
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
                padding: const EdgeInsets.all(8.0),
                child: Expanded(child:
                Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  height: 50.0,
                  child: GestureDetector(
                    onTap: () {
                      FlutterShareMe()
                          .shareToWhatsApp4Biz( msg: '${AppConstants().SHARE_WEBVIEW}');
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
        ),

   );
  }
}