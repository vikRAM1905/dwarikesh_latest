import 'dart:convert';
import 'dart:io';

import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/model/form2_model.dart' as form2;
import 'package:dwarikesh/model/formAutofill_model.dart' as autoFill;
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as loc;
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../api/url.dart';
import '../model/form1_model.dart';
import '../model/form2_model.dart';
import '../model/formList_model.dart';
import '../utils/constant.dart';
import '../utils/pref_manager.dart';
import 'package:async/src/delegate/stream.dart';
import '../model/form_view_model.dart' as formView;

class Form2Controller extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController villageCodeText = TextEditingController();
  final TextEditingController villageNameText = TextEditingController();
  final TextEditingController growerCodeText = TextEditingController();
  final TextEditingController growerNameText = TextEditingController();
  final TextEditingController growerFatherNameText = TextEditingController();
  final TextEditingController varietyCodeText = TextEditingController();
  final TextEditingController varietyNameText = TextEditingController();
  final TextEditingController cropTypeText = TextEditingController();
  final TextEditingController plotEntityCodeText = TextEditingController();
  final TextEditingController plotEntityCodeNameText = TextEditingController();
  final TextEditingController valueNumberText = TextEditingController();
  final TextEditingController valueDateText = TextEditingController();
  final TextEditingController fileNameText = TextEditingController();
  final TextEditingController plotGpsCoordinatesText = TextEditingController();
  final TextEditingController remarksText = TextEditingController();
  var isLoading = false.obs;
  var valueCharList = List<form2.Data>.empty(growable: true).obs;
  var cropTypeList = List<Croptype>.empty(growable: true).obs;
  var measureList = List<Units>.empty(growable: true).obs;
  var autofillData = List<autoFill.Data>.empty(growable: true).obs;
  // var checkList = List<Data1>.empty(growable: true).obs;
  var interCropList = List<Intercrop>.empty(growable: true).obs;
  var activityList = List<CodeData>.empty(growable: true).obs;
  // var activityCodeList = List<String>.empty(growable: true).obs;
  var activityTypeList = List<ActivityType>.empty(growable: true).obs;
  var codeName = "".obs;
  // DateTime? valueDate;
  var cropType = "Crop Type".obs;
  // var activityCodeSelect = "Activity Code".obs;
  var activityNameSelect = "Activity Code".obs;
  var activityTypeSelect = "Activity Type".obs;
  var villageName = "".obs;
  var villageCode = "".obs;
  var farmerName = "".obs;
  var fatherName = "".obs;
  var varietyName = "".obs;
  var valueString = "Select".obs;
  var unitString = "Select".obs;
  var area = "".obs;
  var dateText = "".obs;
  File? image;
  bool? isError;
  loc.Position? plotGpsCoordinates;
  // var isActivityTypeSelected = false.obs;
  // var farmerName = "".obs;
  // var crobDays = "".obs;
  var fileName = "".obs;
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
  var changeValue = false.obs;
  var id;
  var tabPosition = 0.obs;
  // ScrollController scrollController = ScrollController();
  var formList = List<DemoplotHeaderInfo>.empty(growable: true).obs;
  var formDetail = List<formView.Data>.empty(growable: true).obs;
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

  Future<void> updatetabPosition(int value) async {
    if (value == 1) {
      getFormViewData(id.toString());
    }
    tabPosition.value = value;
    // scrollController.animateTo(0,
    //     duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    id = Get.arguments;
    print(id);
    getAutoFillApi(id.toString());
    callActivityTypeListApi();
    fillDataAuto();
    getCurrentPosition();
    callCropTypeListApi();
    getUnitMeasuresApi();
    print(valueCharList.toString());
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  updateValueString(val) {
    changeValue.value = true;
    valueString.value = val;
    update();
  }

  getActivityCodeName(code) {
    activityList.forEach((element) {
      if (element.code == code) {
        activityNameSelect.value = element.codeName!;
      }
    });
    update();
  }

  updateUnitValue(val) {
    unitString.value = val;
    update();
  }

  updateCropType(val) {
    cropType.value = val;
    update();
  }

  selectActivityCode(val) {
    changeValue.value = true;
    activityNameSelect.value = val;
    plotEntityCodeNameText.text = val;
    update();
  }

  clearList() {
    activityList.clear();
    valueCharList.clear();
    valueString.value = "Select";
    // activityCodeList.clear();
    activityNameSelect.value = "Activity Code";
    update();
  }

  selectActivityType(val) async {
    activityTypeSelect.value = val;
    activityList.clear();
    valueCharList.clear();
    valueString.value = "Select";
    // activityCodeList.clear();
    activityNameSelect.value = "Activity Code";
    // update();
    callEntityCodeApi(val);
    callValueStringListApi(val);
    // isActivityTypeSelected.value = true;
    // plotEntityCodeNameText.text = val;
    update();
  }

  getCurrentPosition() async {
    plotGpsCoordinates = await loc.Geolocator.getCurrentPosition();
    update();
  }

  fillDataAuto() async {
    if (autofillData.isNotEmpty) {
      villageCodeText.text = autofillData[0].villageCode!;
      villageNameText.text = autofillData[0].villageName!;
      growerCodeText.text = autofillData[0].growerCode!;
      growerNameText.text = autofillData[0].growerName!;
      growerFatherNameText.text = autofillData[0].growerFatherName!;
      varietyCodeText.text = autofillData[0].varietyCode!;
      varietyNameText.text = autofillData[0].varietyName!;
      cropTypeText.text = autofillData[0].croptype!;
      update();
    }
  }

  disposeControllers() {
    villageCodeText.clear();
    villageNameText.clear();
    growerCodeText.clear();
    growerNameText.clear();
    growerFatherNameText.clear();
    varietyCodeText.clear();
    varietyNameText.clear();
    plotEntityCodeText.clear();
    plotEntityCodeNameText.clear();
    valueNumberText.clear();
    valueDateText.clear();
    remarksText.clear();
    // image!.delete();
    // valueDate = null;
    plotGpsCoordinatesText.clear();
    valueString.value = "Select";
    unitString.value = "Select";
    cropType.value = "Select Crop Type";
    villageName.value = "";
    villageCode.value = "";
    fatherName.value = "";
    varietyName.value = "";
    area.value = "";
    dateText.value = "";
    farmerName.value = "";
    crobDays.value = "";
    codeName.value = "";
    update();
  }

  void callActivityTypeListApi() async {
    isLoading.value = true;
    activityTypeList.clear();
    Request request = Request(
      url: urlActivityType,
    );
    request.post().then((response) async {
      print(
          'ACTIVITY TYPE  RESPONSE : ${json.decode(response.statusCode.toString())}');
      if (response.statusCode == 200) {
        // Get.back();
        var data = json.decode(response.body);
        if (data['status']) {
          ActivityTypeListModel activityTypeListModel =
              ActivityTypeListModel.fromJson(data);
          activityTypeListModel.activityType!
              .forEach((element) => {activityTypeList.add(element)});
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
      print(activityTypeList[0].type);
      update();
    }).catchError((onError) {
      print(onError);
    });
  }

  void getFormViewData(id) async {
    formDetail.clear();
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
          formView.FormViewModel formViewModel =
              formView.FormViewModel.fromJson(data);
          if (formViewModel.data!.isNotEmpty) {
            formViewModel.data!.forEach((element) {
              formDetail.add(element);
            });
          }
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

  void getAutoFillApi(id) async {
    isLoading.value = true;
    var body = {"id": id};
    Request request = Request(url: urlDemoPlotFetchById, body: body);
    request
        .post()
        .then((response) async {
          print(
              'VALUE STRING  RESPONSE : ${json.decode(response.statusCode.toString())}');
          if (response.statusCode == 200) {
            // Get.back();
            var data = json.decode(response.body);
            if (data['status']) {
              autoFill.AutoFillModel units =
                  autoFill.AutoFillModel.fromJson(data);
              units.data!.forEach((element) => {autofillData.add(element)});
              print(autofillData[0].villageName.toString());
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
        })
        .then((value) => fillDataAuto())
        .catchError((onError) {
          print(onError);
        });
    update();
  }

  void onSubmit(

      // String? villageCode,
      // String? villageName,
      // String? growerCode,
      // String? growerName,
      // String? growerFatherName,
      // String? cropType,
      // String? variety,
      // String? varietyName,
      // String? plotEntityCode,
      // String? plotEntityName,
      // String? valueDate,
      // String? valueNumber,
      // String? valueChar,
      // File? image,
      // String? remarks,
      // String? lat,
      // String? long
      ) async {
    Get.dialog(Progressbar());
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${Prefs.getString(TOKEN)}"
    };
    var uri = Uri.parse(urlDemoPlotStore); // string to uri
    var request =
        new http.MultipartRequest("POST", uri); // create multipart request
    // String fileName = "user_image.jpg";

    var stream = new http.ByteStream(DelegatingStream.typed(image!.openRead()));
    // get file length
    var length = await image!.length(); //imageFile is your image file
    var multipartFileSign = new http.MultipartFile('image', stream, length,
        filename: image!.path); // multipart that takes file
    request.files.add(multipartFileSign);

//add headers
    request.headers.addAll(headers);
    request.fields['id'] = id.toString();
    request.fields['village_code'] = villageCodeText.text;
    request.fields['village_name'] = villageNameText.text;
    request.fields['grower_code'] = growerCodeText.text;
    request.fields['grower_name'] = growerNameText.text;
    request.fields['grower_father_name'] = growerFatherNameText.text;
    request.fields['croptype'] = cropTypeText.text;
    request.fields['variety_code'] = varietyCodeText.text;
    request.fields['variety_name'] = varietyNameText.text;
    request.fields['activity_type'] = activityTypeSelect.value;
    request.fields['plot_entity_code'] = plotEntityCodeText.text;
    request.fields['plot_entity_name'] = plotEntityCodeNameText.text;
    request.fields['value_date'] = valueDateText.text;
    request.fields['value_num'] = valueNumberText.text;
    request.fields['unit'] = unitString.value;
    request.fields['value_char'] =
        valueString.value == "Insect/Pest/Disease" ? "" : valueString.value;
    request.fields['remarks'] = remarksText.text;
    request.fields['lat'] = plotGpsCoordinates!.latitude.toString();
    request.fields['long'] = plotGpsCoordinates!.longitude.toString();
    print(request.fields);

//adding params
    //  var postUri = Uri.parse(urlDemoPlotStore);
    //   var request = new http.MultipartRequest("POST", postUri);
    /*request.fields['village_code'] = villageCode!;
    request.fields['village_name'] = villageName!;
    request.fields['grower_code'] = growerCode!;
    request.fields['grower_name'] = growerName!;
    request.fields['grower_father_name'] = growerFatherName!;
    request.fields['croptype'] = (cropType == "Crop Type" ? null : cropType!)!;
    request.fields['variety_code'] = variety!;
    request.fields['variety_name'] = varietyName!;
    request.fields['plot_entity_code'] = plotEntityCode!;
    request.fields['plot_entity_name'] = plotEntityName!;
    request.fields['value_date'] = valueDate!;
    request.fields['value_num'] = valueNumber!;
    request.fields['unit'] = unitString.value;
    request.fields['value_char'] =
        (valueChar == "Insect/Pest/Disease" ? null : valueChar!)!;
    request.fields['remarks'] = remarks!;
    request.fields['lat'] = lat!;
    request.fields['long'] = long!;*/

    print('REQUEST  : - ${request.fields}  ${request.files}');
    isLoading.value = true;
// send
    var response = await request.send();
    print(response.statusCode);

// listen for response
    response.stream.transform(utf8.decoder).listen((value) async {
      // Get.back();

      if (response.statusCode == 200) {
        var data = json.decode(value);
        if (data['status']) {
          Get.offAllNamed(ROUTE_HOME);
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
              snackPosition: SnackPosition.TOP);
        }
        isLoading.value = false;
      }
      isLoading.value = false;
      // Get.back();
      update();
    });
    /* 
    var postUri = Uri.parse(urlDemoPlotStore);
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['village_code'] = villageCode;
    request.fields['village_name'] = villageName;
    request.fields['grower_code'] = growerCode;
    request.fields['grower_name'] = growerName;
    request.fields['grower_father_name'] = growerFatherName;
    request.fields['croptype'] = cropType;
    request.fields['variety_code'] = variety;
    request.fields['variety_name'] = varietyName;
    request.fields['plot_entity_code'] = plotEntityCode;
    request.fields['plot_entity_name'] = plotEntityName;
    request.fields['value_date'] = valueDate;
    request.fields['value_num'] = valueNumber;
    request.fields['value_char'] = valueChar;
    request.fields['remarks'] = remarks;
    request.fields['lat'] = lat;
    request.fields['long'] = long;
    request.files.add(new http.MultipartFile.fromBytes(
        'image', await File.fromRawPath(image as Uint8List).readAsBytes()));

    request.send().then((response) { */
    // Map<String, dynamic> inputBody = {
    //   "village_code": villageCode,
    //   "village_name": villageName,
    //   "grower_code": growerCode,
    //   "grower_name": growerName,
    //   "grower_father_name": growerFatherName,
    //   "croptype": cropType,
    //   "variety_code": variety,
    //   "variety_name": varietyName,
    //   "plot_entity_code": plotEntityCode,
    //   "plot_entity_name": plotEntityName,
    //   "value_date": valueDate,
    //   "value_num": valueNumber,
    //   "value_char": valueChar,
    //   "image": image,
    //   "remarks": remarks,
    //   "lat": lat,
    //   "long": long
    // };
    // isLoading.value = true;
    // Request request = Request(url: urlDemoPlotStore, body: inputBody);
    // request.post().then((response) async {
    //   print(inputBody);
    //   print(
    //       'SUBMIT  RESPONSE : ${json.decode(response.statusCode.toString())}');
    //   if (response.statusCode == 200) {
    //     // Get.back();
    //     var data = json.decode(response.body);
    //     if (data['status']) {
    //       Get.offAll(() => HomePage());
    //       Get.snackbar("Success", data['msg'],
    //           colorText: Colors.white,
    //           backgroundColor: Colors.green,
    //           snackPosition: SnackPosition.BOTTOM);
    //       // Get.back();
    //     } else {
    //       Get.snackbar("Error", data['msg'],
    //           colorText: Colors.white,
    //           backgroundColor: Colors.blue,
    //           snackPosition: SnackPosition.TOP);
    //     }
    //     isLoading.value = false;
    //   }
    //   isLoading.value = false;
    //   // Get.back();
    //   update();
    // }).catchError((onError) {
    //   print(onError);
    // });
  }

  void getUnitMeasuresApi() async {
    isLoading.value = true;
    Request request = Request(url: urlUnitMeasures);
    request.post().then((response) async {
      print(
          'VALUE STRING  RESPONSE : ${json.decode(response.statusCode.toString())}');
      if (response.statusCode == 200) {
        // Get.back();
        var data = json.decode(response.body);
        if (data['status']) {
          UnitMeasuresModel units = UnitMeasuresModel.fromJson(data);
          units.units!.forEach((element) => {measureList.add(element)});
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

  void callValueStringListApi(type) async {
    valueCharList.clear();
    var inputBody = {"activity_type": type};
    // isLoading.value = true;
    Request request = Request(url: urlValueString, body: inputBody);
    request.post().then((response) async {
      print(
          'VALUE STRING  RESPONSE : ${json.decode(response.statusCode.toString())}');
      if (response.statusCode == 200) {
        // Get.back();
        var data = json.decode(response.body);
        if (data['status']) {
          form2.ValueStringModel valueStringList =
              form2.ValueStringModel.fromJson(data);
          valueStringList.data!
              .forEach((element) => {valueCharList.add(element)});
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
  }

  void callCropTypeListApi() async {
    isLoading.value = true;
    Request request = Request(url: urlCropType);
    request.post().then((response) async {
      print(
          'VALUE STRING  RESPONSE : ${json.decode(response.statusCode.toString())}');
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

  void callVillageApi(code) async {
    // isLoading.value = true;
    var inputBody = {"village_code": code};

    Request request = Request(url: urlvillagecode, body: inputBody);
    request.post().then((response) async {
      print(
          'VILLAGE CODE RESPONSE : ${json.decode(response.statusCode.toString())}');
      if (response.statusCode == 200) {
        Get.back();
        var data = json.decode(response.body);
        if (data['status']) {
          print(data['data']);
          villageName.value = data['data']['village_name'];
          villageCode.value = data['data']['village_code'];
          node1.nextFocus();
          node1.nextFocus();
        } else {
          Get.snackbar("Error", "Incorrect value",
              colorText: Colors.white,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
        }
        // isLoading.value = false;
      } else {
        Get.back();
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

  void callGrowerApi(growerCode) async {
    // isLoading.value = true;
    var inputBody = {
      "village_code": villageCode.value,
      "grower_code": growerCode
    };

    Request request = Request(url: urlgrowerCode, body: inputBody);
    request.post().then((response) async {
      print(
          'GROWER CODE  RESPONSE : ${json.decode(response.statusCode.toString())}');
      if (response.statusCode == 200) {
        Get.back();
        var data = json.decode(response.body);
        if (data['status']) {
          print(data['data']);
          farmerName.value = data['data']['growerName'];
          fatherName.value = data['data']['growerFatherName'];
          node2.nextFocus();
          node2.nextFocus();
        } else {
          Get.snackbar("Error", "Incorrect value",
              colorText: Colors.white,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
        }
        // isLoading.value = false;
      } else {
        Get.back();
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

  void callVarietyApi(variety) async {
    // isLoading.value = true;
    var inputBody = {"variety": variety};

    Request request = Request(url: urlVariety, body: inputBody);
    request.post().then((response) async {
      print(
          'VARIETY CODE  RESPONSE : ${json.decode(response.statusCode.toString())}');
      if (response.statusCode == 200) {
        Get.back();
        var data = json.decode(response.body);
        if (data['status']) {
          print(data['data']);
          varietyName.value = data['data']['varietyName'];
          node2.nextFocus();
          node2.nextFocus();
        } else {
          Get.snackbar("Error", "Incorrect value",
              colorText: Colors.white,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
        }
        // isLoading.value = false;
      } else {
        Get.back();
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

  void callEntityCodeApi(type) async {
    // activityCodeList.clear();
    activityList.clear();
    var inputBody = {"activity_type": type};
    // isLoading.value = true;

    Request request = Request(url: urlEntityCode, body: inputBody);
    request.post().then((response) async {
      print(
          'ENTITY CODE RESPONSE : ${json.decode(response.statusCode.toString())}');
      if (response.statusCode == 200) {
        // Get.back();
        var data = json.decode(response.body);
        if (data['status']) {
          ActivityCodeListModel list = ActivityCodeListModel.fromJson(data);
          list.data!.forEach((element) => {activityList.add(element)});
          // activityList
          //     .forEach((element) => {activityCodeList.add(element.codeName!)});
          // CheckModel checkData = CheckModel.fromJson(data);
          // checkData.data!.forEach((element) => {checkList.add(element)});

          // checkList.forEach((element) {
          //   if (element.code == code) {
          //     codeName.value = element.codeName!;
          //   }
          // });
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
  }

  Future getImage(ImageSource source) async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: source, imageQuality: 50);

      if (pickedFile != null) {
        // var rng = new Random();
        // final dir = await Directory.systemTemp;
        // final targetPath = dir.absolute.path + '/temp${rng.nextInt(10000)}.jpg';
        // var result = await FlutterImageCompress.compressAndGetFile(
        //   pickedFile.path,
        //   targetPath,
        //   quality: 10,
        // );
        image = File(pickedFile.path);
        fileName.value = pickedFile.path.split('/').last;
        print(".........................//////// ${fileName.value}");
        update();
        // apiGetList(result);
        Future.delayed(Duration(seconds: 1), () {
          // print(isRun);
          // print(resp);
        });
      } else {
        print('No image selected.');
        isError = true;
      }
    } catch (e) {
      print(' Image Error ${e}.');
      isError = true;
    }
    update();
  }
}
