
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import 'package:toggle_switch/toggle_switch.dart';
import 'package:upgrader/upgrader.dart';

import '../Animated.dart';
import './base/libraryExport.dart';


class DashboardScreen extends StatefulWidget {
  final KonnectDetails konnectDetails;

  DashboardScreen(this.konnectDetails);

  @override
  State<StatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  List<CartSummery> cart = List<CartSummery>();
  bool isLoginRequired = false;
  ProgressDialog pr;
  AnimationController _animationController;
  bool isDarkMode = false;
  var mrk=1;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> buttonname= [
    "On Android",
    "On ios",

  ];
  List<IconData> icondata=[FontAwesomeIcons.android,FontAwesomeIcons.appStoreIos];


 // AppConstants appConstants =new AppConstants();


  @override
  void initState() {
  
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    checkPermission();
  }
  String _verticalGroupValue ;
  onBackPressed() async {
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

    print('Back Pressed ${cart.length}');
  }

  checkPermission() async {
    Map response = (await ApiClient().checkPartyPermission()).data;
    if (response['status'] == '200') {
      setState(() {
        Map result = response['result'];
        //{login_required: 1, gstin_required: 1}}
        isLoginRequired = result['login_required'] == 1;
        print('is Login Required result $isLoginRequired');
      });
    }
    onBackPressed();
  //  print(response);
  }

  Widget getCart(BasicInfo basicInfo) {
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
                  builder: (BuildContext context) => isLoginRequired
                      ? PartyMasterMobileScreen(logo: basicInfo.konnectLogo)
                      : OrderCartScreen(),
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
                    builder: (BuildContext context) => isLoginRequired
                        ? PartyMasterMobileScreen(logo: basicInfo.konnectLogo)
                        : OrderCartScreen(),
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

  @override
  Widget build(BuildContext context) {
    double Height = MediaQuery.of(context).size.height;
    double Width= MediaQuery.of(context).size.width;

    Upgrader().clearSavedSettings();
    BasicInfo basicInfo = widget.konnectDetails.basicInfo;
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');
   // print('Basic card deatail $basicInfo');
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
      appBar: AppBar(
        title: Text('नमस्कार / welcome'),
        actions: <Widget>[
          basicInfo.cardtype=="ecommerce"?getCart(basicInfo):Container(),
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
                      content: Container(height: Height*0.13,
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
              //  Share.share(AppConstants.SHARE_APP);
              }),
        ],
      ),
      body:  UpgradeAlert(
        debugLogging: false,
        child:




      Column(
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
                      alignment: Alignment.bottomLeft,
                      child: FadeInImage.assetNetwork(
                        image: basicInfo.konnectLogo,
                        placeholder: 'images/ic_konnect.png',
                        height: 80,
                        width: 60,
                      ),
                    ),
                  ),

                  basicInfo.cardtype=="ecommerce"?Positioned.fill(
                    right: 10.0,
                    bottom: 50.0,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GFButton(
                        color: Colors.black,
                        type: GFButtonType.outline,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PartyMasterMobileScreen(
                                      logo: basicInfo.konnectLogo),
                            ),
                          );
                        },
                        text: 'Login',
                      ),
                    ),
                  ):Container(),
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
                                LocationScreen(widget.konnectDetails),
                          ),
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
                        basicInfo.cardtype=="ecommerce"?
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => isLoginRequired
                                  ? PartyMasterMobileScreen(
                                      logo: basicInfo.konnectLogo)
                                  : CategoryScreen()),
                        ): Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => isLoginRequired
                                  ? PartyMasterMobileScreen(
                                  logo: basicInfo.konnectLogo)
                                  : ProductcopScreen()),
                        );
                      },
                      asset: 'images/home/ic_store.png',
                      label:  basicInfo.cardtype=="ecommerce"?'Store':'Products'),
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

          Row(
            children: [
// Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ToggleSwitch(

                  inactiveBgColor: Colors.grey[200],
                  initialLabelIndex: AppConstants.appId,
                  labels: ['MRK', 'MAYA', ],
                  onToggle: (index) {
                    if(index==0){
                      AppConstants.setAppId(0);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => SplashScreen(),
                        ),
                      );
                    }
                    else{
                      AppConstants.setAppId(1);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => SplashScreen(),
                        ),
                      );
                    }
                    print('switched to: $index');
                  },
                ),
              ),

              basicInfo.cardtype=="ecommerce"?Expanded(child:
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: GFButton(
size: 40,

                  type: GFButtonType.solid,
                  color: Colors.blue,
                  onPressed: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.INFO,
                      animType: AnimType.RIGHSLIDE,
                      headerAnimationLoop: false,
                      title: 'Required',
                      desc: 'Required',
                      body: Text('Please login to use this service'),
                      btnCancelOnPress: () {},
                    ).show();
                  },
                  icon: Icon(
                    Icons.video_call,
                    color: Colors.white,
                  ),
                  text: '',
                ),
              ),):Container(),

            ],
          ),
        ],
      ),
      ));
  }
}
