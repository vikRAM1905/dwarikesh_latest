import 'dart:convert';

import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/model/activity_cdo_report_list.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:get/get.dart';

class ActivityReportCdoListController extends GetxController {
  var resListData = List<Data>.empty(growable: true).obs;
  var villageListData = List<Activities>.empty(growable: true).obs;
  var activityListData = List<Activities>.empty(growable: true).obs;
  var cfaListData = List<Activities>.empty(growable: true).obs;

  final responseCode = ''.obs;

  final tabPosition = 0.obs;

  @override
  void onInit() {
    apiGetList();

    super.onInit();
  }

  void apiGetList() async {
    resListData.refresh();
    villageListData.refresh();
    activityListData.refresh();

    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));

    Request request =
        Request(url: urlActivityCDOReport, body: {"lang": getLanguage()});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          ActivityCdoReportList listModel =
              ActivityCdoReportList.fromJson(json.decode(response.body));
          if (listModel.status == true) {
            resListData.value = listModel.data!;

            resListData.forEach((arr_data) {
              print('DATA VALUR PRINT${arr_data.activities}');

              arr_data.type == 0
                  ? cfaListData.value = arr_data.activities!
                  : arr_data.type == 1
                      ? activityListData.value = arr_data.activities!
                      : villageListData.value = arr_data.activities!;
            });
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
    villageListData.refresh();
    activityListData.refresh();

    update();
  }
}
