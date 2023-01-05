import 'dart:convert';

import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/model/account_list_model.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  var menuListData = List<Data>.empty(growable: true).obs;

  final responseCode = ''.obs;
  final language = 0.obs;
  final savePositionID = ''.obs;
  var submitEnable = false.obs;

  @override
  void onInit() {
    getMenuApi();
    super.onInit();
  }

  Future<void> selectedPostion() async {
    String value = await Prefs.getString(ACCOUNT_CODE) ?? '';
    print('Get Defult POSITION : ${value}');
    if (value != '') {
      menuListData.forEach((element) async {
        if (element.id.toString().trim() == value.trim()) {
          await Prefs.setString(ACCOUNT_CODE, element.id.toString().trim());
          await Prefs.setString(TOKEN, element.token!);
          element.setPosition = true;
        } else
          element.setPosition = false;
      });
    }

    update();
  }

  Future<void> selectedAccountID(Data model) async {
    menuListData.forEach((element) => element.clickPos = false);
    if (model.getPosition == false) {
      print('ID IS ${model.id.toString()}');
      Prefs.setString(ACCOUNT_CODE, model.id.toString());
      model.setPosition = true;
    } else
      model.setPosition = false;

    submitEnable.value = true;

    update();
  }

  void getMenuApi() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request =
        Request(url: urlAccountList, body: {"lang": getLanguage()});
    request.post().then((response) async {
      responseCode.value = response.statusCode.toString();
      print(
          '----------------------RESPONSE CODE ${response.statusCode}    BODY : ${response.body} ------------------------------------------');
      if (response.statusCode == 200) {
        AccountListModel listModel =
            AccountListModel.fromJson(json.decode(response.body));
        if (listModel.status == true) {
          menuListData.value = listModel.data!;
          await selectedPostion();
        } else
          responseCode.value = '403';
      }

      Get.back();
      update();
    }).catchError((onError) {
      print(onError);
    });
  }
}
