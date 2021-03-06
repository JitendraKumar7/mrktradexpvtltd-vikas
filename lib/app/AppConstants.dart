import 'package:mrktradexpvtltd/ui/base/libraryExport.dart';

class AppConstants {
  static int appId = 0;

  static setAppId(int id) async {
    await AppPreferences.setInt(APP_DATA, id);
    print('app id $id');
    appId = id;
  }

  Future<int> get getAppId async {
    return await AppPreferences.getInt(APP_DATA);
  }

  int get userId => appId == 0 ? 406 : 46;

  int get konnectId => appId == 0 ? 1330 : 1834;

  static const String APP_DATA = 'com.meo.konnect.app';
  static const String KONNECT_DATA = 'com.meo.konnect.data';
  static const String USER_CART_DATA = 'com.meo.user.cart.data';
  static const String USER_LOGIN_DATA = 'com.meo.user.login.data';

  static const String USER_LOGIN_CREDENTIAL = 'com.meo.user.login.credential';

  static const String getServerKey =
      'AAAAc5_l7dk:APA91bGq3HyBqzeyJZfSeS-zRWFQIs_cVjmM498VmE92_e3QPQT-Ox7-CH_8AT9345ye7Cbm3hpHix43R8griTqtdimnlpNw-zCF9IE4PB8CrCf5Bmu2QUzUSEs82WN0xhdSon-qym3-';

  static const String SHARE_APP = '    Check out MRK TRADEX PVT. LTD.  application \n\n'
      'https://play.google.com/store/apps/details?id=com.mrk.tradex';
  static const String SHARE_APPproduct = ' \n\n'
      'https://play.google.com/store/apps/details?id=com.mrk.tradex';

   String get SHARE_STORE => 'Check out my online store \n\n'
      'https://meo.co.in/konnect-link/konnect-new/productMart/webStore.php?kid=${appId==0?'MTMzMA==':"MTgzNA=="}';
   String get SHARE_WEBVIEW => '\n\n'
      'https://meo.co.in/konnect-link/konnect-new/konnect-newlink.php?konnect_id=${konnectId}';
    String get SHARE_CARDVIEW => ' \n\n'
      'https://meo.co.in/konnect-pro/konnect-prolink.php?konnect_id=${konnectId}';

  static  String SHARE_KMB = ' \n\n''https://play.google.com/store/apps/details?id=meo.com.konnect';
}
