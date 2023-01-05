import 'dart:math';

import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/model/info_center_model.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

class InfoCenterController extends GetxController {
  var resListData = List<Data>.empty(growable: true).obs;
  var searchListData = List<Data>.empty(growable: true).obs;
  var subtopicListData = List<Subtopic>.empty(growable: true).obs;
  var searchsubtopicListData = List<Subtopic>.empty(growable: true).obs;
  final responseCode = '200'.obs;
  final language = 1.obs;
  TextEditingController? searchTextController;
  TextEditingController? searchsubTopicTextController;
  final isExpand = false.obs;
  var isSearching = false.obs;
  var userComeNewly;
  var onInitLoading = true.obs;

  @override
  void onInit() {
    searchTextController = TextEditingController();
    searchsubTopicTextController = TextEditingController();
    searchTextController!.clear();
    searchsubTopicTextController!.clear();
    userComeNewly = true.obs;
    print('userCOME NEW LY : $userComeNewly');
    apiGetUserList();
    super.onInit();
  }

  Future<void> onClearTextChanged() async {
    apiGetUserList();
    update();
  }

  void startSearch(BuildContext context) {
    print("open search box");
    ModalRoute.of(context)!
        .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: stopSearching));
    isSearching.value = true;
    update();
  }

  void clearSearchQuery() {
    print("close search box");
    searchListData;
    update();
  }

  void stopSearching() {
    clearSearchQuery();
    isSearching.value = false;
    update();
  }

  Future<void> onSearchTextChanged(String text) async {
    if (text.isEmpty || text.length < 0) {
      resListData;
      return;
    } else
      apiGetUserList(keyword: text);

    update();
  }

  void apiGetUserList({String keyword = ''}) async {
    if (onInitLoading.value == true) {
      Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    }

    Request request = Request(
        url: urlInfoCenter, body: {"lang": getLanguage(), "keyword": keyword});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        InfoCenterModel listModel =
            InfoCenterModel.fromJson(json.decode(response.body));
        if (listModel.status == true) {
          resListData.value = listModel.data!;
          if (onInitLoading.value == true) {
            Get.back();
          }
          onInitLoading.value = false;
          userComeNewly.value = false;
        } else
          responseCode.value = '403';
      }

      update();
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void onClose() {
    resListData.clear();
    searchTextController!.clear();
    searchTextController!.dispose();

    super.onClose();
  }
}
