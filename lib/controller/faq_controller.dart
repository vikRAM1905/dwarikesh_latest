import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:get/get.dart';
import 'package:dwarikesh/model/faq_model.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'dart:convert';
import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';

class FAQsController extends GetxController {
  var resListData = List<Data>.empty(growable: true).obs;
  final responseCode = ''.obs;

  @override
  void onInit() {
    apiGetUserList();
    super.onInit();
  }

  @override
  void onReady() {
    // apiGetUserList();
    super.onReady();
  }

  void apiGetUserList() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request = Request(url: urlFAQ, body: {"lang": getLanguage()});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      print(
          '----------------------RESPONSE CODE ${response.statusCode}    BODY : ${response.body} ------------------------------------------');
      if (response.statusCode == 200) {
        FAQsModel listModel = FAQsModel.fromJson(json.decode(response.body));
        if (listModel.status == true) {
          resListData.value = listModel.data!;
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
