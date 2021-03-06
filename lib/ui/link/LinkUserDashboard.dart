import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';

import 'package:mrktradexpvtltd/ui/link/LinkUserSalesQuatation.dart';

import '../base/libraryExport.dart';
import 'LinkUserActivityList.dart';
import 'LinkUserExpanseReport.dart';

class LinkUserDashboardScreen extends StatefulWidget {
  final KonnectDetails konnectDetails;

  LinkUserDashboardScreen(this.konnectDetails);

  @override
  State<StatefulWidget> createState() => _LinkUserDashboardState();
}

class _LinkUserDashboardState extends State<LinkUserDashboardScreen> {
  List<CartSummery> cart = List<CartSummery>();
  ProgressDialog pr;
  UserAdmin profile;
  List<String> buttonname= [
    "On Android",
    "On ios",
    "on whatsapp business ",
    "with Card Link",
    "with Card Image",
    "with UPI QR Code",
    "with geo Location",
    "with any file  Link",
    "with business info QR ",
    "with New Year Wish",
    "with cardwebstore link",
  ];
  List<IconData> icondata=[FontAwesomeIcons.android,FontAwesomeIcons.appStoreIos,FontAwesomeIcons.whatsapp,Icons.link,Icons.image,FontAwesomeIcons.wallet,Icons.location_on,Icons.attach_file,Icons.qr_code,Icons.card_giftcard,Icons.shopping_cart_rounded];
  String e="";
 String _verticalGroupValue="";
  @override
  void initState() {
    super.initState();

    String key = AppConstants.USER_LOGIN_DATA;
    AppPreferences.getString(key).then((value) => {
          setState(() {
            Map<String, dynamic> response = jsonDecode(value);
            profile = UserAdmin.fromJson(response);
            print("vikas");
            print(profile.toJson());
            print("vikas");
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

  @override
  Widget build(BuildContext context){
  double Height = MediaQuery.of(context).size.height;
  double Width= MediaQuery.of(context).size.width;
    BasicInfo basicInfo = widget.konnectDetails.basicInfo;
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
      appBar: AppBar(
        title: Text('नमस्कार / welcome'),
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
                                                    child: Icon(icondata[buttonname.indexOf(e)],color:Colors.lightBlue,size:20,),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:5.0),
                                                    child: Center(

                                                      child: Text(
                                                        e,
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





                                              if(e=="On Android"){
                                                Navigator.pop(context);
                                                Share.share('${AppConstants.SHARE_APP}');
                                              }else
                                              if (e=="On ios"){
                                                Navigator.pop(context);
                                                Share.share('https://apps.apple.com/in/app/mrk-tradex/id1535832758');

                                              }
                                              else if(e=="on whatsapp business profile"){



                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => wspbusiness(widget.konnectDetails),
                                                  ),
                                                );
                                              }
                                              else  if(e=="with Card Link"){
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => WithCardlink(widget.konnectDetails),
                                                  ),
                                                );
                                              }
                                              else  if(e=="with Card Image"){
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => WithCardImage(widget.konnectDetails),
                                                  ),
                                                );
                                              }
                                              else  if(e=="with UPI QR Code"){
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) =>withbankQr(widget.konnectDetails) ,
                                                  ),
                                                );
                                              }
                                              else  if(e=="with geo Location"){
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) =>withgpslocation(widget.konnectDetails) ,
                                                  ),
                                                );
                                              }
                                              else  if(e=="with any file  Link"){
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) =>withfile(widget.konnectDetails) ,
                                                  ),
                                                );
                                              }
                                              else  if(e=="with business info QR "){
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) =>withbusinessinfoQR(widget.konnectDetails) ,
                                                  ),
                                                );
                                              }
                                              else  if(e=="with cardwebstore link"){
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
              ),
            ),
            Divider(),

            ListTile(
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),

              ),
              leading: Icon(Icons.local_activity),
              title: Text('Activity List'),
              onTap: () async {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        LinkUserActivityListScreen(id: profile.id),
                  ),
                );
              },
            ),
            Divider(),

            ListTile(
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),

              ),
              leading: Icon(Icons.file_copy),
              title: Text('Expanse Report'),
              onTap: () async {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        LinkUserExpanseReportScreen(id: profile.id),
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
                    builder: (BuildContext context) =>
                        LinkUserPartyMasterScreen(id: profile.id),
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
              leading: Icon(Icons.library_books),
              title: Text('Sales Quatation/Purchase Order'),
              onTap: () async {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        LinkUserSalesQuatationScreen(id: profile.id),
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
                    builder: (BuildContext context) =>
                        LinkUserSalesOrderScreen(id: profile.id),
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
                    builder: (BuildContext context) =>
                        LinkUserLedgerScreen(id: profile.id),
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
                    builder: (BuildContext context) =>
                        LinkUserPayReceiptScreen(id: profile.id),
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
                        LinkUserSalesInvoiceScreen(id: profile.id),
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
                        LinkUserProformaInvoiceScreen(id: profile.id),
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
              title: Text('Logout (Link User)'),
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
