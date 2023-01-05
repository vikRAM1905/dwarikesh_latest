import 'dart:async';

import 'package:dwarikesh/model/weather_model.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'dart:convert';
import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';

class WeatherController extends GetxController
    with SingleGetTickerProviderMixin {
  var resListData = List<Data>.empty(growable: true).obs;
  final responseCode = ''.obs;
  final currentWeather = ''.obs;
  final currentDetail = ''.obs;
  final weatherType = ''.obs;
  final max = ''.obs;
  final min = ''.obs;
  final sunrise = ''.obs;
  final sunset = ''.obs;
  final humidity = ''.obs;
  final windSpeed = ''.obs;
  final windUnit = ''.obs;
  final city = ''.obs;
  final icon = ''.obs;

  final lat = 0.00.obs;
  final long = 0.00.obs;
  TabController? tabController;

  @override
  void onInit() {
    //  _determinePosition();
    getcurrentLocation();
    super.onInit();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    print('INIT VALUE STATE CREATED====================');
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
      await Geolocator.openAppSettings();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return Geolocator.getCurrentPosition();
/* if(permission == LocationPermission.whileInUse){
      permission = await Geolocator.requestPermission();
     await getLocation().then((position) {
        print(position.latitude.toString() + ', ' + position.longitude.toString());


        Prefs.setDouble(LAT,position.latitude.toString()?? 0.00);
        Prefs.setDouble(LONG, position.longitude.toString()??0.00);
      });


      getWeatherApi();
    }*/
    update();
  }

  getcurrentLocation() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    await _determinePosition().then((value) {
      print('VALUE OF LAT ${value.latitude}   ${value.longitude}');
      Prefs.setDouble(LAT, value.latitude ?? 0.00);
      Prefs.setDouble(LONG, value.longitude ?? 0.00);
      getWeatherApi();
    });
    Get.back();
    update();
  }

  Future<Position> getLocation() async {
    var currentLocation;
    try {
      currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  void getWeatherApi() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request = Request(url: urlWeatherList, body: {
      "lat": Prefs.getDouble(LAT).toString(),
      "long": Prefs.getDouble(LONG).toString()
    });
    request.post().then((response) {
      print('Response ${response.body}');

      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          WeatherModel listModel =
              WeatherModel.fromJson(json.decode(response.body));
          if (listModel.status == true) {
            currentWeather.value = listModel.temperature.toString();
            currentDetail.value = listModel.main.toString();
            weatherType.value = listModel.temptype!;
            max.value = listModel.maxtemp.toString();
            min.value = listModel.mintemp.toString();
            sunrise.value = listModel.sunrise.toString();
            sunset.value = listModel.sunset.toString();
            humidity.value = listModel.huminity.toString();
            windSpeed.value = listModel.windspeed.toString();
            windUnit.value = listModel.windunit.toString();
            city.value = listModel.city!;
            icon.value = listModel.icondata!;
            resListData.value = listModel.data!;
            tabController =
                TabController(vsync: this, length: resListData.value.length);
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
