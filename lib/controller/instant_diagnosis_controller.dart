import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/model/instant_diagnosis_model.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class InstantDiagnosisListController extends GetxController {
  File? image;
  bool? isError;
  InstantDiagnosisListModel? resp;
  bool? isRun;

  get getResp => resp;

  @override
  void onInit() {
    clear();
    super.onInit();
  }

  Future getImage(ImageSource source) async {
    try {
      final pickedFile =
          await ImagePicker().getImage(source: source, imageQuality: 50);

      if (pickedFile != null) {
        var rng = new Random();
        final dir = await Directory.systemTemp;
        final targetPath = dir.absolute.path + '/temp${rng.nextInt(10000)}.jpg';
        var result = await FlutterImageCompress.compressAndGetFile(
          pickedFile.path,
          targetPath,
          quality: 10,
        );
        image = File(result!.path);
        update();
        apiGetList(result);
        Future.delayed(Duration(seconds: 2), () {
          print(isRun);
          print(resp);
          Get.back();
          update();
        });
      } else {
        print('No image selected.');
        isError = true;
        update();
      }
    } catch (e) {
      print(' Image Error ${e}.');
      isError = true;
      update();
    }
    update();
  }

  void apiGetList(imageData) async {
    final bytes = imageData.readAsBytesSync();

    String convertImage = base64.encode(bytes);
    var newToken = await generateToken();
    print("new token ====== " + newToken);
    try {
      Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
      if (newToken != null || newToken != "") {
        await http.post(Uri.parse(instant_diagnosis), headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $newToken"
        }, body: {
          "base64Image": "data:image/jpeg;base64,$convertImage"
        }).then((response) {
          if (response.statusCode == 200 || response.statusCode == 201) {
            if (response.body.isNotEmpty) {
              resp = InstantDiagnosisListModel.fromJson(
                  json.decode(response.body));

              isError = false;
              update();
            } else {
              print("response empty.......");
              isError = true;
              update();
            }
          } else {
            print("request failed.......");
            isError = true;
            isRun = true;
            update();
          }
        }).catchError((onError) {
          print(onError);
          isError = true;
          isRun = true;
          update();
        });
      } else {
        print("token invalid... Unauthorizd....");
        isError = true;
        isRun = true;
        update();
      }
    } catch (e) {
      print(e);
      isError = true;
      isRun = true;
      update();
    }
  }

  generateToken() async {
    String? token;
    await http.post(Uri.parse(generate_token), headers: {
      "Accept": "application/json"
    }, body: {
      "email": "admin@dwarikesh.com",
      "password": "Welcome@123"
    }).then((response) {
      print("${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        var res = json.decode(response.body);
        token = res['results']['accessToken'];
      } else {
        token = "";
        isError = true;
        update();
      }
    });
    return token;
  }

  @override
  void onClose() {
    clear();
    super.onClose();
  }

  void clear() {
    isRun = false;
    resp = null;
    isError = false;
    image = null;
    update();
  }
}
