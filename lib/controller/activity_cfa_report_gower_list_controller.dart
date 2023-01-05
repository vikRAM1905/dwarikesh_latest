import 'dart:convert';

import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/model/activity_cfa_report_gower_list_model.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:get/get.dart';

class ActivityCFAReportGowerListController extends GetxController {
  var resListData = List<Data>.empty(growable: true).obs;
  var searchListData = List<Data>.empty(growable: true).obs;
  final responseCode = ''.obs;
  final tabPosition = 0.obs;

  @override
  void onInit() {
    apiGetList();
    super.onInit();
  }

  void apiGetList() async {
    String villageID = await Prefs.getString(VILLAGE_ID);
    String activityID = await Prefs.getString(ACTIVITY_ID);
    String cfaID = await Prefs.getString(CFA_ID);
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request = Request(url: urlActivityCFAReportGowerList, body: {
      "villageid": villageID,
      "activityid": activityID,
      "lang": getLanguage(),
      "cfaid": cfaID
    });
    request.post().then((response) {
      print(response.statusCode);
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          print(response.body);

          ActivityCFAReportGowerList listModel =
              ActivityCFAReportGowerList.fromJson(json.decode(response.body));
          if (listModel.status == true) {
            resListData.value = listModel.data!;
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

  Future<void> updatetabPosition(int value) async {
    tabPosition.value = value;
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
