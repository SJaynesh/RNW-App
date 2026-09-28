// ignore_for_file: constant_identifier_names

import 'package:rnw_institue/utils/app_export.dart';

class PrefObj {
  static Box? preferences;
}

class PrefKeys {
  static const String THEMEDATA = 'theme_data';
  static const String DEVICETOKEN = 'device_token';
  static const String USERID = 'id';
  static const String PHONENUMBER = 'mobile_no';
  static const String TOKEN = 'token';
  static const String TYPE = 'type';
  static const String STDNAME = 'stdname';
  static const String GRID = 'grid';
  static const String PHOTO = 'stdphoto';
  static const String ORGANIZATIONCOAE = 'organizationcoad';
  static const String SUBSCRIPTIONID = 'subscription_ID';

  Future<void> setThemeData(String value) {
    return PrefObj.preferences!.put(PrefKeys.THEMEDATA, value);
  }

  String getThemeData() {
    try {
      return PrefObj.preferences!.get(PrefKeys.THEMEDATA)!;
    } catch (e) {
      return 'primary';
    }
  }
}
