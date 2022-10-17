import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper{

  // Save
  static Future<void> addStringToSF({required String keyName, required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyName, value);
  }

  static Future<void> addIntToSF({required String keyName, required int value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(keyName, value);
  }

  static Future<void> addBoolToSF({required String keyName, required bool value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(keyName, value);
  }

  static Future<void> addDoubleToSF({required String keyName, required double value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(keyName, value);
  }

  // Read
  static Future<String?> getStringValuesSF({required String keyName, String? defaultValue}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString(keyName) ?? defaultValue;

    return stringValue;
  }

  static Future<bool> getBoolValuesSF({required String keyName}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool(keyName);
    if(boolValue != null){
      return boolValue;
    }else{
      return false;
    }
  }

  static Future<int> getIntValuesSF({required String keyName}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int intValue = prefs.getInt(keyName)?? 0;
    return intValue;
  }

  static Future<double> getDoubleValuesSF({required String keyName}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double doubleValue = prefs.getDouble(keyName)?? 0.0;
    return doubleValue;
  }

  // Remove
  static Future<void> removeValues(String keyName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(keyName);
  }

  // Check value if present or not? (True/False)
  static Future<bool> check(String keyName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey(keyName);
    return checkValue;
  }

}