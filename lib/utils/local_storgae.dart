

import 'dart:convert';

import 'package:dwarikesh/model/login_model.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';


class LocalStorage {

  /// Write


  void saveUserLoginModel (String status)async{
    await Prefs.setString(LOGIN_MODEL, status);
  }



  Future<String> get userLoginValidate async{
    return await Prefs.getString(STATUS);
  }

  Future<String> get userLoginModel async{
    return await Prefs.getString(LOGIN_MODEL);
  }




}

