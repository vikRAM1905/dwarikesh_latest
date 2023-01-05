import 'dart:convert';

import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/model/login_model.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:dwarikesh/widgets/snackbar_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

class EmployeeLoginController extends GetxController {
  var responseCode = ''.obs;
  var otp = ''.obs;
  var tokenValue = ''.obs;
  var isLoading = false.obs;
  var acceptPrivacy = 1.obs;
  var buildNumber = ''.obs;

  TextEditingController empmobileTextController = TextEditingController();
  TextEditingController empCodeTextController = TextEditingController();

  @override
  void onInit() {
    getCurrentVersion();
    super.onInit();
  }

  employeeApiLogin() async {
    if (empmobileTextController.text.length >= 10 &&
        empmobileTextController.text.length ==
            10) if (empCodeTextController.text.length >= 1 &&
        empCodeTextController.text != null &&
        empCodeTextController.text != '')
      try {
        loginUserAPI();
      } catch (E) {
        Get.back();
      }
    else
      snakbarMsg(
          icon: Icons.dangerous,
          title: 'error'.tr,
          msg: 'wrong_mobile_number_or_employee_code'.tr,
          colors: Colors.white,
          bgColor: Colors.redAccent);
    else
      snakbarMsg(
          icon: Icons.dangerous,
          title: 'error'.tr,
          msg: 'wrong_mobile_number_or_employee_code'.tr,
          colors: Colors.white,
          bgColor: Colors.redAccent);
  }

  getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    buildNumber.value = await packageInfo.buildNumber;
  }

  void loginUserAPI() async {
    //  Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));

    isLoading.value = true;
    update();

    String code;
    String mobileNumber;

    mobileNumber = empmobileTextController.text.toString().trim();
    code = empCodeTextController.text;

    var list = (await getPlatformState());

    Request request = Request(url: urlLogin, body: {
      "bcm_phone_number": mobileNumber,
      "bcm_code": code,
      "deviceinfo": json.encode(list),
      "appversion": buildNumber.value,
      "user_type": "2"
    });
    request.post().then((response) async {
      responseCode.value = response.statusCode.toString();
      var data = json.decode(response.body);
      var rest = data["success"] as bool;

      print('RESULT DATA ${response.statusCode}  ${rest}');
      if (response.statusCode == 200 && rest == true) {
        print('RESULT DATA ${response.statusCode}  ${rest}');
        Login model = Login.fromJson(json.decode(response.body));
        print(' response  ${response.body}');
        await Prefs.setString(MOB, empmobileTextController.text);
        await Prefs.setString(OTP_CODE, model.otp.toString());
        await Prefs.setString(TOKEN, model.token!);
        await Prefs.setString(ROUTE_OTP_MSG, model.message!);
        await Prefs.setString(ROUTE_OTP_TITLE, model.title!);
        await Prefs.setString(
            ROLE_ID,
            model.roleId
                .toString()); //  roleID = 3(zonal)  roleID = 5(CFA) roleID = 6(Grower)
        isLoading.value = false;

        Get.toNamed(ROUTE_OTP);
      } else {
        snakbarMsg(
            icon: Icons.dangerous,
            title: 'failed'.tr,
            msg:
                "${'invalid'.tr} ${'mobile'.tr} ${'or'.tr} ${'grower'.tr}/ ${'employee'.tr} ${'code'.tr}",
            colors: Colors.white,
            bgColor: Colors.redAccent);
        isLoading.value = false;
        update();
      }
    }).catchError((onError) {
      print(onError);
      isLoading.value = false;
      update();
    });

    update();
  }
}
