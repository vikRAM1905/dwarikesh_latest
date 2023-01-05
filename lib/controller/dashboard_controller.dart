import 'package:dwarikesh/model/dashboard_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/snackbar_message.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
// import 'package:native_updater/native_updater.dart';
import 'package:package_info/package_info.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardController extends GetxController
    with SingleGetTickerProviderMixin {
  var name = ''.obs;
  var phone = ''.obs;
  var menuListData = List<Menu>.empty(growable: true).obs;
  var bannerListData = List<Banners>.empty(growable: true).obs;
  var growerListData = List<Groweractivities>.empty(growable: true).obs;
  var cfaListData = List<Cfarequest>.empty(growable: true).obs;
  var cdoListData = List<Cdorequest>.empty(growable: true).obs;
  var amountReceivedList = List<Incomeresponse>.empty(growable: true).obs;
  final responseCode = ''.obs;
  var buildNumber = ''.obs;
  var updateDialog = false.obs;
  var updateFullDialog = false.obs;
  var updateDialogCloseBtn = false.obs;
  var storeVersion = '0'.obs;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  FirebaseMessaging? messaging;
  TabController? tabController;
  static const double padding = 20;
  static const double avatarRadius = 15;
  String amountReceived = "";

  final String yourVapidKey = "YOUR_VAPID_KEY";
  String? language;
  Geolocator? _geolocator;
  final lat = 0.00.obs;

  final long = 0.00.obs;

  var initialCome = "1".obs;
  var carouselPosition = 0.obs;

  String message = 'empty';
  Permission? permission;
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  @override
  onInit() {
    getCurrentVersion();

    initialCome = "1".obs;
    name.value = '';
    phone.value = '';
    String rollID = Prefs.getString(ROLE_ID);
    if (rollID == '5') {
      villageWiseAPI();
      activityWiseAPI();
    }

    if (initialCome.value == "1") {
      Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    }
    _getFCMToken();
    runtimePermissionCheck();
    apiGetMenuList();
    super.onInit();
  }

  @override
  void dispose() {
    menuListData.clear();
    bannerListData.clear();
    growerListData.clear();
    cfaListData.clear();
    cdoListData.clear();

    super.dispose();
  }

  getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    buildNumber.value = await packageInfo.buildNumber;
  }

  Future<void> runtimePermissionCheck() async {
    final status = await Permission.location.status;
    _permissionStatus = status;
    print('INISE PERMISSION ${_permissionStatus}');
    switch (status) {
      case PermissionStatus.denied:
        requestPermission();
        break;
      case PermissionStatus.granted:
        getcurrentLocation();
        break;
      case PermissionStatus.restricted:
        Get.back();
        break;
      case PermissionStatus.limited:
        Get.back();
        break;
      case PermissionStatus.permanentlyDenied:
        await Geolocator.openAppSettings();
        break;
    }
    if (status.isDenied) {
      requestPermission();
    }
  }

  Future<void> requestPermission() async {
    final status = await Permission.location.request();

    print(status);
    _permissionStatus = status;
    print(_permissionStatus);
  }

  getcurrentLocation() async {
    try {
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      lat.value = position.latitude;
      long.value = position.longitude;

      Prefs.setDouble(LAT, lat.value ?? 0.00);
      Prefs.setDouble(LONG, long.value ?? 0.00);
    } catch (e) {
      print('ERROR LOCATION ====== $e');
    }
  }

  Future<void> _getFCMToken() async {
    await Firebase.initializeApp();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        snakbarNotificationMsg(
            title: message.notification!.title,
            msg: message.notification!.body,
            titleColors: primaryColor,
            messageColor: textColor,
            bgColor: Colors.white);
      }
    });

    try {
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      print('INITIAL MESSAGE DATA ${initialMessage}');
      if (initialMessage?.data['page'] == 'announcement') {
        Get.toNamed(ROUTE_ANNOUNCEMENTS_LIST);
      }
      if (initialMessage?.data['page'] == 'request') {
        Get.toNamed(ROUTE_REQUEST_LIST);
      }

      // Also handle any interaction when the app is in the background via a
      // Stream listener
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print(' ON MESSAGE OPENE APP DATA ${message}');
        if (message.data['page'] == 'announcement') {
          Get.toNamed(ROUTE_ANNOUNCEMENTS_LIST);
        }
        if (initialMessage?.data['page'] == 'request') {
          Get.toNamed(ROUTE_REQUEST_LIST);
        }
        if (initialMessage?.data['page'] == 'web') {
          Get.toNamed(ROUTE_REQUEST_LIST);
        }
      });
    } catch (e) {}
  }

  void apiGetMenuList() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    buildNumber.value = await packageInfo.buildNumber;
    await Prefs.setString(VERSION_CODE, packageInfo.version.toString());
    String userRole = Prefs.getString(ROLE_ID);
    String accountData = await Prefs.getString(ACCOUNT_CODE).toString() ?? '0';

    print('DATA OF USER SELECRTED ACCOUNT IS ${accountData}');
    var deviceData = {
      "lat": Prefs.getDouble(LAT).toString() ?? '',
      "long": Prefs.getDouble(LONG).toString() ?? '',
      "lang": getLanguage(),
      "version": buildNumber.value,
      "accountcode": accountData
    };

    Request request = Request(
        url: urlDashboard, body: {"deviceinfo": json.encode(deviceData)});
    request.post().then((response) async {
      responseCode.value = response.statusCode.toString();
      print(
          'DASH BOARD RESPONSE : ${json.decode(response.statusCode.toString())}');
      if (response.statusCode == 200) {
        DashboardModel listModel =
            DashboardModel.fromJson(json.decode(response.body));
        print('DASH BOARD RESPONSE : ${json.decode(response.body)}');
        if (listModel.status == true) {
          await Prefs.setString(USER_ID, listModel.id.toString());
          name.value = listModel.name!;
          phone.value = listModel.phonenumber!;
          bannerListData.value = listModel.banner!;
          menuListData.value = listModel.menu!;
          amountReceivedList.value = listModel.incomeresponse!;

          if (listModel.groweractivities != null) {
            growerListData.value = listModel.groweractivities!;
            tabController =
                TabController(vsync: this, length: growerListData.value.length);
          }
          if (listModel.cfarequest != null)
            cfaListData.value = listModel.cfarequest!;
          if (listModel.cdorequest != null)
            cdoListData.value = listModel.cdorequest!;
          updateDialog.value = listModel.updatetrigger!;
          updateDialogCloseBtn.value = listModel.cancelbtn!;
          storeVersion.value = listModel.appstore!;
        } else
          responseCode.value = '403';
      }

      if (initialCome.value == "1") {
        initialCome.value = "0";

        Get.back();

        if (updateDialog.value == true) {
          updateFullDialog.value == true;
          openFullSizeUpdateDialog(updateDialogCloseBtn.value);
        }
      }

      update();
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> checkVersion(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    buildNumber.value = await packageInfo.buildNumber;

    Future.delayed(Duration.zero, () async {
      if (int.parse(storeVersion.value) > int.parse(buildNumber.value)) {
        // Get.defaultDialog(title: "Hi", content: Container());
        // InAppUpdate.checkForUpdate().then((info) {
        //   info.updateAvailability == UpdateAvailability.updateAvailable
        //       ? InAppUpdate.performImmediateUpdate()
        //           .catchError((e) => print(e.toString()))
        //       : print(info.packageName);
        // });
        // _launchURL(String url) async {
        if (await canLaunchUrl(Uri.parse(
            "https://play.google.com/store/apps/details?id=com.testwareapp.cms"))) {
          await launchUrl(Uri.parse(
              "https://play.google.com/store/apps/details?id=com.testwareapp.cms"));
        } else {
          throw 'Could not launch "https://play.google.com/store/apps/details?id=com.testwareapp.cms"';
        }
        // }

        // NativeUpdater.displayUpdateAlert(
        //   context,
        //   forceUpdate: true,
        //   appStoreUrl: 'https://play.google.com/store/apps/details?id=com.testwareapp.cms',
        //   // playStoreUrl:
        //   //     'https://play.google.com/store/apps/details?id=com.testwareapp.cms',
        //   iOSDescription: '<Your description>',
        //   iOSUpdateButtonLabel: 'Upgrade',
        //   iOSIgnoreButtonLabel: 'Next Time',
        // );
      } else {
        print("update not available!");
      }
    });
  }

  void villageWiseAPI() async {
    Request request = Request(url: urlVillageWiseCount, body: {});
    request.post().then((response) async {
      var data = json.decode(response.body);
      var rest = data["success"] as bool;
      if (response.statusCode == 200 && rest == true) {
      } else {
        snakbarMsg(
            icon: Icons.dangerous,
            title: response.statusCode,
            msg: '${response.statusCode} Error ',
            colors: Colors.white,
            bgColor: Colors.redAccent);
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  void activityWiseAPI() async {
    Request request = Request(url: urlActivityWiseCount, body: {});
    request.post().then((response) async {
      var data = json.decode(response.body);
      var rest = data["success"] as bool;
      if (response.statusCode == 200 && rest == true) {
      } else {
        snakbarMsg(
            icon: Icons.dangerous,
            title: response.statusCode,
            msg: '${response.statusCode} Error ',
            colors: Colors.white,
            bgColor: Colors.redAccent);
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  void openFullSizeUpdateDialog(bool cancelBtnAvailable) {
    Get.defaultDialog(
      backgroundColor: Colors.white,
      title: "",
      content: getContent(cancelBtnAvailable),
      barrierDismissible: false,
      radius: 10.0,
    );
  }

  Widget getContent(bool cancelBtnAvailable) {
    return Container(
        child: Stack(
      children: <Widget>[
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 45,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(45)),
                    child: Image.asset(uploadapk)),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Update Notification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "App update available. Pls update now",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ElevatedButton(
                        onPressed: () {
                          if (cancelBtnAvailable == true) {
                            updateFullDialog.value == false;
                            Get.back();
                            update();
                          }
                        },
                        child: Text(
                          cancelBtnAvailable == true ? 'Later' : '',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        )),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        onPressed: () {
                          updateFullDialog.value == false;
                          Get.back();
                          checkVersion(Get.context!);
                          update();
                        },
                        child: Text(
                          'Update Now',
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ));
  }
}
