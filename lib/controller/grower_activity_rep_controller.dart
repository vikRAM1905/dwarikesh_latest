import 'dart:convert';

import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/model/activity_list_grower_model.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GrowerActivityRepCtrl extends GetxController {
  List<Data> activityListData = new List<Data>.empty(growable: true).obs;
  final ActivityListGrowerModel model = ActivityListGrowerModel();
  var totalRewardPoint = '0'.obs;
  var responseCode = '0'.obs;
  ScrollController scrollController = ScrollController();
  var pageNumber = 1.obs;
  var currentPNo = 1.obs;
  var upcomingPNo = 1.obs;
  var completedPNo = 1.obs;
  var tabPosition = 0.obs;
  var totalRecords = 0.obs;
  var isLoading = true.obs;
  var bottomLoading = true.obs;

  void onInit() {
    scrollPosition();
    fetchApiData();
    super.onInit();
  }

  Future<void> fetchApiData({int pageNumber = 1, int tabPosition = 0}) async {
    Map<String, dynamic> input = {
      "growerid": Prefs.getString(GROWER_ID),
      "lang": getLanguage(),
      "tabid": tabPosition.toString(),
      "page": pageNumber.toString(),
      "limit": 5.toString(),
      "plots": "All"
    };
    print("fetchSpaLists ${input}");

    if (activityListData.length == 0) {
      isLoading.value = true;
      activityListData.clear();
    } else if (pageNumber == 1) {
      activityListData.clear();
      isLoading.value = true;
    } else
      isLoading.value = false;

    var serviceCount = activityListData
        .where((x) => x.type.toString().contains(tabPosition.toString()))
        .toList();
    print(serviceCount);
    if (pageNumber == 1 && serviceCount.length > 0) {
      isLoading.value = false;
    } else {
      // print(totalRecords.value);
      // add  totalRecords here
      // print("fetchSpaLists ${isLoading.value}");
      Request request = Request(url: urlGowerwiseActivityDetail, body: input);

      request.post().then((response) {
        if (response.statusCode == 200) {
          ActivityListGrowerModel listModel =
              ActivityListGrowerModel.fromJson(json.decode(response.body));
          if (listModel.status == true) {
            totalRewardPoint.value = listModel.totalRewardPoints.toString();
            totalRecords.value = listModel.totalData!;

            // listModel.data.forEach((value) => activityListData.addAll(listModel.data));
            print('LENGHT OF ARRAY ${listModel.data!.length}');

            if (listModel.data!.length > 0) {
              final spaData = listModel.data!.toList();
              activityListData.addAll(spaData);
              print(activityListData.length);
            }
            isLoading.value = false;
          } else {
            responseCode.value = '403';
            totalRewardPoint.value = 0.toString();
          }
        } else {
          responseCode.value = response.statusCode.toString();
        }

        isLoading.value = false;

        update();
      }).catchError((onError) {
        isLoading.value = false;
        print(onError);
      });
    }
  }

  scrollPosition() async {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (tabPosition.value == 0) {
          currentPNo++;
          pageNumber.value = currentPNo.value;
        } else if (tabPosition.value == 1) {
          upcomingPNo++;
          pageNumber.value = upcomingPNo.value;
        } else {
          completedPNo++;
          pageNumber.value = completedPNo.value;
        }
        fetchApiData(
            pageNumber: pageNumber.value, tabPosition: tabPosition.value);
        update();
      }
    });
  }

  Future<void> updatetabPosition(int value) async {
    tabPosition.value = value;
    pageNumber.value = 1;
    fetchApiData(pageNumber: pageNumber.value, tabPosition: tabPosition.value);
    scrollController.animateTo(0,
        duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
    update();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
