import 'dart:convert';

import 'package:dwarikesh/api/request.dart';
import 'package:get/get.dart';

import '../api/url.dart';
import '../model/formList_model.dart';

class FormListController extends GetxController {
  var plotList = List<Demoplots>.empty(growable: true).obs;
  var formList = List<DemoplotHeaderInfo>.empty(growable: true).obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getFormListApi();
    super.onInit();
  }

  void getFormListApi() {
    isLoading.value = true;
    Request request = Request(url: urlFormList);
    request.post().then((response) async {
      print(
          'DASH BOARD RESPONSE : ${json.decode(response.statusCode.toString())}');
      if (response.statusCode == 200) {
        PlotListModel listModel =
            PlotListModel.fromJson(json.decode(response.body));
        print('FORM LIST RESPONSE : ${json.decode(response.body)}');
        if (listModel.status == true) {
          listModel.demoplots!.forEach((element) {
            plotList.add(element);
          });
          listModel.demoplotHeaderInfo!.forEach((element) {
            formList.add(element);
          });
        }
      }
      isLoading.value = false;
      // Get.back();
      update();
    }).catchError((onError) {
      print(onError);
    });
  }
}
