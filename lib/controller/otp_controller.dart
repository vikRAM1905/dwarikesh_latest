import 'dart:async';

import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  int timerMaxSeconds = 300;
  Timer? _timer;
  var currentSeconds = 0.obs;

  var first = false.obs;
  var last = false.obs;
  var otpCode = Prefs.getString(OTP_CODE);
  TextEditingController? firstTextController;

  @override
  void onInit() {
    firstTextController = TextEditingController();
    startTimeout();
    super.onInit();
  }

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds.value) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds.value) % 60).toString().padLeft(2, '0')}';

  startTimeout([int? milliseconds]) {
    _timer = new Timer.periodic(Duration(seconds: 1), (timer) {
      print(timer.tick);
      currentSeconds.value = timer.tick;
      if (timer.tick >= timerMaxSeconds) timer.cancel();
      update();
    });
  }

  verifyCode() {
    if (firstTextController!.text != null && firstTextController!.text == '') {
      snakbarMsg(
          icon: Icons.dangerous,
          title: 'OTP Verification',
          msg: 'Enter Your OTP',
          colors: Colors.white,
          bgColor: Colors.redAccent);
    } else {
      otpChecking(firstTextController!.text, otpCode);
    }
  }

  void otpChecking(String userEnterValue, String otpCode) {
    print('USER ENTER VALUE ${userEnterValue}  ==  ${otpCode}');
    String userRole = Prefs.getString(ROLE_ID);
    if (otpCode == userEnterValue) {
      _timer!.cancel();
      if (userRole == GROWER) {
        Prefs.setString(AUTH_CODE, '');
        Get.offAllNamed(ROUTE_ACCOUNT_LIST);
        //Get.offAllNamed(ROUTE_EXPENSE_ADD);
      } else {
        Prefs.setString(AUTH_CODE, "1");
        Get.offAllNamed(ROUTE_HOME);
      }
    } else
      snakbarMsg(
          icon: Icons.dangerous,
          title: 'Wrong OTP',
          msg: 'Incorrect OTP',
          colors: Colors.white,
          bgColor: Colors.redAccent);
  }

  @override
  void dispose() {
    firstTextController!.text = '';
    firstTextController!.clear();
    firstTextController!.dispose();

    _timer!.cancel();
    super.dispose();
  }
}
