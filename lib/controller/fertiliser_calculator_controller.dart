import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/model/fertiliser_calculator_model.dart';
import 'package:dwarikesh/model/fertiliser_menu_model.dart' as menuModel;
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:dwarikesh/widgets/snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FertiliserCalculatorController extends GetxController {
  TextEditingController? areaTextController;
  var areaTypeData = [].obs;
  final areaType = 'hectare'.tr.obs;
  final selectedpos = 1.obs;
  var classification = [].obs;
  final responseCode = ''.obs;
  var menuListData = List<menuModel.Data>.empty(growable: true).obs;
  var combinationTypeList = List<menuModel.Type>.empty(growable: true).obs;
  var fertilizerTypeList = List<menuModel.Fertilizer>.empty(growable: true).obs;

  var radioSelected = 1.obs;

  var combination = ''.obs;
  var croptype = ''.obs;
  var useoffertilizer = ''.obs;

  final language = 0.obs;

  @override
  void onInit() {
    areaTextController = TextEditingController();
    classification = [1, 2, 3, 4].obs;
    getMenuApi();
    super.onInit();
  }

  @override
  void onClose() {
    areaTextController!.clear();
    areaTextController!.dispose();
    super.onClose();
  }

  Future<void> updateValue(String value) async {
    areaType.value = value;
    update();
  }

  Future<void> selectedClassification(int value) async {
    selectedpos.value = value;
    print('SELECTED POSITION :- ${selectedpos.value}');
    update();
  }

  Future<void> selectedcombination(List<menuModel.Type> value) async {
    print('value is printed ${value}');

    for (int i = 0; i < value.length; i++) {}
    combinationTypeList.clear();

    print('Array Size of Comintaion Type : ${combinationTypeList.length}');
    combinationTypeList.refresh();
    update();
  }

  Future<void> onTextChanged(String text) async {
    update();
  }

  void getMenuApi() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request =
        Request(url: urlFertiliserMenu, body: {"lang": getLanguage()});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      print(
          '----------------------RESPONSE CODE ${response.statusCode}    BODY : ${response.body} ------------------------------------------');
      if (response.statusCode == 200) {
        menuModel.FertilizerMenuModel listModel =
            menuModel.FertilizerMenuModel.fromJson(json.decode(response.body));
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

  void validation() async {
    double inputValue;
    String classificationData;
    if (areaTextController!.text.length > 0 &&
        areaTextController!.text != '0' &&
        areaTextController!.text != '0.0' &&
        areaTextController!.text != '0.00' &&
        areaTextController!.text != '00.0') {
      if (areaType.value == 'bigha'.tr) {
        var myDouble = double.parse(areaTextController!.text);
        assert(myDouble is double);
        inputValue = myDouble * 3.025;
      } else if (areaType.value == 'hectare'.tr) {
        var myDouble = double.parse(areaTextController!.text);
        assert(myDouble is double);
        inputValue = myDouble * 2.5;
      } else {
        var myDouble = double.parse(areaTextController!.text);
        assert(myDouble is double);
        inputValue = myDouble;
      }
      if (croptype.value != '') if (combination.value !=
          '') if (useoffertilizer != '') {
        await Prefs.setString(
            USERUNIT, '${areaTextController!.text} ${areaType.value}');
        await Prefs.setString(UNIT, inputValue.toString());
        await Prefs.setString(COMBINATION, combination.value);
        await Prefs.setString(CROP_TYPE, croptype.value);
        await Prefs.setString(USE_OF_FERTILIZER, useoffertilizer.value);
        Get.toNamed(ROUTE_FERTILISER_RESULT);
      } else
        snakbarMsg(
            icon: Icons.dangerous,
            title: 'Use of Fertilizer !',
            msg: 'Select Fertilizer value ',
            colors: Colors.white,
            bgColor: Colors.redAccent);
      else
        snakbarMsg(
            icon: Icons.dangerous,
            title: 'Combination !',
            msg: 'Select Combinationtype value ',
            colors: Colors.white,
            bgColor: Colors.redAccent);
      else
        snakbarMsg(
            icon: Icons.dangerous,
            title: 'Crop Type !',
            msg: 'Select Crop type value ',
            colors: Colors.white,
            bgColor: Colors.redAccent);
    } else
      snakbarMsg(
          icon: Icons.dangerous,
          title: 'Area !',
          msg: 'Enter correct Area value in the box',
          colors: Colors.white,
          bgColor: Colors.redAccent);
  }

  String? validateMyInput(String value) {
    RegExp regex = new RegExp(r'^(?=\D*(?:\d\D*){1,12}$)\d+(?:\.\d{1,4})?$');
    if (!regex.hasMatch(value))
      return 'Enter Valid Number';
    else
      return null;
  }

  void calculationApi(double inputvalue) async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));

    Request request = Request(url: urlFertiliserCalc, body: {
      "unit": inputvalue.toString(),
      "combination": combination.value,
      "croptype": croptype.value,
      "useoffertilizer": useoffertilizer.value
    });
    request.post().then((response) async {
      if (response.statusCode == 200) {
        FertiliserCalculatorModel listModel =
            FertiliserCalculatorModel.fromJson(json.decode(response.body));
        if (listModel.status == true) {}
      }
      Get.back();
      update();
    }).catchError((onError) {
      print(onError);
    });
  }
}
