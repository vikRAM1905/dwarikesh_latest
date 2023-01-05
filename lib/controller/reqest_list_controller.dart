import 'dart:convert';
import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/controller/request_add_controller.dart';
import 'package:dwarikesh/model/request_add_model.dart' as reqMenu;
import 'package:dwarikesh/model/request_list_model.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:get/get.dart';

class RequestListController extends GetxController {
  var menuListData = List<reqMenu.Data>.empty(growable: true).obs;
  var reqListData = List<Data>.empty(growable: true).obs;
  var searchListData = List<Data>.empty(growable: true).obs;
  var suggestionListData = List<Suggestion>.empty(growable: true).obs;
  final responseCode = ''.obs;
  final tabPosition = 0.obs;
  final filterAvailable = true.obs;
  final tempDate = ''.obs;

  @override
  void onInit() {
    print('DATA INIT');
    getMenuList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> onSearchTextChanged(String text) async {
    searchListData.clear();
    if (text.isEmpty || text == 'all'.tr) {
      filterAvailable.value = true;
      reqListData;
      return;
    }

    reqListData.forEach((value) {
      if (value.requesttype!
          .toLowerCase()
          .trim()
          .contains(text.toLowerCase().trim())) {
        print('VALUE OF SEARCHED LIST DATA : ${text}');
        filterAvailable.value = true;
        searchListData.add(value);
      } else {
        filterAvailable.value = false;
        print('NO DATA FOUND');
      }
    });

    update();
  }

  void getMenuList() async {
    print('MENU LIST ');

    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request =
        Request(url: urlRequestType, body: {"lang": getLanguage()});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        apiGetUserList();

        reqMenu.RequestAddModel listModel =
            reqMenu.RequestAddModel.fromJson(json.decode(response.body));
        listModel.data!.insert(0, reqMenu.Data(type: "all".tr));
        if (listModel.status == true) {
          menuListData.value = listModel.data!;
        } else
          responseCode.value = '403';
      }

      Get.back();
      update();
    }).catchError((onError) {
      print(onError);
    });
  }

  void apiGetUserList() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request =
        Request(url: urlRequestList, body: {"lang": getLanguage()});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();

      print('RESPONSE DATA ${response.body}');
      if (response.statusCode == 200) {
        RequestListModel listModel =
            RequestListModel.fromJson(json.decode(response.body));

        if (listModel.success == true) {
          reqListData.value = listModel.data!;
        } else
          responseCode.value = '403';
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
}
