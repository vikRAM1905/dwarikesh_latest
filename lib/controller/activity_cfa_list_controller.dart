import 'dart:convert';

import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/model/activity_cfa_list.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:get/get.dart';

class ActivityCFAReportController extends GetxController {
  var resListData = List<Data>.empty(growable: true).obs;
  final responseCode = ''.obs;

  @override
  void onInit() {
    apiGetList();
    super.onInit();
  }

  void apiGetList() async {
    String villageID = await Prefs.getString(VILLAGE_ID);
    String activityID = await Prefs.getString(ACTIVITY_ID);

    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request = Request(url: urlActivityCFANameListReport, body: {
      "lang": getLanguage(),
      "villageid": villageID,
      "activityid": activityID
    });
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          ActivityCfaNameListModel listModel =
              ActivityCfaNameListModel.fromJson(json.decode(response.body));
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
}
