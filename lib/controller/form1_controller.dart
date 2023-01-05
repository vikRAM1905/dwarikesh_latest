import 'dart:convert';
import 'dart:convert' as convert;

import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/controller/formList_controller.dart';
import 'package:dwarikesh/model/form1_model.dart';
import 'package:dwarikesh/model/formList_model.dart';
import 'package:dwarikesh/view/form/form_list_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/url.dart';
import '../utils/constant.dart';
import '../view/dashboard/home.dart';
import 'package:http/http.dart' as http;

class FormController extends GetxController {
  final formListController = Get.put(FormListController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController villageCodeText = TextEditingController();
  final TextEditingController villageNameText = TextEditingController();
  final TextEditingController growerCodeText = TextEditingController();
  final TextEditingController growerNameText = TextEditingController();
  final TextEditingController growerFatherNameText = TextEditingController();
  final TextEditingController varietyCodeText = TextEditingController();
  final TextEditingController varietyNameText = TextEditingController();
  final TextEditingController plantDateText = TextEditingController();
  final TextEditingController areaText = TextEditingController();
  final TextEditingController harvestStartDateText = TextEditingController();
  final TextEditingController harvestEndDateText = TextEditingController();
  final TextEditingController cropDaysText = TextEditingController();
  final TextEditingController productionYieldText = TextEditingController();
  String? selectedCity;

  var isLoading = false.obs;
  var plantingMethodList = List<PlantingMethod>.empty(growable: true).obs;
  var cropTypeList = List<Croptype>.empty(growable: true).obs;
  var checkList = List<Data1>.empty(growable: true).obs;
  var interCropList = List<Intercrop>.empty(growable: true).obs;
  var result = List<String>.empty(growable: true).obs;
  var growerList = List<GrowerData>.empty(growable: true).obs;
  var growerCodeList = List<String>.empty(growable: true).obs;
  var varietyList = List<VarietyData>.empty(growable: true).obs;
  var varietyCodeList = List<String>.empty(growable: true).obs;
  var demolist = List<VillageSuggestion>.empty(growable: true).obs;
  // var codeName = "".obs;
  DateTime? plantDate;
  DateTime? hStartDate;
  DateTime? hEndDate;
  var cropType = "Select".obs;
  var plantingMethod = "Select".obs;
  var intercrop = "Select".obs;
  var villageName = "".obs;
  var villageCode = "".obs;
  var farmerName = "".obs;
  var villageSelect = "".obs;
  var growerSelect = "".obs;
  var growerFatherSelect = "".obs;
  var varietySelect = "".obs;
  var varietyNameSelect = "Select Variety Name".obs;
  var fatherName = "".obs;
  var varietyName = "".obs;
  var area = "".obs;
  var dateText = "".obs;
  var startDateForHarvest = "".obs;
  var endDateForHarvest = "".obs;
  // var farmerName = "".obs;
  var crobDays = "".obs;
  var productionYield = "".obs;
  final FocusNode node1 = FocusNode();
  final FocusNode node2 = FocusNode();
  final FocusNode node3 = FocusNode();
  final FocusNode node4 = FocusNode();
  final FocusNode node5 = FocusNode();
  var searchVillage = false.obs;
  var searchFarmer = false.obs;
  var searchVeriety = false.obs;
  DateTime currentDate = DateTime.now();
  var isVisible = true.obs;
  var isVisible1 = true.obs;
  var isVisible2 = true.obs;
  var vCodeEnable = false.obs;
  // var isLoading = false.obs;

  void villageBoolChange() {
    searchVillage.value = true;
    update();
  }

  void farmerBoolChange() {
    searchFarmer.value = true;
    update();
  }

  void verietyBoolChange() {
    searchVeriety.value = true;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    // callVillageApi();
    callVarietyApi();
    callCropTypeListApi();
    callInterCropListApi();
    callPlantingMethodListApi();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  updateCropType(val) {
    cropType.value = val;
    update();
  }

  updatePlantingMethod(val) {
    plantingMethod.value = val;
    update();
  }

  updateInterCrop(val) {
    intercrop.value = val;
    update();
  }

  getFatherName(farmerName) {
    growerList.forEach((element) {
      if (element.growerName == farmerName) {
        growerFatherSelect.value = element.growerFatherName!;
      }
    });
    update();
  }

  getVarietyName(varietyCode) {
    varietyList.forEach((element) {
      if (element.varietyCode == varietyCode) {
        varietyNameSelect.value = element.varietyName!;
      }
    });
    update();
  }

  selectVillage(string) async {
    villageCodeText.text = string;
    isVisible.value = false;
    vCodeEnable.value = true;
    node1.nextFocus();
    node1.nextFocus();
    update();
  }

  selectGrower(string) async {
    growerCodeText.text = string;
    isVisible1.value = false;
    node2.nextFocus();
    node2.nextFocus();
    update();
  }

  selectVarietyCode(val) {
    varietyNameSelect.value = val;
    varietyNameText.text = val;
    update();
  }

  disposeControllers() {
    villageCodeText.clear();
    villageNameText.clear();
    growerCodeText.clear();
    growerNameText.clear();
    growerFatherNameText.clear();
    varietyCodeText.clear();
    varietyNameText.clear();
    plantDateText.clear();
    areaText.clear();
    harvestStartDateText.clear();
    harvestEndDateText.clear();
    cropDaysText.clear();
    productionYieldText.clear();
    cropType.value = "Select";
    plantingMethod.value = "Select";
    intercrop.value = "Select";
    villageName.value = "";
    villageCode.value = "";
    varietyNameSelect.value = "Select";
    fatherName.value = "";
    varietyName.value = "";
    area.value = "";
    dateText.value = "";
    startDateForHarvest.value = "";
    endDateForHarvest.value = "";
    farmerName.value = "";
    crobDays.value = "";
    productionYield.value = "";
    update();
  }

  void onSubmit() async {
    Map<String, dynamic> inputBody = {
      "village_code": "",
      "village_name": villageCodeText.text,
      "grower_code": "",
      "grower_name": growerCodeText.text,
      "grower_father_name": growerFatherNameText.text,
      "croptype": cropType.value,
      "date_of_planting": dateText.value,
      "area": areaText.text,
      "variety_code": "",
      "variety_name": varietyNameSelect.value,
      "planting_method": plantingMethod.value,
      "intercrop": intercrop.value == "Select" ? "" : intercrop.value,
      "harvesting_start_date": startDateForHarvest.value,
      "harvesting_end_date": endDateForHarvest.value,
      "cropdays": crobDays.value,
      "production": productionYieldText.text
    };
    isLoading.value = true;
    Request request = Request(url: urlDemoPlotHeaderStore, body: inputBody);
    request.post().then((response) async {
      print(inputBody);
      print(
          'SUBMIT  RESPONSE : ${json.decode(response.statusCode.toString())}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status']) {
          Get.back();
          Get.back();
          disposeControllers();
          Get.snackbar("Success", data['msg'],
              colorText: Colors.white,
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.BOTTOM);
          // Get.back();
        } else {
          Get.snackbar("Error", data['msg'],
              colorText: Colors.white,
              backgroundColor: Colors.blue,
              snackPosition: SnackPosition.BOTTOM);
        }
      }
      isLoading.value = false;
      // Get.back();
      update();
    }).catchError((onError) {
      print(onError);
    });
  }
  //   // var body = {"village_code": code};
  //   final url = Uri.parse(
  //       "https://admin.dwarikeshkisaanmittra.com/api/demoplotheaderstore");
  //   final response = await http.post(url, headers: headers, body: inputBody);

  //   if (response.statusCode == 200) {
  //     // Get.back();
  //     var data = json.decode(response.body);
  //     if (data['status']) {
  //       Get.snackbar("Success", data['msg'],
  //           colorText: Colors.white,
  //           backgroundColor: Colors.green,
  //           snackPosition: SnackPosition.TOP);
  //       // Get.back();
  //     } else {
  //       Get.snackbar("Error", data['msg'],
  //           colorText: Colors.white,
  //           backgroundColor: Colors.blue,
  //           snackPosition: SnackPosition.TOP);
  //     }
  //     isLoading.value = false;
  //   } else {
  //     // Get.back();
  //     throw Exception();
  //   }
  //   update();
  // }

  Future<bool> checkValidVillageApi(name) async {
    // isLoading.value = true;
    var inputBody = {"village_name": name};
    bool status = false;
    Request request = Request(url: urlValidVillage, body: inputBody);
    await request.post().then((response) async {
      print(
          'Valid Check Response: ${json.decode(response.statusCode.toString())}');
      if (response.statusCode == 200) {
        // Get.back();
        var data = json.decode(response.body);
        if (data['status']) {
          // CropTypeModel cropType = CropTypeModel.fromJson(data);
          // cropType.croptype!.forEach((element) => {cropTypeList.add(element)});
          status = data['status'];
        } else {
          Get.snackbar("Error", "Incorrect value",
              colorText: Colors.white,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
        }
        // isLoading.value = false;
      } else {
        // Get.back();
        throw Exception();
      }
      update();
    }).catchError((onError) {
      print(onError);
    });
    return status;
  }

  void callCropTypeListApi() async {
    isLoading.value = true;
    Request request = Request(url: urlCropType);
    request.post().then((response) async {
      // print(inputBody);
      print(
          'Crop Type Response: ${json.decode(response.statusCode.toString())}');
      if (response.statusCode == 200) {
        // Get.back();
        var data = json.decode(response.body);
        if (data['status']) {
          CropTypeModel cropType = CropTypeModel.fromJson(data);
          cropType.croptype!.forEach((element) => {cropTypeList.add(element)});
        } else {
          Get.snackbar("Error", "Incorrect value",
              colorText: Colors.white,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
        }
        isLoading.value = false;
      } else {
        // Get.back();
        throw Exception();
      }
      update();
    }).catchError((onError) {
      print(onError);
    });
  }

  void callPlantingMethodListApi() async {
    isLoading.value = true;
    Request request = Request(
      url: urlPlantingMethod,
    );
    request.post().then((response) async {
      print(
          'Planting Method  RESPONSE : ${json.decode(response.statusCode.toString())}');
      if (response.statusCode == 200) {
        // Get.back();
        var data = json.decode(response.body);
        if (data['status']) {
          PlantingMethodModel plantingMethodData =
              PlantingMethodModel.fromJson(data);
          plantingMethodData.plantingMethod!
              .forEach((element) => {plantingMethodList.add(element)});
        } else {
          Get.snackbar("Error", "Incorrect value",
              colorText: Colors.white,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
        }
        isLoading.value = false;
      } else {
        // Get.back();
        throw Exception();
      }
      update();
    }).catchError((onError) {
      print(onError);
    });
  }

  void callInterCropListApi() async {
    isLoading.value = true;
    Request request = Request(
      url: urlInterCrop,
    );
    request.post().then((response) async {
      print(
          'INTER CROP  RESPONSE : ${json.decode(response.statusCode.toString())}');
      if (response.statusCode == 200) {
        // Get.back();
        var data = json.decode(response.body);
        if (data['status']) {
          InterCropModel interCropModel = InterCropModel.fromJson(data);
          interCropModel.intercrop!
              .forEach((element) => {interCropList.add(element)});
        } else {
          Get.snackbar("Error", "Incorrect value",
              colorText: Colors.white,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
        }
        isLoading.value = false;
      } else {
        // Get.back();
        throw Exception();
      }
      update();
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<List<Map<String, String>>> getVillageSuggestions(String query) async {
    var inputBody = {"village_code": query};
    if (query.isEmpty) {
      print('Query needs to be at least 3 chars');
      return Future.value([]);
    }
    List<VillageSuggestion> suggestions = [];
    // var url = Uri.https('api.datamuse.com', '/sug', {'s': query});

    // var response = await http.get(url);
    Request request = Request(url: urlvillagecode, body: inputBody);
    await request.post().then((response) async {
      if (response.statusCode == 200) {
        var json = convert.json.decode(response.body.toString());
        print("===========${json.toString()}");
        suggestions = List<VillageSuggestion>.from(
            json['data'].map((model) => VillageSuggestion.fromJson(model)));

        print('Number of suggestion: ${suggestions.length}.');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    });
    update();

    return Future.value(suggestions
        .map((e) => {
              'village_code': e.village_code!,
              'village_name': e.village_name.toString()
            })
        .toList());
  }

  Future<List<Map<String, String>>> getGrowerSuggestions(String query) async {
    var inputBody = {
      "village_code": villageCodeText.text,
      "grower_code": query,
    };

    if (query.isEmpty) {
      print('Query needs to be at least 3 chars');
      return Future.value([]);
    }
    List<GrowerData> suggestions = [];
    // var url = Uri.https('api.datamuse.com', '/sug', {'s': query});

    // var response = await http.get(url);

    Request request = Request(url: urlgrowerCode, body: inputBody);
    await request.post().then((response) async {
      if (response.statusCode == 200) {
        var json = convert.json.decode(response.body.toString());
        GrowerListModel list = GrowerListModel.fromJson(json);
        list.data!.forEach((element) {
          suggestions.add(element);
          growerList.add(element);
        });

        print('Number of suggestion: ${suggestions.length}.');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    });
    update();

    return Future.value(suggestions
        .map((e) => {
              'growerName': e.growerName!,
              'growerFatherName': e.growerFatherName!
            })
        .toList());
  }

  Future<List<Map<String, String>>> getVarietySuggestions(String query) async {
    var inputBody = {"variety": query};

    if (query.isEmpty) {
      print('Query needs to be at least 3 chars');
      return Future.value([]);
    }
    List<VarietyData> suggestions = [];
    // var url = Uri.https('api.datamuse.com', '/sug', {'s': query});

    // var response = await http.get(url);

    Request request = Request(url: urlVariety, body: inputBody);
    await request.post().then((response) async {
      if (response.statusCode == 200) {
        var json = convert.json.decode(response.body.toString());
        VarietyListModel list = VarietyListModel.fromJson(json);
        list.data!.forEach((element) {
          suggestions.add(element);
          varietyList.add(element);
        });

        print('Number of suggestion: ${suggestions.length}.');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    });
    update();

    return Future.value(suggestions
        .map((e) =>
            {'varietyCode': e.varietyCode!, 'varietyName': e.varietyName!})
        .toList());
  }

  Future callVillageApi(code) async {
    // isVisible.value = true;
    // isLoading.value = true;
    // result.clear();
    var inputBody = {"village_code": code};

    Request request = Request(url: urlvillagecode, body: inputBody);
    request.post().then((response) async {
      print(
          'VILLAGE CODE RESPONSE : ${json.decode(response.statusCode.toString())}');
      if (response.statusCode == 200) {
        // Get.back();
        var data = json.decode(response.body);
        if (data['status']) {
          print(data['data']);
          data['data'].forEach((element) => {
                if (!result.contains(element['village_name']))
                  {result.add(element['village_name'])},
              });
          // villageName.value = data['data']['village_name'];
          // villageCode.value = data['data']['village_code'];
          // node1.nextFocus();
          // node1.nextFocus();
        } else {
          // isVisible.value = false;
          // Get.snackbar("Error", "Incorrect value",
          //     colorText: Colors.white,
          //     backgroundColor: Colors.red,
          //     snackPosition: SnackPosition.TOP);
        }
        // isLoading.value = false;
      } else {
        // isVisible.value = false;
        // Get.back();
        // Get.snackbar("Error", "Incorrect value",
        //     colorText: Colors.white,
        //     backgroundColor: Colors.red,
        //     snackPosition: SnackPosition.TOP);
        throw Exception();
      }
      update();
    }).catchError((onError) {
      print(onError);
    });
    return result;
  }

  Future callGrowerApi(growerCode) async {
    // isLoading.value = true;
    var inputBody = {
      "village_code": villageCodeText.text,
      "grower_code": growerCode
    };

    Request request = Request(url: urlgrowerCode, body: inputBody);
    request.post().then((response) async {
      print(
          'GROWER CODE  RESPONSE : ${json.decode(response.statusCode.toString())}');
      if (response.statusCode == 200) {
        // Get.back();
        var data = json.decode(response.body);
        if (data['status']) {
          // print(data['data']);
          // farmerName.value = data['data']['growerName'];
          // fatherName.value = data['data']['growerFatherName'];
          GrowerListModel list = GrowerListModel.fromJson(data);
          list.data!.forEach((element) => {growerList.add(element)});
          growerList.forEach((element) => {
                if (!growerCodeList.contains(element.growerName))
                  {growerCodeList.add(element.growerName!)}
              });

          // node2.nextFocus();
          // node2.nextFocus();
        } else {
          // Get.snackbar("Error", "Incorrect value",
          //     colorText: Colors.white,
          //     backgroundColor: Colors.red,
          //     snackPosition: SnackPosition.TOP);
        }
        // isLoading.value = false;
      } else {
        // Get.back();
        // Get.snackbar("Error", "Incorrect value",
        //     colorText: Colors.white,
        //     backgroundColor: Colors.red,
        //     snackPosition: SnackPosition.TOP);
        throw Exception();
      }
      update();
    }).catchError((onError) {
      print(onError);
    });
    return growerCodeList;
  }

  void callVarietyApi() async {
    // isLoading.value = true;
    // var inputBody = {"variety": variety};

    Request request = Request(
      url: urlVariety,
    );
    request.post().then((response) async {
      print(
          'VARIETY CODE  RESPONSE : ${json.decode(response.statusCode.toString())}');
      if (response.statusCode == 200) {
        // Get.back();
        var data = json.decode(response.body);
        if (data['status']) {
          VarietyListModel list = VarietyListModel.fromJson(data);
          list.data!.forEach((element) => {varietyList.add(element)});
          varietyList.forEach(
              (element) => {varietyCodeList.add(element.varietyCode!)});
          // print(data['data']);
          // varietyName.value = data['data']['varietyName'];
          // node2.nextFocus();
          // node2.nextFocus();
        } else {
          Get.snackbar("Error", "Incorrect value",
              colorText: Colors.white,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
        }
        // isLoading.value = false;
      } else {
        // Get.back();
        Get.snackbar("Error", "Incorrect value",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP);
        throw Exception();
      }
      update();
    }).catchError((onError) {
      print(onError);
    });
  }

  void calculateCrobDays(DateTime startDate, DateTime endDate) {
    DateTime dt1 = DateTime.parse(endDate.toString());
    DateTime dt2 = DateTime.parse(startDate.toString());

    Duration diff = dt1.difference(dt2);
    print(diff.inDays);
    crobDays.value = diff.inDays.toString();
    update();
  }

  // void calculateProductionYield() {
  //   // DateTime dt1 = DateTime.parse(endDate.toString());
  //   // DateTime dt2 = DateTime.parse(startDate.toString());

  //   // Duration diff = dt1.difference(dt2);
  //   // print(diff.inDays);
  //   productionYield.value = "Demo value";
  //   update();
  // }

  //   Future<void> updateValue(String value) async {
  //   normalListData.value.forEach((element) {
  //     if (element.type.toString() == value.toString()) {
  //       req_type.value = element.type.toString();
  //       subRequestData.value = element.subquery!;
  //       sub_req_type.value = "selectsubrequestType".tr;
  //       sub_req_id.value = '';
  //       commentTextController!.text = ''.toString();
  //     }
  //   });
  //   update();
  // }

}

class VillageSuggestion {
  String? village_code;
  String? village_name;

  VillageSuggestion({
    this.village_code,
    this.village_name,
  });

  factory VillageSuggestion.fromJson(Map<String, dynamic> json) {
    return VillageSuggestion(
      village_code: json['village_code'],
      village_name: json['village_name'],
    );
  }
}
