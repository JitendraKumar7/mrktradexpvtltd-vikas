import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mrktradexpvtltd/ui/EditCard/EditCardScreen.dart';

import 'package:mrktradexpvtltd/ui/Sharing/WithCardImage.dart';
import 'package:mrktradexpvtltd/ui/Sharing/WithCardLink.dart';
import 'package:mrktradexpvtltd/ui/Sharing/withBankQR.dart';
import 'package:mrktradexpvtltd/ui/Sharing/withbusinessinfoQR.dart';
import 'package:mrktradexpvtltd/ui/Sharing/withcardwebstorelink.dart';
import 'package:mrktradexpvtltd/ui/Sharing/withfile.dart';
import 'package:mrktradexpvtltd/ui/Sharing/withgpslocation.dart';
import 'package:mrktradexpvtltd/ui/Sharing/wspbusiness.dart';
import 'package:mrktradexpvtltd/ui/admin/AdminLinkUsers.dart';
import 'package:mrktradexpvtltd/ui/admin/AdminSalesQuotation.dart';

import '../base/libraryExport.dart';
class sharemodel{
  String Title;
  IconData icondata;

  sharemodel(this.Title, this.icondata);


}
class AdminDashboardScreen extends StatefulWidget {
  final KonnectDetails konnectDetails;
  final String login;

  AdminDashboardScreen(this.konnectDetails, this.login);

  @override
  State<StatefulWidget> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboardScreen> {
  List<CartSummery> cart = List<CartSummery>();
  UserAdmin profile;
  sharemodel s;
  bool isButtonPressed = false;
  List<sharemodel> buttonname= [
    new sharemodel("On Android",FontAwesomeIcons.android ),
  new sharemodel("On ios",FontAwesomeIcons.appStoreIos ),
  new sharemodel("on whatsapp business",FontAwesomeIcons.whatsapp ),
  new sharemodel("with Card Link",Icons.link ),
    new sharemodel("with Card Image",Icons.image, ),
  new sharemodel("with UPI QR Code",FontAwesomeIcons.wallet ),
  new sharemodel("with geo Location",Icons.location_on ),
  new sharemodel("with any file  Link", Icons.attach_file),
  new sharemodel("with business info QR",Icons.qr_code, ),
  new sharemodel("with New Year Wish",Icons.card_giftcard, ),
  new sharemodel("with cardwebstore link",Icons.shopping_cart_rounded ),

  ];

   String e="";
  @override
  void initState() {
    super.initState();
    s=new sharemodel("vikas", FontAwesomeIcons.android);
    print(s);
    String key = AppConstants.USER_LOGIN_DATA;
    AppPreferences.getString(key).then((value) => {
          setState(() {
            Map<String, dynamic> response = jsonDecode(value);
            profile = UserAdmin.fromJson(response);
            print(profile.toJson());
          })
        });
    onBackPressed();
  }

  onBackPressed() {
    print('Back Pressed');
    String key = AppConstants.USER_CART_DATA;
    AppPreferences.getString(key).then((value) => {
          setState(() {
            if (value != null) {
              cart = List<CartSummery>();
              for (Map json in jsonDecode(value)) {
                cart.add(CartSummery.fromJson(json));
              }
            }
          })
        });
  }

  Widget getCart() {
    return cart.isEmpty
        ? IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => OrderCartScreen(),
                ),
              ).then(
                (value) => onBackPressed(),
              );
            })
        : GFIconBadge(
            child: GFIconButton(
              size: GFSize.LARGE,
              color: Colors.transparent,
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => OrderCartScreen(),
                  ),
                ).then(
                  (value) => onBackPressed(),
                );
              },
            ),
            counterChild: GFBadge(
              shape: GFBadgeShape.circle,
              color: Colors.orangeAccent,
              child: Text(cart.length.toString()),
            ),
          );
  }

  Widget getProfile() {
    bool isEmpty = profile == null
        ? true
        : profile.image == null ? true : profile.image.isEmpty;

    return isEmpty
        ? Icon(
            Icons.perm_identity,
            size: 48,
          )
        : FadeInImage.assetNetwork(
            width: 80,
            height: 80,
            image: profile.image,
            placeholder: 'images/iv_empty.png',
          );
  }

  String getProfileName() {
    bool isEmpty = profile == null
        ? true
        : profile.name == null ? true : profile.name.isEmpty;

    return isEmpty
        ? widget.konnectDetails.basicInfo.organisation
        : profile.name;
  }

  String getProfileContact() {
    bool isEmpty = profile == null
        ? true
        : profile.contact == null ? true : profile.contact.isEmpty;

    return isEmpty
        ? widget.konnectDetails.basicInfo.categoryOfBusiness
        : profile.contact;
  }
  ProgressDialog pr;
  @override
  Widget build(BuildContext context) {
    double Height = MediaQuery.of(context).size.height;
    double Width= MediaQuery.of(context).size.width;
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');
    BasicInfo basicInfo = widget.konnectDetails.basicInfo;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
      appBar: AppBar(
        title: Text('????????????????????? / welcome'),
        actions: <Widget>[
          getCart(),
          IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        " Share",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                      content: Container(height: Height*0.70,
                                width: Width*0.75,
                                child:
                                ListView(
                                  shrinkWrap: true,
                                  children:buttonname.map((e) {
                                      return
                                    Padding(
                                      padding: const EdgeInsets.only(left:0.0,top:0,right:0,bottom: 0),
                                      child: Row(
                                        children: [
                                          Expanded(child:
                                          Container(
                                            padding: EdgeInsets.only(left: 0.0, right: 0.0),
                                            height: 55.0,
                                            child: GestureDetector(
                                              child: Column(
                                                children: [



                                                     Container(

                                                      decoration: BoxDecoration(


                                                        color:Colors.white,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: <Widget>[

                                                          Padding(
                                                            padding: const EdgeInsets.all(0.0),
                                                            child: Icon(e.icondata,color:Colors.lightBlue,size:20,),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left:5.0),
                                                            child: Center(

                                                              child: Text(e.Title,

                                                                style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontFamily: 'Montserrat',
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w600,
                                                                  letterSpacing: 1,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),

                                                  Divider(color: Colors.grey,)
                                                ],
                                              ),
                                              onTap: () async {

    pr.show();
    Future.delayed(Duration(
    seconds: 1))
        .then((value) {
    pr
        .hide()
        .whenComplete(() {





                                                if(e.Title=="On Android"){
                                                Navigator.pop(context);
                                                 Share.share('${AppConstants.SHARE_APP}');
                                                }else
                                                if (e.Title=="On ios"){
                                                  Navigator.pop(context);
                                                  Share.share('https://apps.apple.com/in/app/mrk-tradex/id1535832758');

                                                }
                                                else if(e.Title=="on whatsapp business"){



                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context) => wspbusiness(widget.konnectDetails),
                                                    ),
                                                  );
                                                }
                                                else  if(e.Title=="with Card Link"){
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context) => WithCardlink(widget.konnectDetails),
                                                    ),
                                                  );
                                                }
                                                else  if(e.Title=="with Card Image"){
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context) => WithCardImage(widget.konnectDetails),
                                                    ),
                                                  );
                                                }
                                                else  if(e.Title=="with UPI QR Code"){
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context) =>withbankQr(widget.konnectDetails) ,
                                                    ),
                                                  );
                                                }
                                                else  if(e.Title=="with geo Location"){
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context) =>withgpslocation(widget.konnectDetails) ,
                                                    ),
                                                  );
                                                }
                                                else  if(e.Title=="with any file  Link"){
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context) =>withfile(widget.konnectDetails) ,
                                                    ),
                                                  );
                                                }
                                                else  if(e.Title=="with business info QR"){
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context) =>withbusinessinfoQR(widget.konnectDetails) ,
                                                    ),
                                                  );
                                                }
                                                else  if(e.Title=="with cardwebstore link"){
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context) =>withcardwebstorelink(widget.konnectDetails) ,
                                                    ),
                                                  );}
                                                });});
                                              },

                                            ),
                                          )


                                          ),
                                        ],
                                      ),
                                    ); }).toList(),



                                ),
                              ),
                    
                    );
                  },
                );
              }),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                height: 180,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: getProfile(),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 5),
                        child: Text(getProfileName())),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 30),
                        child: Text(getProfileContact())),
                  ],
                )),
            Divider(),
            ListTile(
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),

              ),
              leading: Icon(Icons.group),
              title: Text('Edit Card'),
              onTap: () async {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => EditCardcreate(widget.konnectDetails),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),

              ),
              leading: Icon(Icons.group),
              title: Text('Party Master'),
              onTap: () async {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => AdminPartyMasterScreen(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),

              ),
              leading: Icon(Icons.link),
              title: Text('My Link Users'),
              onTap: () async {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => AdminLinkUserScreen(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),

              ),
              leading: Icon(Icons.shopping_cart),
              title: Text('Item Master'),
              onTap: () async {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ProductSearchScreen(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),

              ),
              leading: Icon(Icons.insert_drive_file_rounded),
              title: Text('Sales Quotation / Purchase order'),
              onTap: () async {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => AdminSalesQuotationScreen(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),

              ),
              leading: Icon(Icons.library_books),
              title: Text('Sales Orders'),
              onTap: () async {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => AdminSalesOrderScreen(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),

              ),
              leading: Icon(Icons.account_balance),
              title: Text('Ledger'),
              onTap: () async {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => AdminLedgerScreen(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),

              ),
              leading: Icon(Icons.payment),
              title: Text('Payment/Receipt'),
              onTap: () async {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => AdminPayReceiptScreen(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),

              ),
              leading: Icon(Icons.monetization_on),
              title: Text('Sales Invoice'),
              onTap: () async {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        AdminSalesInvoiceScreen(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),

              ),
              leading: Icon(Icons.local_offer),
              title: Text('Purchase Invoice'),
              onTap: () async {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        AdminPurchaseInvoiceScreen(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),

              ),
              leading: Icon(Icons.description),
              title: Text('Proforma Invoice'),
              onTap: () async {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        AdminProformaInvoiceScreen(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),

              ),
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout (${widget.login})'),
              onTap: () async {
                Navigator.pop(context);
                Logout(context).awesomeDialog(widget.konnectDetails);
              },
            ),
            Divider(),
            SizedBox(height: 50)
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Container(
              color: Color.fromARGB(255, 255, 255, 255),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: GFCarousel(
                              height: MediaQuery.of(context).size.height,
                              items: widget.konnectDetails.coverImage
                                  .map((coverImage) {
                                return Image.network(coverImage.image,
                                    fit: BoxFit.cover, width: 1000.0);
                              }).toList(),
                              autoPlay: true,
                              pagination: true,
                              viewportFraction: 1.0,
                              onPageChanged: (index) {
                                setState(() {
                                  index;
                                });
                              }),
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
                          child: Text(basicInfo.categoryOfBusiness),
                        ),
                      ]),
                  Positioned.fill(
                    left: 0.0,
                    bottom: 30.0,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: FadeInImage.assetNetwork(
                          image: basicInfo.konnectLogo,
                          placeholder: 'images/ic_konnect.png',
                          height: 80,
                          width: 60,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 3, color: Colors.white),
          Expanded(
            flex: 2,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  DashboardButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                AboutScreen(widget.konnectDetails),
                          ),
                        );
                      },
                      asset: 'images/home/ic_about.png',
                      label: 'About'),
                  VerticalDivider(color: Colors.black87),
                  DashboardButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  LocationScreen(widget.konnectDetails)),
                        );
                      },
                      asset: 'images/home/ic_address.png',
                      label: 'Address'),
                  VerticalDivider(color: Colors.black87),
                  DashboardButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ContactScreen(widget.konnectDetails)),
                        );
                      },
                      asset: 'images/home/ic_contact.png',
                      label: 'Contact'),
                ],
              ),
            ),
          ),
          Divider(height: 3, color: Colors.black87),
          Expanded(
            flex: 2,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  DashboardButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => CategoryScreen(),
                          ),
                        ).then(
                          (value) => onBackPressed(),
                        );
                      },
                      asset: 'images/home/ic_store.png',
                      label: 'Store'),
                  VerticalDivider(color: Colors.black87),
                  DashboardButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  OffersScreen(widget.konnectDetails)),
                        );
                      },
                      asset: 'images/home/ic_offers.png',
                      label: 'Offers'),
                  VerticalDivider(color: Colors.black87),
                  DashboardButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  GalleryScreen(widget.konnectDetails)),
                        );
                      },
                      asset: 'images/home/ic_gallery.png',
                      label: 'Gallery'),
                ],
              ),
            ),
          ),
          Divider(height: 3, color: Colors.black87),
          Expanded(
            flex: 2,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  DashboardButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BankingScreen(widget.konnectDetails)),
                        );
                      },
                      asset: 'images/home/ic_banking.png',
                      label: 'Banking'),
                  VerticalDivider(color: Colors.black87),
                  DashboardButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RegisterScreen(widget.konnectDetails)),
                        );
                      },
                      asset: 'images/home/ic_registration.png',
                      label: 'Registration'),
                  VerticalDivider(color: Colors.black87),
                  DashboardButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  SupportScreen(widget.konnectDetails)),
                        );
                      },
                      asset: 'images/home/ic_support.png',
                      label: 'Support'),
                ],
              ),
            ),
          ),
          GFButton(
            size: 50,
            fullWidthButton: true,
            type: GFButtonType.solid,
            color: Colors.blue.shade300,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => InAppWebViewPage(),
                ),
              );
            },
            icon: Icon(
              Icons.video_call,
              color: Colors.white,
            ),
            text: '',
          ),
        ],
      ),
    );
  }
}
