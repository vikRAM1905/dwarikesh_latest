import 'dart:ui';
import 'package:dwarikesh/controller/dashboard_controller.dart';
import 'package:dwarikesh/service/localization_service.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';

import 'package:get/get.dart';

class AppLanguage extends GetxController {
  var appLocale = getLanguage().obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    update();
  }

  Future<void> changeLanguage(String type) async {
    print('app LOCAL VALUE ${appLocale.value}');
    if (type == 'hi') {
      appLocale.value = 'hi';
    } else {
      appLocale.value = 'en';
    }
    print("on CLicking working");
    await Prefs.setString(SAVE_LANG, appLocale.value);
    LocalizationService.changeLocale(appLocale.value);
    Get.forceAppUpdate();
    update();
    DashboardController controller = Get.put(DashboardController());
    controller.apiGetMenuList();
    update();
  }
}
