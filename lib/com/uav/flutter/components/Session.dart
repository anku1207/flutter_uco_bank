import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

Future<String?> getCustomerId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(KEY_CONSTOMER_ID);
}