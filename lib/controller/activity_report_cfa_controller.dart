import 'package:dwarikesh/model/activity_graph_cfa.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';

class ActivityReportCfaController extends GetxController {
  var resListData = List<Data>.empty(growable: true).obs;
  var villageListData = List<Activities>.empty(growable: true).obs;
  var activityListData = List<Activities>.empty(growable: true).obs;
  var dateListData = List<Activities>.empty(growable: true).obs;
  var dateWiseActivity = List<Details>.empty(growable: true).obs;
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
        Request(url: urlActivityCFAReport, body: {"lang": getLanguage()});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          ActivityGraphCfaModel listModel =
              ActivityGraphCfaModel.fromJson(json.decode(response.body));
          if (listModel.status == true) {
            resListData.value = listModel.data!;

            resListData.forEach((arr_data) {
              arr_data.type == 0
                  ? villageListData.value = arr_data.activities!
                  : arr_data.type == 1
                      ? activityListData.value = arr_data.activities!
                      : dateListData.value = arr_data.activities!;
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

  Future<void> dayWiseActivity(DateTime date) async {
    dateWiseActivity.value = [];
    String year = date.year.toString();
    String month = date.month.toString();
    String day = date.day.toString();
    for (int i = 0; i < dateListData.value.length; i++) {
      if (dateListData.value[i].year == year &&
          dateListData.value[i].month == month &&
          dateListData.value[i].date == day) {
        dateWiseActivity.value = dateListData.value[i].details!;
        break;
      }
    }
  }
}
