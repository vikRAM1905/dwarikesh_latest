import 'dart:convert';

import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:get/get.dart';
import 'package:dwarikesh/model/gower_req_rep_model.dart';

class GrowerRequestReportctrl extends GetxController {
  var resListData = List<Data>.empty(growable: true).obs;
  final responseCode = ''.obs;

  @override
  void onInit() {
    apiGetList();
    super.onInit();
  }

  void apiGetList() async {
    String grower = await Prefs.getString(GROWER_ID);
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request = Request(
        url: urlGowerwiseResquestDetail,
        body: {'growerid': grower, "lang": getLanguage()});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      print('DATA ${responseCode.value}');
      if (response.statusCode == 200) {
        GowerReqReportModel listModel =
            GowerReqReportModel.fromJson(json.decode(response.body));
        if (listModel.status == true) {
          resListData.value = listModel.data!;
          print('DATA ${listModel.data}');
        }
      }

      Get.back();
      update();
    }).catchError((onError) {
      print(onError);
    });
  }
}
