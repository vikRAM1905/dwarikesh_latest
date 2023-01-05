import 'package:dwarikesh/model/activity_list_cfa_model.dart' as list;
import 'package:dwarikesh/model/cfa_village_filter.dart' as filter;
import 'package:dwarikesh/model/cfa_village_filter.dart';
import 'package:dwarikesh/utils/common_method.dart';

import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';

import 'dart:convert';
import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:http/http.dart' as http;

class ActivityListCfaController extends GetxController {
  var reqListData = <list.Data>[].obs;
  var filterListData = <filter.Data>[].obs;
  var searchListData = <list.Data>[].obs;
  var selectedListStates = <list.TempStoreData>[].obs;
  var status = ''.obs;
  final filterAvailable = true.obs;
  list.ActivityListCfaModel? model;

  final tabPosition = 0.obs;
  final responseCode = ''.obs;

  final lat = 0.00.obs;
  final long = 0.00.obs;

  @override
  void onInit() {
    getcurrentLocation();
    update();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    reqListData = <list.Data>[].obs;
    searchListData = <list.Data>[].obs;
    filterListData = <filter.Data>[].obs;

    super.onClose();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.openAppSettings();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  getcurrentLocation() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    _determinePosition().then((value) {
      print('VALUE OF LAT ${value.latitude}   ${value.longitude}');
      lat.value = value.latitude;
      long.value = value.longitude;
      Prefs.setDouble(LAT, value.latitude ?? 0.00);
      Prefs.setDouble(LONG, value.longitude ?? 0.00);
      Get.back();
      apiGetActivityFilterList();
    });
  }

  Future<void> updatetabPosition(int value) async {
    tabPosition.value = value;
    update();
  }

  Future<void> onSearchTextChanged(String text) async {
    searchListData.clear();
    if (text.isEmpty || text == 'all'.tr) {
      filterAvailable.value = true;
      reqListData;
      return;
    }

    reqListData.forEach((value) {
      if (value.growervillage!
          .toLowerCase()
          .trim()
          .contains(text.toLowerCase().trim())) {
        filterAvailable.value = true;
        searchListData.add(value);
      } else {
        filterAvailable.value = false;
        print('NO DATA FOUND');
      }
    });

    update();
  }

  Future<void> addStatusData(var key, var value) async {
    selectedListStates.add(new list.TempStoreData(
        id: key,
        status: value,
        lat: lat.value.toString(),
        long: long.value.toString()));

    update();
  }

  void apiGetActivityFilterList() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request =
        Request(url: urlActivityCFAFilter, body: {"lang": getLanguage()});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          CfaVillageFilterModel listModel =
              CfaVillageFilterModel.fromJson(json.decode(response.body));
          if (listModel.status == true) {
            listModel.data!.insert(0, filter.Data(village: 'all'.tr));
            listModel.data!.length > 0
                ? filterListData.value = listModel.data!
                : Get.back();

            apiGetActivityList();
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

  Future<void> apiGetActivityList() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request =
        Request(url: urlActivityGrowerCFA, body: {"lang": getLanguage()});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          list.ActivityListCfaModel listModel =
              list.ActivityListCfaModel.fromJson(json.decode(response.body));
          if (listModel.status == true && listModel.data!.length > 0) {
            reqListData.value = listModel.data!;
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

  void apiSubmit() async {
    print(json.encode(selectedListStates));
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));

    Request request = Request(url: urlActivityCFAStatus, body: {
      'cfaupdate': json.encode(selectedListStates),
    });
    request.post().then((response) {
      print('Response ${response.body}');

      Get.back();
      update();
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          apiGetActivityList();
          Prefs.setString(SUCCUSS_MSG, 'status_have_been_updated'.tr);
          Get.toNamed(
            ROUTE_REQUEST_SUCCESS,
          );
        } else
          responseCode.value = '403';
      }

      update();
    }).catchError((onError) {
      print(onError);
    });
  }
}
