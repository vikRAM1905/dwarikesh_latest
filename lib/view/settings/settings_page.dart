import 'dart:convert';

import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/service/localization_service.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/local_storgae.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/view/dashboard/home.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:dwarikesh/widgets/bottom_dialog.dart';
import 'package:dwarikesh/widgets/settings/settings_item.dart';
import 'package:dwarikesh/widgets/confirm_dialog.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:package_info/package_info.dart';

class SettingsPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String version = Prefs.getString(VERSION_CODE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: Toolbar(
        title: "settings".tr,
        leftsideIcon: backIcon,
        leftsideBtnPress: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SettingsItem(
                title: "changeLanguage".tr,
                onTap: () {
                  Get.toNamed(ROUTE_LANGUAGE);
                },
              ),
              SettingsItem(
                title: "terms_conditions".tr,
                onTap: () {
                  Get.toNamed(ROUTE_TERMS_AND_CONDITION);
                },
              ),
              SettingsItem(
                title: "about_us".tr,
                onTap: () {
                  Get.toNamed(ROUTE_ABOUTS_US);
                },
              ),
              Divider(
                color: Color(0xffbac0cb).withOpacity(0.21),
                height: 0.5,
                thickness: 0.5,
              ),
              InkWell(
                  onTap: () {
                    LocalStorage localStorage = LocalStorage();
                    showModalBottomSheet<void>(
                      context: _scaffoldKey.currentContext!,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20.0)),
                      ),
                      builder: (BuildContext context) {
                        return BottomDialog(
                          title: 'logout_app'.tr,
                          message: "areYouSureWantToLogout".tr,
                          rightSideIcons: Icons.cancel,
                          rightSideBtn: 'no'.tr,
                          leftSideIcons: Icons.check_circle,
                          leftSideBtn: 'yes'.tr,
                          yesBtn: () async {
                            apiLogout();
                          },
                          noBtn: () => Navigator.pop(context, false),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 17,
                      horizontal: 21,
                    ),
                    child: Text(
                      "logout".tr,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  )),
              Divider(
                color: Color(0xffbac0cb).withOpacity(0.21),
                height: 0.5,
                thickness: 0.5,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'V ${version}',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void apiLogout() async {
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request = Request(url: urlLogout, body: {});
    request.get().then((response) async {
      var data = json.decode(response.body);
      print('LOGOUT STATUS :${response.statusCode}  || ${response.body}');
      Get.back();
      await Prefs.delete();
      await Prefs.setString(SAVE_LANG, 'hi');
      LocalizationService.changeLocale('hi');
      await Prefs.setString(ACCOUNT_CODE, '');
      Get.offAllNamed(ROUTE_SPLASH);
    }).catchError((onError) {
      print(onError);
    });
  }
}
