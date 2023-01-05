import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:async';

import 'package:dwarikesh/model/activity_list_grower_model.dart';
import 'package:dwarikesh/model/gower_plot_model.dart' as plotmodel;

import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:async/async.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:flutter/material.dart';

class ActivityListGrowerController extends GetxController {
  List<Data> activityListData = new List<Data>.empty(growable: true).obs;
  final ActivityListGrowerModel model = ActivityListGrowerModel();
  var menuListData = List<plotmodel.Data>.empty(growable: true).obs;
  // var plotList = List<Plotinfo>.empty(growable: true).obs;
  var totalRewardPoint = '0'.obs;
  var selectedPlot = "select plot".obs;
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
  var filterValue = 'All'.obs;
  final image_arr = <dynamic>[].obs;
  File? _image;
  var selectedImagepath = ''.obs;
  var selectedImageSize = ''.obs;
  // var selectedPlotId = ''.obs;

  void onInit() {
    postPlotInsert();
    scrollPosition();
    apiGetPlotList();
    fetchApiData();

    super.onInit();
  }

  void postPlotInsert() {
    isLoading.value = true;
    Request request = Request(url: urlGrowerPlotInsert);
    request.post().then((response) async {
      print(
          'Plot Insert RESPONSE : ${json.decode(response.statusCode.toString())}');
      if (response.statusCode == 200) {
        // PlotListModel listModel =
        //     PlotListModel.fromJson(json.decode(response.body));
        print('FORM LIST RESPONSE : ${json.decode(response.body)}');
        // if (listModel.status == true) {
        //   listModel.demoplots!.forEach((element) {
        //     plotList.add(element);
        //   });
        //   listModel.demoplotHeaderInfo!.forEach((element) {
        //     formList.add(element);
        //   });
        // }
      }
      isLoading.value = false;
      // Get.back();
      update();
    }).catchError((onError) {
      print(onError);
    });
  }

  // clearData() {
  //   selectedPlot.value = "select plot";
  //   selectedPlotId.value = '';
  // }

  apiGetPlotList() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));

    Request request = Request(url: urlPlotList, body: {"lang": getLanguage()});
    request.post().then((response) {
      if (response.statusCode == 200) {
        print('RESPONSE DATA ${response}');
        plotmodel.UserPlotList modelValue =
            plotmodel.UserPlotList.fromJson(json.decode(response.body));
        modelValue.data!
            .insert(0, plotmodel.Data(plotName: "all".tr, plotId: 0));
        if (modelValue.status == true) {
          menuListData.value = modelValue.data!;
        } else {
          responseCode.value = '403';
        }
      }

      Get.back();
      update();
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> fetchApiData({int pageNumber = 1, int tabPosition = 0}) async {
    Map<String, dynamic> input = {
      "lang": getLanguage(),
      "tabid": tabPosition.toString(),
      "page": pageNumber.toString(),
      "limit": 10.toString(),
      // "plots": filterValue.value
    };
    print("fetchSpaLists ${input}");

    if (activityListData.length == 0) {
      isLoading.value = true;
      activityListData.clear();
      // plotList.clear();
    } else if (pageNumber == 1) {
      activityListData.clear();
      // plotList.clear();
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
      Request request = Request(url: urlActivityGrowerListNew, body: input);

      request.post().then((response) {
        if (response.statusCode == 200) {
          ActivityListGrowerModel listModel =
              ActivityListGrowerModel.fromJson(json.decode(response.body));
          if (listModel.status == true) {
            totalRewardPoint.value = listModel.totalRewardPoints.toString();
            totalRecords.value = listModel.totalData!;

            // listModel.data.forEach((value) => activityListData.addAll(listModel.data));
            print('LENGHT OF ARRAY ${listModel.data!.length}');
            // listModel.data!
            //     .forEach((value) => value.plotinfo!.forEach((element) {
            //           plotList.add(element);
            //         }));

            // print("Plot Name : ${plotList.length}");

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

  // updateSelectedPlot(value) {
  //   selectedPlot.value = value;
  //   plotList.forEach((element) {
  //     if (element.canearea == value) {
  //       selectedPlotId.value = element.plotid.toString();
  //     }

  //     print("selected plot id : ${selectedPlotId.value}");
  //   });
  //   update();
  // }

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

  Future<void> onSearchTextChanged(String text) async {
    print('  SELECTED DATA ${text}');
    activityListData.clear();
    if (text == '0') text = 'All';

    filterValue.value = text;
    pageNumber.value = 1;
    fetchApiData(pageNumber: pageNumber.value, tabPosition: tabPosition.value);
    scrollController.animateTo(0,
        duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
    update();
  }

  Future<void> apiTaskCompletedSubmit(String activityID, String plotID,
      String cfaID, String caneAreaHr, String village) async {
    Get.dialog(Progressbar());
    update();

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${Prefs.getString(TOKEN)}"
    }; // ignore this headers if there is no authentication
    int imageCount = 1;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy_MM_dd_kk_mm').format(now);

    var uri = Uri.parse(urlActivityGrowerCompletedNew); // string to uri
    var request =
        new http.MultipartRequest("POST", uri); // create multipart request
    if (image_arr.length > 0) {
      for (var file in image_arr) {
        String fileName = "${formattedDate}_user_image${imageCount}.jpg";
        imageCount++;

        var stream =
            new http.ByteStream(DelegatingStream.typed(file.openRead()));
        // get file length
        var length = await file.length(); //imageFile is your image file
        var multipartFileSign = new http.MultipartFile(
            'groweractivityimage[]', stream, length,
            filename: fileName); // multipart that takes file
        request.files.add(multipartFileSign);
      }
    } else {
      request.fields['groweractivityimage[]'] = '';
    }

//add headers
    request.headers.addAll(headers);

//adding params
    request.fields['activityid'] = activityID;
    request.fields['plotid'] = plotID;
    request.fields['cfaid'] = cfaID;
    request.fields['caneareaha'] = caneAreaHr;
    request.fields['village'] = village;
    request.fields['lang'] = getLanguage();

    print('REQUEST  : - ${request.fields}  ${request.files}');
// send
    var response = await request.send();
    print(response.statusCode);

// listen for response
    response.stream.transform(utf8.decoder).listen((value) async {
      print(value);

      Get.back();
      if (response.statusCode == 200) {
        ResponseModel data = ResponseModel.fromJson(json.decode(value));
        image_arr.clear();
        await fetchApiData();
        Prefs.setString(SUCCUSS_MSG, data.message!);
        // clearData();
        Get.offNamed(ROUTE_REQUEST_SUCCESS);
      } else
        print('ERROR ON API DATA :${response.statusCode}');
    });
  }

  void getImage(ImageSource source) async {
    try {
      var rng = new Random();
      final pickedFile =
          await ImagePicker().getImage(source: source, imageQuality: 100);

      if (pickedFile != null) {
        print(
            'COMPRESS BEFORE SIZE ${pickedFile.path}   SIZE ${(File(pickedFile.path).lengthSync() / 1024 / 1024).toStringAsFixed(2) + " Mb"}');
        final dir = await Directory.systemTemp;
        final targetPath = dir.absolute.path + '/temp${rng.nextInt(10000)}.jpg';
        var result = await FlutterImageCompress.compressAndGetFile(
          pickedFile.path,
          targetPath,
          quality: 88,
        );
        print(
            'COMPRESS AFTER SIZE ${result!.path}   SIZE ${((File(result.path).lengthSync() / 1024 / 1024).toStringAsFixed(2) + " Mb")}');
        _image = File(result.path);
        image_arr.add(_image);
        /* _image = File(pickedFile.path);
        image_arr.add(_image);*/

        /*     _image = File(pickedFile.path);
        image_arr.add(_image);*/

      } else {
        print('No image selected.');
      }
    } catch (e) {
      print(' Image Error ${e}.');
    }
    update();
  }

  void removeImage(int index) {
    image_arr.removeAt(index);
    update();
  }

  @override
  void dispose() {
    scrollController.dispose();
    image_arr.clear();
    super.dispose();
  }
}

class ResponseModel {
  bool? status;
  String? message;

  ResponseModel({this.status, this.message});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
