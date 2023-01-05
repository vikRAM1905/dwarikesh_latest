import 'package:dwarikesh/model/finance_list_model.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';

import 'activity_list_grower_controller.dart';

class FinanceListController extends GetxController {
  var resListData = List<Data>.empty(growable: true).obs;
  final responseCode = ''.obs;
  final totalIncome = ''.obs;
  final totalExpanse = ''.obs;
  final year = ''.obs;
  final tempHeadingName = ''.obs;
  @override
  void onInit() {
    apiGetUserList();
    super.onInit();
  }

  @override
  void onReady() {
    apiGetUserList();
    super.onReady();
  }

  Future<void> apiGetUserList() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request =
        Request(url: urlFinanceList, body: {"lang": getLanguage()});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        FinanceListModel listModel =
            FinanceListModel.fromJson(json.decode(response.body));
        if (listModel.status == true) {
          resListData.value = listModel.data!;

          totalIncome.value = listModel.income!;
          totalExpanse.value = listModel.expense.toString();
          year.value = listModel.year!;
        } else
          responseCode.value = '403';
      }

      Get.back();
      update();
    }).catchError((onError) {
      print(onError);
    });
  }

  void apidelectList(String id) async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request =
        Request(url: urlDeleteFinance, body: {"id": id, "lang": getLanguage()});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        ResponseModel data = ResponseModel.fromJson(json.decode(response.body));
        if (data.status == true) {
          apiGetUserList().then((_) {
            Prefs.setString(SUCCUSS_MSG, data.message!);
            Get.toNamed(ROUTE_REQUEST_SUCCESS);
          });
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
