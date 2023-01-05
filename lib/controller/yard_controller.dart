import 'dart:convert';

import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/model/yard_status_model.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:get/get.dart';

class YardStatusController extends GetxController {
  final responseCode = ''.obs;
  var resListData = List<Data>.empty(growable: true).obs;

  @override
  void onInit() {
    getApiData();
    super.onInit();
  }

  Future<void> getApiData() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request =
        Request(url: urlYardStatus, body: {"lang": getLanguage()});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        YardStatusModel listModel =
            YardStatusModel.fromJson(json.decode(response.body));
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
