import 'dart:convert';
import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/model/profile_model.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:dwarikesh/widgets/snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final responseCode = ''.obs;
  ProfileModel? usermodel;
  var isLoading = false.obs;
  TextEditingController? commentTextController;
  @override
  void onInit() {
    userAPI();
    commentTextController = TextEditingController();
    super.onInit();
  }

  Future<void> userAPI() async {
    isLoading.value = true;
    print('is LOADING ON BEDORE API ${isLoading.value}');
    Request request = Request(url: urlProfile, body: {
      "lang": getLanguage(),
    });
    request.post().then((response) async {
      if (response.statusCode == 200) {
        responseCode.value = '200';
        usermodel = ProfileModel.fromJson(json.decode(response.body));
        isLoading.value = false;
        print('is LOADING ON AFTER API ${isLoading.value}');
        update();
      }
    }).catchError((onError) {
      isLoading.value = false;
      update();
      print(onError);
    });
  }

  Future<void> validation(String plotID) async {
    if (commentTextController!.text.isNotEmpty)
      deleteAPI(plotID, commentTextController!.text);
    else
      snakbarMsg(
          icon: Icons.dangerous,
          title: 'reason'.tr + ' *',
          msg: 'explain_query'.tr,
          colors: Colors.white,
          bgColor: Colors.redAccent);
  }

  Future<void> deleteAPI(String plotId, String reason) async {
    isLoading.value = true;
    print('is LOADING ON BEDORE API ${isLoading.value}');
    Request request = Request(url: urlDeleteRatoon, body: {
      "plotid": plotId,
      "reason": reason,
    });
    request.post().then((response) async {
      if (response.statusCode == 200) {
        responseCode.value = '200';
        isLoading.value = false;
        print('is LOADING ON AFTER API ${isLoading.value}');
        commentTextController!.clear();
        userAPI();
        update();
      }
    }).catchError((onError) {
      isLoading.value = false;
      update();
      print(onError);
    });
  }

  @override
  void dispose() {
    commentTextController!.clear();
    commentTextController!.dispose();
    super.dispose();
  }
}
