import 'dart:convert';

import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/model/harvesting_model.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:dwarikesh/widgets/snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HarvestingController extends GetxController {
  TextEditingController? areaTextController;
  var resListData = List<Completed>.empty(growable: true).obs;
  var plotListData = List<Plotdetails>.empty(growable: true).obs;
  var harvestingTypeData = List<Harvestingtype>.empty(growable: true).obs;
  final responseCode = ''.obs;
  final tabPosition = 0.obs;
  var radioButtonItem = 'yes'.tr.obs;
  var enableId = 0.obs;
  var view_plot_type = 'select_plot'.tr.obs;
  final selctedPlotName = ''.obs;
  final selctedPlotID = ''.obs;
  final selctedVillageID = ''.obs;
  final selctedVillage = ''.obs;
  final selctedSeason = ''.obs;
  final selctedSeasonShow = ''.obs;
  final selctedPlantType = ''.obs;
  final selctedPlantTypeShow = ''.obs;
  final selctedstartDate = ''.obs;
  final selctedPartialYieldQuantity = ''.obs;
  final selctedcanearea = ''.obs;
  final selctedcfaid = ''.obs;
  final selctedharvestingType = ''.obs;
  final selctedharvestingId = ''.obs;
  final ratoonAvailable = false.obs;
  final image_arr = <dynamic>[].obs;

  String get currentPlot => view_plot_type.value;

  @override
  void onInit() {
    areaTextController = TextEditingController();
    apiGetList();
    super.onInit();
  }

  @override
  void onClose() {
    areaTextController!.clear();
    areaTextController!.dispose();
    super.onClose();
  }

  Future<void> updatePlotValue(String value) async {
    plotListData.forEach((element) {
      var modelData = '${element.plotName.toString()}';
      if (modelData
          .toLowerCase()
          .trim()
          .contains(value.toString().toLowerCase().trim())) {
        view_plot_type.value = element.plotName.toString();

        selctedPlotID.value = element.plotId.toString();
        selctedPlotName.value = element.plotName.toString();
        selctedVillage.value = element.villagename.toString();
        selctedVillageID.value = element.villageid.toString();
        selctedSeason.value = element.season.toString();
        selctedSeasonShow.value = element.seasonshow.toString();
        selctedPlantType.value = element.croptype.toString();
        selctedPlantTypeShow.value = element.croptypeshow.toString();
        selctedstartDate.value = element.plantationStartDate.toString();
        selctedcanearea.value = element.canearea.toString();
        selctedcfaid.value = element.cfaid.toString();
        selctedPartialYieldQuantity.value =
            element.selectedPartialYieldQuantity.toString();

        harvestingTypeData.value = element.harvestingtype!;
        harvestingTypeData.forEach((element) => element.TypeclickPos = false);
        selctedharvestingType.value = '';
        selctedharvestingId.value = '';

        update();
      }
    });

    update();
  }

  Future<void> apiGetList() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));

    Request request =
        Request(url: urlHarvestingList, body: {"lang": getLanguage()});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        HarverstingModel listModel =
            HarverstingModel.fromJson(json.decode(response.body));

        if (listModel.status == true) {
          plotListData.value = listModel.plotdetails!;
          resListData.value = listModel.completed!;
        }
        print(
            'VALUE OF PLOT ${plotListData.value.length}   VALUE OF DATA ${resListData.value}');
      }
      Get.back();
      update();
    }).catchError((onError) {
      print(onError);
    });
  }

  void validation() async {
    if (currentPlot != 'select_plot'.tr) {
      if (selctedharvestingType.value != '' &&
          selctedharvestingId.value != '') if (areaTextController!
              .text !=
          '') if (enableId == 0 && ratoonAvailable.value == false) {
        calculationApi();
      } else if ((enableId == 1 || enableId == 2) &&
          ratoonAvailable.value == true) {
        calculationApi();
      } else
        snakbarMsg(
            icon: Icons.dangerous,
            title: 'Ratoon !',
            msg: 'Select Ratoon value ',
            colors: Colors.white,
            bgColor: Colors.redAccent);
      else
        snakbarMsg(
            icon: Icons.dangerous,
            title: 'Yield Quantity !',
            msg: 'Enter the Yield Quantity',
            colors: Colors.white,
            bgColor: Colors.redAccent);
      else
        snakbarMsg(
            icon: Icons.dangerous,
            title: 'Harvesting Type !',
            msg: 'Select Harvesting type value ',
            colors: Colors.white,
            bgColor: Colors.redAccent);
    } else
      snakbarMsg(
          icon: Icons.dangerous,
          title: 'Plot !',
          msg: 'Enter correct Plot value in the box',
          colors: Colors.white,
          bgColor: Colors.redAccent);
  }

  void calculationApi() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));

    Request request = Request(url: urlHarvestingCalculated, body: {
      "lang": getLanguage(),
      "plotid": selctedPlotID.value,
      "canearea": selctedcanearea.value,
      "croptype": selctedPlantType.value,
      "season": selctedSeason.value,
      "cfaid": selctedcfaid.value,
      "villageid": selctedVillageID.value,
      "plantationstartdate": selctedstartDate.value,
      "harvesttype": selctedharvestingId.value,
      "yieldquantity": areaTextController!.text.toString(),
      "status": enableId.value.toString()
    });

    request.post().then((response) async {
      Get.back();
      if (response.statusCode == 200) {
        apiGetList();
        view_plot_type = 'select_plot'.tr.obs;
        selctedharvestingType.value = '';
        selctedharvestingId.value = '';
        selctedPlotID.value = '';
        selctedcanearea.value = '';
        selctedPlantType.value = '';
        selctedSeason.value = '';
        selctedcfaid.value = '';
        selctedVillageID.value = '';
        selctedstartDate.value = '';
        areaTextController!.text = '';
        enableId.value = 0;
        ratoonAvailable.value = false;

        Prefs.setString(SUCCUSS_MSG, '${'entry_added'.tr}');
        Get.toNamed(ROUTE_REQUEST_SUCCESS);
      } else {
        responseCode.value = response.statusCode.toString();
      }

      update();
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> updatetabPosition(int value) async {
    tabPosition.value = value;
    update();
  }
}
