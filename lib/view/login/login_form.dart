import 'package:dwarikesh/controller/emp_login_controller.dart';
import 'package:dwarikesh/controller/grower_login_controller.dart';
import 'package:dwarikesh/controller/login_controller.dart';
import 'package:dwarikesh/service/localization_service.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

import 'employee_login.dart';
import 'grower_login.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  GrowerLoginController growercontroller = Get.put(GrowerLoginController());
  EmployeeLoginController empcontroller = Get.put(EmployeeLoginController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffFFFFFF).withOpacity(0.1),
                Color(0xffFFFFFF).withOpacity(0.1),
              ],
              stops: [0.0, 0.9],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // angle: 0,
              // scale: undefined,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              logoimage(context, size),
              buildMenuBar(context),
              tabMenuView(context),
              changeLanguage(),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

Widget changeLanguage() {
  GrowerLoginController growerLoginController = Get.find();
  return GetBuilder<LoginController>(
    builder: (value) => Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GetBuilder<GrowerLoginController>(
          builder: (gowerLoginController) => InkWell(
            onTap: () {
              print('On Tap CLICK CHANGE LANGUAGE ENGLISH');
              value.updateLanguage('en');
              growerLoginController.updateLanguage('en');
              value.update();
            },
            child: Text(
              'English',
              style: TextStyle(
                color: value.languageMode == '1' ? primaryColor : kColorGrey,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        GetBuilder<GrowerLoginController>(
          builder: (gowerLoginController) => InkWell(
            onTap: () {
              print('On Tap CLICK CHANGE LANGUAGE HINDI');
              value.updateLanguage('hi');
              growerLoginController.updateLanguage('hi');
              value.update();
            },
            child: Text(
              'हिंदी',
              style: TextStyle(
                color: value.languageMode == "2" ? primaryColor : kColorGrey,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget logoimage(BuildContext context, Size size) {
  return Container(
    color: primaryColor,
    child: Center(
      child: Container(
        padding: EdgeInsets.all(55.r),
        child: Image.asset(
          logoName,
          width: double.infinity,
          height: 75.h,
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
}

Widget buildMenuBar(BuildContext context) {
  return GetBuilder<LoginController>(
      builder: (loginController) => Padding(
            padding: EdgeInsets.only(
              top: 10.r,
              left: 20.r,
              right: 20.r,
            ),
            child: Container(
              height: 46.h,
              child: Align(
                alignment: Alignment.center,
                child: TabBar(
                  controller: loginController.tabcontroller,
                  isScrollable: true,
                  labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  labelColor: primaryColor,
                  unselectedLabelColor: primaryColor,
                  tabs: <Tab>[
                    Tab(text: "grower_login".tr),
                    Tab(
                      text: "employee_login".tr,
                    ),
                  ],
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: primaryColor,
                      width: 4,
                    ),
                    insets: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ),
            ),
          ));
}

Widget tabMenuView(BuildContext context) {
  return GetBuilder<LoginController>(
      builder: (loginController) => Expanded(
            flex: 2,
            child: TabBarView(
              controller: loginController.tabcontroller,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: GrowerLogin(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: EmployeeLogin(),
                ),
              ],
            ),
          ));
}
