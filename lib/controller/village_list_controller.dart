import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:get/get.dart';
import 'package:dwarikesh/model/villagewise_list_model.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'dart:convert';
import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';

class VillageWiseListController extends GetxController {
  var resListData = List<Data>.empty(growable: true).obs;
  var totalVillage = "0".obs;
  final responseCode = ''.obs;

  @override
  void onInit() {
    apiGetList();
    super.onInit();
  }

  void apiGetList() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));

    Request request =
        Request(url: urlVillageWiseList, body: {"lang": getLanguage()});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          VillagewiseListModel listModel =
              VillagewiseListModel.fromJson(json.decode(response.body));
          totalVillage.value = listModel.totalvillage.toString();
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
