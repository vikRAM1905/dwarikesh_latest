



import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'constant.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';







String getLanguage(){
  return Prefs.getString(SAVE_LANG) == 'hi' || Prefs.getString(SAVE_LANG) == null ||Prefs.getString(SAVE_LANG) =='' ? "2" : "1";
}


Future<Map<String, dynamic>> getPlatformState() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, dynamic> deviceData = <String, dynamic>{};

  try {
    if (Platform.isAndroid) {
      deviceData =
      await readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } else if (Platform.isIOS) {
      deviceData = await readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
    }
  } on PlatformException {
    deviceData = <String, dynamic>{
      'Error:': 'Failed to get platform version.'
    };
  }

  return deviceData;
}