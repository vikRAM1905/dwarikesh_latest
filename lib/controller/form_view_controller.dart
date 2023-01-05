import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/request.dart';
import '../api/url.dart';
import '../model/form_view_model.dart';

class FormViewController extends GetxController {
  var isLoading = false.obs;
  var id;
  var formDetail = List<Data>.empty(growable: true).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    id = Get.arguments;
    getData(id.toString());
    super.onInit();
  }

  void getData(id) async {
    isLoading.value = true;
    Map<String, dynamic> body = {"id": id};
    Request request =
        Request(url: urlDemoPlotView, body: body); // body: inputBody);
    request.post().then((response) async {
      print(
          'FORM VIEW RESPONSE : ${json.decode(response.statusCode.toString())}');
      if (response.statusCode == 200) {
        // Get.back();
        var data = json.decode(response.body);
        if (data['status']) {
          FormViewModel formViewModel = FormViewModel.fromJson(data);
          formViewModel.data!.forEach((element) {
            formDetail.add(element);
          });
        } else {
          Get.snackbar("Error", "Incorrect value",
              colorText: Colors.white,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
        }
      } else {
        // Get.back();
        Get.snackbar("Error", "Incorrect value",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP);
        throw Exception();
      }
      isLoading.value = false;
      update();
    }).catchError((onError) {
      print(onError);
    });
  }
}
