import 'dart:convert';

import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/model/terms_model.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:get/get.dart';

class TermsController extends GetxController {
  var terms = ''.obs;
  var aboutUs = ''.obs;
  final responseCode = ''.obs;

  @override
  void onInit() {
    getAPI();
    super.onInit();
  }

  Future<void> getAPI() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request =
        Request(url: urlTermsANDAbout, body: {"lang": getLanguage()});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          TermsModel listModel =
              TermsModel.fromJson(json.decode(response.body));
          if (listModel.status == true) {
            terms.value = listModel.termscondition!;
            aboutUs.value = listModel.aboutus!;
          } else
            responseCode.value = '403';
        }
      }

      Get.back();
      update();
    }).catchError((onError) {
      print(onError);
    });
  }
}
