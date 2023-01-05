import 'package:dwarikesh/model/transaction_list_model.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';

class TransactionListController extends GetxController {
  var resListData = List<Data>.empty(growable: true).obs;
  final status = false.obs;
  final responseCode = ''.obs;
  final tabPosition = 0.obs;
  final tempDate = ''.obs;

  @override
  void onInit() {
    apiGetList();
    super.onInit();
  }

  Future<void> updatetabPosition(int value) async {
    tabPosition.value = value;
    update();
  }

  void apiGetList() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request =
        Request(url: urlTransactionList, body: {"lang": getLanguage()});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          TransactionListModel listModel =
              TransactionListModel.fromJson(json.decode(response.body));
          if (listModel.status == true) {
            status.value = true;
            resListData.value = listModel.data!;
          } else {
            responseCode.value = '403';
            status.value = false;
          }
        }
      }

      Get.back();
      update();
    }).catchError((onError) {
      print(onError);
    });
  }
}
