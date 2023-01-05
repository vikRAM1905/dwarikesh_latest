import 'package:dwarikesh/model/agri_implements_model.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/pagination_filter.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';

class AgriImplementsController extends GetxController
    with SingleGetTickerProviderMixin {
  var listData = List<Data>.empty(growable: true).obs;
  var searchListData = <Data>[].obs;

  var status = ''.obs;

  final responseCode = ''.obs;
  TextEditingController? searchTextController;
  var isSearching = false.obs;
  var searchData = ''.obs;

  @override
  void onInit() {
    searchTextController = TextEditingController();
    searchTextController!.clear();

    apiGetList();

    super.onInit();
  }

  @override
  void onClose() {
    listData = <Data>[].obs;
    searchListData = <Data>[].obs;
    searchTextController!.clear();
    searchTextController!.dispose();

    super.onClose();
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
    searchTextController!.clear();
    updateSearchQuery("Search query");
    update();
  }

  void stopSearching() {
    clearSearchQuery();
    isSearching.value = false;
    update();
  }

  Future<void> updateSearchQuery(String newQuery) async {
    searchData.value = newQuery;
    print("search query " + newQuery);

    searchListData.clear();
    if (newQuery.isEmpty || newQuery.length < 0) {
      searchListData.clear();
      listData;
    }

    listData.forEach((value) {
      if (value.productName!
          .toLowerCase()
          .trim()
          .contains(newQuery.toLowerCase().trim())) {
        searchListData.add(value);
      }
    });
    update();
  }

  Future<void> onSearchTextChanged(String text) async {
    searchListData.clear();
    if (text.isEmpty || text.length < 0) {
      searchListData.clear();
      listData;
      return;
    }

    listData.forEach((value) {
      if (value.productName!
          .toLowerCase()
          .trim()
          .contains(text.toLowerCase().trim())) {
        searchListData.add(value);
      }
    });

    update();
  }

  Future<void> onClearTextChanged() async {
    searchListData.clear();
    listData;

    update();
  }

  void apiGetList() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request =
        Request(url: urlAgriImplements, body: {"lang": getLanguage()});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          AgriImplementsModel listModel =
              AgriImplementsModel.fromJson(json.decode(response.body));
          if (listModel.status == true) {
            listData.value = listModel.data!;
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
