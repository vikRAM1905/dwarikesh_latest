import 'dart:math';

import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/controller/reqest_list_controller.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:dwarikesh/widgets/snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dashboard_controller.dart';

class RequestDetailController extends GetxController {
  TextEditingController? commentTextController;
  File? _image;
  final image_arr = <dynamic>[].obs;
  final visitCheck = false.obs;

  final _controller = Get.put(RequestListController());

  @override
  void onInit() {
    commentTextController = TextEditingController();

    super.onInit();
  }

  Future<void> updateCurrentVisit(var value) async {
    visitCheck.value = value;
    update();
  }

  @override
  void onClose() {
    commentTextController!.clear();
    commentTextController!.dispose();
    update();
    super.onClose();
  }

  Future getImage(ImageSource source) async {
    try {
      var rng = new Random();
      final pickedFile =
          await ImagePicker().getImage(source: source, imageQuality: 85);

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

  Future<void> feedbackValidation(String requestID, String status,
      String responseID, String visitStatus) async {
    String userRoll = Prefs.getString(ROLE_ID);
    String visit = '';

    if (visitStatus == 'true')
      visit = '1';
    else if (visitStatus == 'false')
      visit = '0';
    else
      visit = '';

    print(
        'feedbackValidation  ${requestID} | staus  ${status} | responseID  ${responseID}  visit ${visitStatus}');

    if (userRoll != GROWER) {
      if (commentTextController!.text.isNotEmpty)
        apiReqSubmit(requestID, status, responseID, visit);
      //  apiFeedbackSubmit(requestID, status, responseID);

      else
        snakbarMsg(
            icon: Icons.dangerous,
            title: 'comment'.tr + ' *',
            msg: 'Explain your Answer in comment box',
            colors: Colors.white,
            bgColor: Colors.redAccent);
    } else
      apiReqSubmit(requestID, status, responseID, visit);
    // apiFeedbackSubmit(requestID, status, responseID);
  }

  Future<void> apiReqSubmit(
      String requestID, String status, String responseID, String visit) async {
    print(
        'PARAMS IN  REQ ${requestID} | staus  ${status} | responseID  ${responseID}  visit ${visit}   |  IMAGE ${image_arr.length}');
    Get.dialog(Progressbar());
    update();
    String token = await Prefs.getString(TOKEN);
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    }; // ignore this headers if there is no authentication
    String userRoll = await Prefs.getString(ROLE_ID);
    int imageCount = 1;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy_MM_dd_kk_mm').format(now);

    var uri = Uri.parse(urlRequestRely); // string to uri
    var request =
        new http.MultipartRequest("POST", uri); // create multipart request
    if (image_arr.length > 0) {
      for (var file in image_arr) {
        String fileName = "${formattedDate}_user_image${imageCount}.jpg";
        print('${imageCount} - IMAGE COUNT  ||  FILE NAME  ----- ${fileName}');
        imageCount++;
        var stream =
            new http.ByteStream(DelegatingStream.typed(file.openRead()));
        // get file length
        var length = await file.length(); //imageFile is your image file
        print('FILE LENGTH == ${length}');
        var multipartFileSign = new http.MultipartFile(
            'image[]', stream, length,
            filename: fileName); // multipart that takes file
        request.files.add(multipartFileSign);
      }
    } else {
      request.fields['image[]'] = '';
    }

//add headers
    request.headers.addAll(headers);

//adding params
    request.fields['reqid'] = requestID;
    request.fields['status'] = status;
    request.fields['resid'] = responseID;
    request.fields['visittype'] = visit;
    request.fields['commant'] = commentTextController!.text;

    print('IAMGE DATAS ${request}');

    // send
    var response = await request.send();
    print(response.statusCode);
    Get.back();
    if (response.statusCode == 200) {
      _controller.apiGetUserList();
      Prefs.setString(SUCCUSS_MSG, '${"sent_successfully".tr}');
      Get.offNamed(ROUTE_REQUEST_SUCCESS);
    }

// listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
}
