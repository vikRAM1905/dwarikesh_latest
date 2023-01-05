import 'dart:convert';

import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/model/activity_or_village_cfa_report_model.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:get/get.dart';

class ActivityorVillageCFAReportController extends GetxController {
  var resListData = List<Data>.empty(growable: true).obs;
  final responseCode = ''.obs;

  @override
  void onInit() {
    apiGetList();
    super.onInit();
  }

  @override
  void close() {
    super.onClose();
  }

  void apiGetList() async {
    String villageID = await Prefs.getString(VILLAGE_ID);
    String activityID = await Prefs.getString(ACTIVITY_ID);
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request = Request(url: urlActivityorVillagewiseCFAReport, body: {
      "villageid": villageID,
      "activityid": activityID,
      "lang": getLanguage()
    });
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          ActivityorVillageCfaReportModel listModel =
              ActivityorVillageCfaReportModel.fromJson(
                  json.decode(response.body));
          if (listModel.status == true) {
            resListData.value = listModel.data!;
            print('DATA VALUE ${resListData.length}');
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
