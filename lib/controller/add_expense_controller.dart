import 'package:dwarikesh/controller/finance_list_controller.dart';
import 'package:dwarikesh/model/expanse_list_model.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:dwarikesh/widgets/snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AddExpenseController extends GetxController {
  final responseCode = ''.obs;
  FinanceListController listController = Get.put(FinanceListController());
  var resListData = List<Data>.empty(growable: true).obs;
  var particularData = List<Particulars>.empty(growable: true).obs;
  var radioButtonArray = List<Particulars>.empty(growable: true).obs;
  TextEditingController? areaTextController;
  List<TextEditingController> editTextControllers =
      new List<TextEditingController>.empty(growable: true);

  List<dynamic> storedData = [];
  final caneArea = ''.obs;
  final culturableArea = ''.obs;
  final userAreaValue = ''.obs;
  final userAreaTitle = ''.obs;

  Map<String, dynamic> quantities = {};
  var quantitiesList = List<Quantities>.empty(growable: true).obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    areaTextController = new TextEditingController();
    getApiData();
    super.onInit();
  }

  @override
  void onClose() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    areaTextController!.clear();
    editTextControllers.clear();
    update();
    super.onClose();
  }

  Future<void> saveRadioParticularsData(
      Particulars model, var inputValue) async {
    quantitiesList.add(Quantities(
        id: model.id,
        type: model.categoryName.toString(),
        qty: inputValue.toString()));
    print("List Count : ${quantitiesList.length}");
    //storedData.add(quantities);
    for (int i = 0; i < quantitiesList.length; i++) {
      print(
          "{id: ${quantitiesList[i].id},type: ${quantitiesList[i].type},qty: ${quantitiesList[i].getQty}}");
    }
    update();
  }

  Future<void> updateCheckBoxValue(Particulars model, var inputValue) async {
    for (int i = 0; i < quantitiesList.length; i++) {
      if (model.id == quantitiesList[i].id) {
        quantitiesList[i].setQty = inputValue;
      }
      print(
          "Update : {id: ${quantitiesList[i].id},type: ${quantitiesList[i].type},qty: ${quantitiesList[i].getQty}}");
    }
  }

  Future<void> saveCheckboxParticularsData(
      Particulars model, var inputValue) async {
    quantitiesList.add(Quantities(
        id: model.id,
        type: model.categoryName.toString(),
        qty: inputValue.toString()));
    print("List length : ${quantitiesList.length}");
    // print("Add Record..!");
    // Map<String, dynamic> quantities = {};

    // try {
    //   quantities['id'] = model.id;
    //   quantities['type'] = model.categoryName.toString();
    //   quantities['qty'] = inputValue.toString();
    // } on FormatException {}
    // storedData.add(quantities);
    //
    // Quantities data = Quantities.fromJson(quantities);
    // //
    quantitiesList.forEach((element) {
      //element.setQty = "Sudhir ${count++}";
      print("{id: ${element.id},type: ${element.type},qty: ${element.getQty}}");
    });
    update();
  }

  Future<void> removeCheckboxParticularsData(Particulars model) async {
    print("Remove Record..!${model.id}");
    for (int i = 0; i < quantitiesList.length; i++) {
      if (model.id == quantitiesList[i].id) {
        //print("aaaaaa ${model.id} bbbb ${quantitiesList[i].id}");
        quantitiesList.removeAt(i);
      }
      print(
          "{id: ${quantitiesList[i].id},type: ${quantitiesList[i].type},qty: ${quantitiesList[i].getQty}}");
    }
    update();
  }

  Future<void> getApiData() async {
    isLoading.value = true;
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request =
        Request(url: urlAddExpanse, body: {"lang": getLanguage()});
    resListData.clear();
    particularData.clear();
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        NewExpanseModel listModel =
            NewExpanseModel.fromJson(json.decode(response.body));
        if (listModel.status == true) {
          resListData.value = listModel.data!;
          caneArea.value = listModel.caneArea!;
          culturableArea.value = listModel.culturableArea!;
          userAreaTitle.value = listModel.title!;
          resListData.forEach((data) {
            particularData.addAll(data.particulars!);
            print("Data Response : ${data.toJson()}");
          });
          resListData.forEach((data) {
            for (int i = 0; i < particularData.length; i++) {
              editTextControllers.add(new TextEditingController());
              //print("List Controller : ${editTextControllers.length}");
            }
          });
          // particularData.forEach((data) {
          //   radioButtonArray.add(data);
          // });
          // for(int i = 0; i<particularData.length; i++){
          //   radioButtonArray.add(particularData[i]);
          //   print("List Controller : ${editTextControllers.length}");
          // }
        } else
          responseCode.value = '403';
      }
      isLoading.value = false;
      Get.back();
      update();
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> areaValidation(value) async {
    //print();
    double textFieldValue = double.parse(areaTextController!.text);
    double less = double.parse(caneArea.value);
    double greater = double.parse(culturableArea.value);
    if (areaTextController!.text.isNotEmpty) {
      if (greater <= textFieldValue && less >= textFieldValue) {
        snakbarMsg(
            icon: Icons.done,
            title: 'description'.tr + ' *',
            msg: 'Success',
            colors: Colors.white,
            bgColor: Colors.green);

        userAreaValue.value = areaTextController!.text;
      } else {
        snakbarMsg(
            icon: Icons.dangerous,
            title: 'description'.tr + ' *',
            msg: 'Invalid',
            colors: Colors.white,
            bgColor: Colors.redAccent);
      }
    } else {
      snakbarMsg(
          icon: Icons.dangerous,
          title: 'description'.tr + ' *',
          msg: 'Invalid',
          colors: Colors.white,
          bgColor: Colors.redAccent);
    }
  }

  Future<void> expenseValidation(
      int index, int section, int sectionIndex, Particulars model) async {
    int maxValue = int.parse(
        resListData[sectionIndex].particulars![index].rangePerHecMax!);
    int minValue = int.parse(
        resListData[sectionIndex].particulars![index].rangePerHecMin!);
    int textFiledValue = int.parse(editTextControllers[section].text);

    print("Max Value : $maxValue");
    print("Min Value : $minValue");

    print("Section Index : $section");
    print(" Index : $index");
    print("sectionIndex Index : $sectionIndex");

    if (minValue <= textFiledValue && maxValue >= textFiledValue) {
      print("Valid value");
      updateCheckBoxValue(model, editTextControllers[section].text);
    } else {
      snakbarMsg(
          icon: Icons.dangerous,
          title: 'alert'.tr + ' *',
          msg: model.alert,
          colors: Colors.white,
          bgColor: Colors.redAccent);
    }
  }

  void getExpenseResponseApiData() async {
    String data = jsonEncode(quantitiesList);
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request = Request(url: urlAddFinance, body: {
      "lang": getLanguage(),
      "expenseJson": data,
      "area": areaTextController!.text
    });

    request.post().then((response) async {
      Get.back();
      if (response.statusCode == 200) {
        ExpenseResponseModel listModel =
            ExpenseResponseModel.fromJson(json.decode(response.body));

        if (listModel.status == true) {
          listController.apiGetUserList();
          Prefs.setString(SUCCUSS_MSG, '${'entry_added'.tr}');
          Get.offNamed(ROUTE_FINANCE_SUCCESS);
        } else
          snakbarMsg(
              icon: Icons.clear,
              title: listModel.status.toString(),
              msg: 'Sorry !',
              colors: Colors.white,
              bgColor: Colors.red);
      } else {
        responseCode.value = response.statusCode.toString();
      }

      update();
    }).catchError((onError) {
      print(onError);
    });
  }
}

class ExpenseResponseModel {
  bool? status;
  ExpenseResponseModel({this.status});

  ExpenseResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}

class Quantities {
  int? id;
  String? type;
  String? qty;

  Quantities({
    this.id,
    this.type,
    this.qty,
  });

  @override
  String toString() {
    return '{id:${this.id},type:${this.type},qty:${this.qty}}';
  }

  Quantities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['qty'] = this.qty;
    return data;
  }

  String? get getQty {
    return qty;
  }

  set setQty(String value) {
    qty = value;
  }
}
