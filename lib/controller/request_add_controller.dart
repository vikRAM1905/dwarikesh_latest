import 'dart:math';

import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/controller/reqest_list_controller.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:dwarikesh/widgets/snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dwarikesh/model/request_add_model.dart';

class RequestAddController extends GetxController {
  TextEditingController? commentTextController;
  var menuListData = List<dynamic>.empty(growable: true).obs;
  var normalListData = List<Data>.empty(growable: true).obs;
  var subRequestData = List<Subquery>.empty(growable: true).obs;
  var ratoonListData = List<Ratoon>.empty(growable: true).obs;
  var plotListData = List<Plot>.empty(growable: true).obs;
  final responseCode = ''.obs;
  File? _image;
  final req_type = "selectrequestType".tr.obs;
  final sub_req_type = "selectsubrequestType".tr.obs;
  final sub_req_id = "".obs;
  final plot_type = ''.obs;
  final view_plot_type = ''.obs;
  final selctedPlotID = ''.obs;
  final image_arr = <dynamic>[].obs;

  String get currentPlot => view_plot_type.value;

  @override
  void onInit() {
    commentTextController = TextEditingController();
    getMenuList();
    super.onInit();
  }

  @override
  void onClose() {
    commentTextController?.dispose();
    image_arr.clear();
    menuListData.clear();
    plotListData.clear();
    req_type.value = "";
    sub_req_type.value = "";
    plot_type.value = '';
    view_plot_type.value = '';
    selctedPlotID.value = '';
    update();
    super.onClose();
  }

  Future getImage(ImageSource source) async {
    try {
      var rng = new Random();
      final pickedFile = await ImagePicker().getImage(
          source: source,
          imageQuality: 50, // <- Reduce Image quality
          maxHeight: 500, // <- reduce the image size
          maxWidth: 500);

      if (pickedFile != null) {
        final dir = await Directory.systemTemp;
        final targetPath = dir.absolute.path + '/temp${rng.nextInt(10000)}.jpg';
        var result = await FlutterImageCompress.compressAndGetFile(
          pickedFile.path,
          targetPath,
          quality: 88,
        );
        _image = File(result!.path);
        image_arr.add(_image);
        /* _image = File(pickedFile.path);
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

  Future<void> updateValue(String value) async {
    normalListData.value.forEach((element) {
      if (element.type.toString() == value.toString()) {
        req_type.value = element.type.toString();
        subRequestData.value = element.subquery!;
        sub_req_type.value = "selectsubrequestType".tr;
        sub_req_id.value = '';
        commentTextController!.text = ''.toString();
      }
    });
    update();
  }

  Future<void> updateSubreqestValue(String value) async {
    subRequestData.value.forEach((element) {
      if (element.subquery.toString() == value.toString()) {
        print('${element.subquery.toString()}   ====  ${value.toString()}');
        sub_req_type.value = element.subquery!;
        sub_req_id.value = element.id.toString();
        commentTextController!.text = element.subquery.toString();
      }
    });
    update();
  }

/*  Future<void> updatePlotValue(String value) async {
    */ /* String result = value.substring(0, value.indexOf('('));
    print(result);
    final newString = result.replaceAll('Plot - ', "");
    plot_type.value = value;
    view_plot_type.value = newString;
*/ /*

    plotListData.forEach((element) {
      var modelData = '${element.plotid.toString()}';
      if (modelData
          .toLowerCase()
          .trim()
          .contains(value.toString().toLowerCase().trim())) {
        view_plot_type.value = '${"plot".tr} - ' +
            element.plotid.toString() +
            ' (' +
            element.caneArea +
            LAND_CALCUALTED_TYPE.tr +
            ')' +
            element.cropType;
        selctedPlotID.value = element.plotid.toString();
        print('VALUE OF PLOT DATA ${view_plot_type.value}');

        if (element.ratoon_status == '0') {
          menuListData.value = ratoonListData.value;
        } else {
          menuListData.value = normalListData.value;
        }

        print('API DATA OF MENU LIST ${menuListData.length}');
      }

    });

    update();
  }*/

  Future<void> validation() async {
    if (req_type.isNotEmpty.toString().trim() != '' &&
        sub_req_type.value != "selectrequestType".tr) {
      if (sub_req_type.isNotEmpty.toString().trim() != '' &&
          sub_req_type.value !=
              "selectsubrequestType"
                  .tr) if (commentTextController!.text.isNotEmpty &&
          commentTextController!.text != '')
        apiReqSubmit();
      else
        snakbarMsg(
            icon: Icons.dangerous,
            title: 'comment'.tr + ' *',
            msg: 'Explain your Query in comment box',
            colors: Colors.white,
            bgColor: Colors.redAccent);
      else
        snakbarMsg(
            icon: Icons.dangerous,
            title: "subrequestType".tr + ' *',
            msg: 'Select the request in given field',
            colors: Colors.white,
            bgColor: Colors.redAccent);
    } else
      snakbarMsg(
          icon: Icons.dangerous,
          title: "requestType".tr + ' *',
          msg: 'Select the request in given field',
          colors: Colors.white,
          bgColor: Colors.redAccent);
  }

  void getMenuList() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request =
        Request(url: urlRequestType, body: {"lang": getLanguage()});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        RequestAddModel listModel =
            RequestAddModel.fromJson(json.decode(response.body));
        print('ADD REQ API :${json.decode(response.body)}');
        if (listModel.status == true) {
          listModel.data!
              .forEach((element) => {normalListData.value.add(element)});
          listModel.ratoon!
              .forEach((element) => {ratoonListData.value.add(element)});
          plotListData.value = listModel.plot!;
          menuListData.value = normalListData.value;
        } else
          responseCode.value = '403';
      }

      Get.back();
      update();
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> apiReqSubmit() async {
    Get.dialog(Progressbar());
    update();
    String token = await Prefs.getString(TOKEN);
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    }; // ignore this headers if there is no authentication

    int imageCount = 1;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy_MM_dd_kk_mm').format(now);

    var uri = Uri.parse(urlAddRequest); // string to uri
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
            'fileName[]', stream, length,
            filename: fileName); // multipart that takes file
        request.files.add(multipartFileSign);
      }
    } else {
      request.fields['fileName[]'] = '';
    }

//add headers
    request.headers.addAll(headers);

//adding params
    request.fields['requesttype'] = req_type.value;
    request.fields['reqtypeid'] = sub_req_id.value;
    request.fields['description'] = commentTextController!.text;
    request.fields['lang'] = getLanguage();
// send
    var response = await request.send();
    print(response.statusCode);

// listen for response
    response.stream.transform(utf8.decoder).listen((value) async {
      print(value);

      Get.back();
      if (response.statusCode == 200) {
        RequestListController listController = Get.put(RequestListController());
        listController.apiGetUserList();
        Prefs.setString(
            SUCCUSS_MSG, 'your_request_has_been_submitted_successfully'.tr);
        Get.offNamed(ROUTE_REQUEST_SUCCESS);
      } else
        snakbarMsg(
            icon: Icons.dangerous,
            title: responseCode.toString(),
            msg: 'ERROR',
            colors: Colors.white,
            bgColor: Colors.redAccent);
    });
  }
}
