import 'package:dwarikesh/model/factory_model.dart';
import 'package:dwarikesh/service/localization_service.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/widgets/snackbar_message.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/model/login_model.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:package_info/package_info.dart';

class GrowerLoginController extends GetxController {
  var isLoading = false.obs;
  var languageMode = ''.obs;
  var factoryList = List<Data>.empty(growable: true);
  var currentFactoryName = "${"factory_select".tr}".obs;
  var currentFactoryCode = ''.obs;
  var responseCode = ''.obs;
  var tokenValue = ''.obs;
  var otp = ''.obs;
  var acceptPrivacy = 1.obs;
  var buildNumber = ''.obs;
  TextEditingController mobileTextController = TextEditingController();
  TextEditingController gowerCodeTextController = TextEditingController();
  TextEditingController villageCodeTextController = TextEditingController();

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic>? deviceData;
  Map<String, dynamic>? otherPlatformDetail;

  @override
  void onInit() {
    languageMode.value = getLanguage();
    getCurrentVersion();
    update();
    print('Language Code ${languageMode.value}');
    factoryListAPI();

    super.onInit();
  }

  Future<void> updateFactoryValue(String value, BuildContext context) async {
    factoryList.forEach((element) {
      var modelData = '${element.name.toString()}';
      if (modelData
          .toLowerCase()
          .trim()
          .contains(value.toString().toLowerCase().trim())) {
        currentFactoryName.value = '${element.name}';
        currentFactoryCode.value = element.code.toString();
        print('VALUE OF PLOT DATA ${currentFactoryCode}');
      }
    });
    FocusScope.of(context).requestFocus(new FocusNode());

    /* FocusScopeNode currentScope = FocusScope.of(context);
      if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
        FocusManager.instance.primaryFocus.unfocus();
      }*/

    update();
  }

  getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    buildNumber.value = await packageInfo.buildNumber;
  }

  Future<void> gowerApiLogin() async {
    /* if (mobileTextController.text.length >= 10 && mobileTextController.text.length == 10)
      if (currentFactoryCode != null && currentFactoryCode != '')
        if (villageCodeTextController.text.length >= 1 && villageCodeTextController.text != null && villageCodeTextController.text != '')
          if (gowerCodeTextController.text.length >= 1 && gowerCodeTextController.text != null && gowerCodeTextController.text != '')
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
          bgColor: Colors.redAccent);*/

    if (mobileTextController.text.length >= 10 &&
        mobileTextController.text.length ==
            10) if (currentFactoryCode != null && currentFactoryCode != '')
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

  void factoryListAPI() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));

    factoryList.clear();
    Request request = Request(url: urlFactoryList, body: {
      "lang": languageMode.value,
    });
    request.post().then((response) async {
      responseCode.value = response.statusCode.toString();
      var data = json.decode(response.body);
      var rest = data["status"] as bool;
      if (response.statusCode == 200 && rest == true) {
        FactoryListModel model =
            FactoryListModel.fromJson(json.decode(response.body));
        model.data!.forEach((eachdata) => factoryList.add(eachdata));

        Get.back();
      } else {
        Get.back();
        snakbarMsg(
            icon: Icons.dangerous,
            title: 'failed'.tr,
            msg: "",
            colors: Colors.white,
            bgColor: Colors.redAccent);
      }
    }).catchError((onError) {
      print(onError);
    });

    update();
  }

  void loginUserAPI() async {
    //  Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    isLoading.value = true;
    update();
    String code;
    var tempVillageCode;
    String mobileNumber;

    /*  if(villageCodeTextController.text.length>1 && villageCodeTextController.text.length<=3){
      tempVillageCode =  int.parse(villageCodeTextController.text) + 1000;
    }
    else{
      tempVillageCode = villageCodeTextController.text;}*/

    mobileNumber = mobileTextController.text.toString().trim();
    //  code = currentFactoryCode.value.trim() +  tempVillageCode.toString().trim() + gowerCodeTextController.text.toString().trim() ;
    code = currentFactoryCode.value.trim();
    var list = (await getPlatformState());
    Request request = Request(url: urlLogin, body: {
      "bcm_phone_number": mobileNumber.trim(),
      // "bcm_code":'14110012',
      "bcm_code": code.trim(),
      "deviceinfo": json.encode(list),
      "user_type": "1",
      "appversion": buildNumber.value
    });
    request.post().then((response) async {
      responseCode.value = response.statusCode.toString();
      var data = json.decode(response.body);
      var rest = data["success"] as bool;
      print('RESUL DATA ${data}');
      if (response.statusCode == 200 && rest == true) {
        Login model = Login.fromJson(json.decode(response.body));
        await Prefs.setString(MOB, mobileTextController.text);
        await Prefs.setString(OTP_CODE, model.otp.toString());
        await Prefs.setString(TOKEN, model.token!);
        await Prefs.setString(ROUTE_OTP_MSG, model.message!);
        await Prefs.setString(ROUTE_OTP_TITLE, model.title!);
        await Prefs.setString(
            ROLE_ID,
            model.roleId
                .toString()); //  roleID = 3(zonal)  roleID = 4(CFA) roleID = 5(Grower)
        isLoading.value = false;
        update();
        Get.toNamed(ROUTE_OTP);
      } else {
        Get.back();
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
      print("onError//////////////////////");
      print(onError);
      isLoading.value = false;
      update();
    });
    update();
  }

  Future<void> updateLanguage(String value) async {
    print("on CLicking working");
    LocalizationService.changeLocale(value);
    languageMode.value = value == 'en' || value == null ? "1" : "2";
    currentFactoryName.value = "${"factory_select".tr}";
    currentFactoryCode.value = '';
    factoryListAPI();
    update();
  }
}
