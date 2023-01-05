import 'dart:convert';

import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/model/activity_completed_growerwise_model.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityCompletedGrowerddddwiseContoller extends GetxController {
  var resListData = List<Data>.empty(growable: true).obs;
  var searchListData = List<Data>.empty(growable: true).obs;
  final responseCode = ''.obs;
  TextEditingController? searchTextController;

  @override
  void onInit() {
    searchTextController = TextEditingController();
    searchTextController!.clear();
    apiGetList();
    super.onInit();
  }

  void apiGetList() async {
    String villageID = await Prefs.getString(VILLAGE_ID);
    String activityID = await Prefs.getString(ACTIVITY_ID);

    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request = Request(
        url: urlActivityCompletedGrowerList,
        body: {"villageid": villageID, "activityid": activityID});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          ActivityCompletedGowerwiseModel listModel =
              ActivityCompletedGowerwiseModel.fromJson(
                  json.decode(response.body));
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

  Future<void> onSearchTextChanged(String text) async {
    searchListData.clear();
    if (text.isEmpty || text.length < 0) {
      resListData.refresh();
      return;
    }

    resListData.forEach((value) {
      if (value.growername!
          .toLowerCase()
          .trim()
          .contains(text.toLowerCase().trim())) {
        resListData.refresh();
        searchListData.value.add(value);
      }

      searchListData.refresh();
    });

    update();
  }

  Future<void> onClearTextChanged() async {
    searchListData.clear();
    resListData.refresh();
    update();
  }

  @override
  void onClose() {
    resListData = <Data>[].obs;
    searchListData = <Data>[].obs;
    searchTextController!.clear();
    searchTextController!.dispose();

    super.onClose();
  }
}
