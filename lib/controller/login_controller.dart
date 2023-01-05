import 'dart:async';
import 'package:dwarikesh/controller/localization_controller.dart';
import 'package:dwarikesh/model/factory_model.dart';
import 'package:dwarikesh/service/localization_service.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController with SingleGetTickerProviderMixin {
  var factoryList = List<Factory>.empty(growable: true);

  final lanugageController = Get.put(AppLanguage());
  var firebaseAuth = FirebaseAuth.instance;

  var languageMode = getLanguage();
  final tabPosition = 0.obs;
  TabController? tabcontroller;
  var tokenValue = ''.obs;

  @override
  void onInit() {
    tabcontroller = TabController(length: 2, vsync: this);
    factoryList = Factory.factoryList();
    getFirebaseToken();
    update();
    super.onInit();
  }

  Future getFirebaseToken() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    await Prefs.setString(FCM_TOKEN, fcmToken!);
  }

  Future<void> updatetabPosition(int value) async {
    tabPosition.value = value;
    update();
  }

  Future<void> updateLanguage(String value) async {
    LocalizationService.changeLocale(value);
    languageMode = value == 'en' || value == null ? "1" : "2";
    factoryList = Factory.factoryList();
    update();
  }

  @override
  void onClose() {
    tabcontroller!.dispose();
    update();
    super.onClose();
  }
}
