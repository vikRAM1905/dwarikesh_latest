import 'dart:convert';

import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/model/fertiliser_calculator_model.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:get/get.dart';

class FertiliserResultController extends GetxController {
  final responseCode = ''.obs;
  var resListData = List<Data>.empty(growable: true).obs;

  @override
  void onInit() {
    calculationApi();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void calculationApi() async {
    String unit = Prefs.getString(UNIT);
    String combination = Prefs.getString(COMBINATION);
    String croptype = Prefs.getString(CROP_TYPE);
    String useoffertilizer = Prefs.getString(USE_OF_FERTILIZER);

    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));

    Request request = Request(url: urlFertiliserCalc, body: {
      "unit": unit,
      "combination": combination,
      "croptype": croptype,
      "useoffertilizer": useoffertilizer
    });
    request.post().then((response) async {
      if (response.statusCode == 200) {
        FertiliserCalculatorModel listModel =
            FertiliserCalculatorModel.fromJson(json.decode(response.body));
        if (listModel.status == true) {
          resListData.value = listModel.data!;
        }
      }
      Get.back();
      update();
    }).catchError((onError) {
      print(onError);
    });
  }
}
