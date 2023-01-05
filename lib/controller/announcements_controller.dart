import 'package:dwarikesh/model/announcements_model.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';

class AnnouncementsController extends GetxController {
  var listData = <Data>[].obs;
  final responseCode = ''.obs;

  @override
  void onInit() {
    apiGetList();
    super.onInit();
  }

  @override
  void onClose() {
    listData = <Data>[].obs;
    super.onClose();
  }

  void apiGetList() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request =
        Request(url: urlAnnouncement, body: {"lang": getLanguage()});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          AnnouncementsModel listModel =
              AnnouncementsModel.fromJson(json.decode(response.body));
          if (listModel.status == true) {
            listData.value = listModel.data!;
          } else
            responseCode.value = '403';
        }
      }

      Get.back();
      update();
    }).catchError((onError) {
      print(onError);
    });
  }
}
