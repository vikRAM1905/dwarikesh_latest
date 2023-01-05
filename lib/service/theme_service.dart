
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ThemeService{

  ThemeMode getThemeMode(){
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }


  bool isSavedDarkMode(){
    return Prefs.getBoolen(UserThemeData) ?? false;
  }

  void saveThemeMode(bool isDarkMode){
    Prefs.setBoolen(UserThemeData, isDarkMode);
  }

  void changeThemeMode(){
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeMode(!isSavedDarkMode());
  }


}