import 'dart:convert';

import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/model/cfa_grower_detrail_model.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:get/get.dart';

class CFaReportGrowerDetail extends GetxController {
  var growerID = Get.arguments;
  var growerName = ''.obs;
  var growerPhone = ''.obs;
  var growerFather = ''.obs;
  var growerReward = ''.obs;
  var responseCode = ''.obs;
  var aadhar = ''.obs;
  var bank = ''.obs;
  var menuList = List<Menu>.empty(growable: true).obs;
  var plotdataList = List<Plotdata>.empty(growable: true).obs;

  @override
  void onInit() {
    getDataAPI();
    super.onInit();
  }

  void getDataAPI() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request = Request(
        url: urlGowerwiseDetail,
        body: {'growerid': growerID, "lang": getLanguage()});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          CfaReportGrowerDetailModel listModel =
              CfaReportGrowerDetailModel.fromJson(json.decode(response.body));
          if (listModel.status == true) {
            growerName.value = listModel.name!;
            growerPhone.value = listModel.phonenumber!;
            growerFather.value = listModel.fname!;
            growerReward.value = listModel.points!;
            menuList.value = listModel.menu!;
            plotdataList.value = listModel.plotdata!;
            aadhar.value = listModel.aadhar!;
            bank.value = listModel.bankAccount!;
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
