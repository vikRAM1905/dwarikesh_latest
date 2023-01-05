import 'package:dwarikesh/binding/dashboard_binding.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/view/dashboard/home.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:dwarikesh/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationCheck extends StatefulWidget {
  @override
  _LocationCheckState createState() => _LocationCheckState();
}

class _LocationCheckState extends State<LocationCheck> {
  Map<String, dynamic> _deviceData = <String, dynamic>{}.obs;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: null,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 250,
                width: 250,
                child: SvgPicture.asset('assets/svg_images/map.svg'),
              ),
              Container(
                  child: Text(
                'turn_on_location'.tr,
                style: TextStyle(fontSize: 18),
              )),
              SizedBox(
                height: 20,
              ),
              Container(
                  child: Text(
                'location_detail'.tr,
                style: TextStyle(fontSize: 18),
              )),
              SizedBox(
                height: 100,
              ),
              RoundedButton(
                text: "back".tr,
                color: primaryColor,
                textColor: Colors.white,
                press: () {
                  getcurrentLocation();
                },
              ),
            ],
          ),
        ),
      ),
    );
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
    _determinePosition().then((value) {
      print('VALUE OF LAT ${value.latitude}   ${value.longitude}');
      Prefs.setDouble(LAT, value.latitude ?? 0.00);
      Prefs.setDouble(LONG, value.longitude ?? 0.00);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    });
  }
}
