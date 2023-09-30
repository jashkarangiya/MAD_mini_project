/*
*  Singleton - SharedPreferences
*  Function: Saves user preferences, in this case the units of measure
*/

import 'package:shared_preferences/shared_preferences.dart';

class SharPrefs {

  static final SharPrefs _instance = SharPrefs._internal();
  SharPrefs._internal();
  factory SharPrefs(){
    return _instance;
  }

  late SharedPreferences _prefs; 

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get metric => _prefs.getBool('metric') ?? true ;
  
  set metric( bool value ){
    _prefs.setBool('metric', value);
  }

}