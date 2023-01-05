import 'dart:async';
import 'dart:io';

import 'package:dwarikesh/components/dashboard_card.dart';
import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/components/photos_widget.dart';
import 'package:dwarikesh/components/user_card.dart';
import 'package:dwarikesh/controller/dashboard_controller.dart';
import 'package:dwarikesh/model/dashboard_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/view/diagnosis/instant_diagnosis.dart';
import 'package:dwarikesh/view/form/form_2.dart';
import 'package:dwarikesh/view/harvesting/harvesting_list.dart';
import 'package:dwarikesh/widgets/bottom_dialog.dart';
import 'package:dwarikesh/widgets/button.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../finance/finance_list.dart';
import '../form/form_1.dart';
import '../form/form_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double? screenWidth, screenHeight;
  String? userRole;
  final DashboardController dashcontroller = Get.put(DashboardController());
  @override
  void initState() {
    super.initState();
    getFirebaseToken();
    userRole = Prefs.getString(ROLE_ID);
  }

  @override
  void dispose() {
    setState(() {});

    super.dispose();
  }

  Future getFirebaseToken() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    // await Prefs.setString(FCM_TOKEN, fcmToken!);
    print("fcm token ================== $fcmToken");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: GetBuilder<DashboardController>(
            init: dashcontroller,
            builder: (dashboardController) => Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size(double.infinity, 120),
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/images/topbar-img.png",
                          fit: BoxFit.cover,
                          // height: 160,
                          width: double.infinity,
                        ),
                        Positioned(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // horizontalTitleGap: 10,
                                  // minLeadingWidth: 5,
                                  // contentPadding: EdgeInsets.all(5),
                                  // backgroundColor: Colors.transparent,
                                  // elevation: 0,
                                  // centerTitle: true,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            Get.toNamed(ROUTE_SETTING);
                                          });
                                        },
                                        icon: Icon(settingIcons,
                                            color: Colors.white, size: 24)),
                                    Spacer(),
                                    Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: Column(
                                        children: [
                                          Text(dashboardController.name.value,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(height: 5),
                                          Text(dashboardController.phone.value,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    if (userRole == GROWER)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: InkWell(
                                            onTap: () {
                                              Get.toNamed(ROUTE_ACCOUNT_LIST);
                                            },
                                            child: Icon(repeatIcon,
                                                color: Colors.white, size: 24)),
                                      ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: InkWell(
                                          onTap: () {
                                            Get.toNamed(ROUTE_FAQ);
                                          },
                                          child: Icon(questionIcon,
                                              color: Colors.white, size: 24)),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /* Toolbar(
                          title: dashboardController.name.value,
                          leftsideIcon: settingIcons,
                          leftsideBtnPress: () {
                            setState(() {
                              Get.toNamed(ROUTE_SETTING);
                            });
                          },
                          rightsideBtnAvil: 1,
                          rightsideIcon: questionIcon,
                          rightsideBtnPress: () {
                            Get.toNamed(ROUTE_FAQ);
                          },
                          rightsideBtnAvil1: userRole == GROWER ? 1 : 0,
                          rightsideIcon1: repeatIcon,
                          rightsideBtnPress1: () {
                            Get.toNamed(ROUTE_ACCOUNT_LIST);
                          },
                        ), */
                  body: GetBuilder<DashboardController>(
                      init: dashcontroller,
                      builder: (dashboardController) => dashboardMenu(context)),
                )),
      ),
    );
  }

  Widget dashboardMenu(BuildContext context) {
    return GetBuilder<DashboardController>(
        builder: (dashboardController) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Stack(
                  //   children: [
                  //     Container(
                  //       color: primaryColor,
                  //       width: double.infinity,
                  //       padding: EdgeInsets.only(bottom: 48.h),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           Container(
                  //             width: 100.w,
                  //             height: 1.h,
                  //             color: white,
                  //           ),
                  //           SizedBox(
                  //             height: 15.0,
                  //           ),
                  //           Center(
                  //             child: Text(
                  //               dashboardController.phone.value,
                  //               style: TextStyle(
                  //                 color: white,
                  //                 fontSize: 14.0,
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Container(
                    margin: EdgeInsets.only(top: 10.h),
                    child: Carousel(context),
                  ),
                  dashboardController.updateDialog.value == true
                      ? updateDialog(context)
                      : SizedBox(),
                  if (userRole == GROWER)
                    dashboardController.amountReceivedList.isEmpty
                        ? SizedBox()
                        : Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFE6E6E6)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 61,
                              width: MediaQuery.of(context).size.width / 1.05,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Image.asset(
                                    "assets/images/rupee 1.png",
                                    height: 40,
                                    width: 40,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dashboardController
                                            .amountReceivedList[0].text!,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            Icons.currency_rupee,
                                            color: Colors.black,
                                            size: 20,
                                          ),
                                          Text(
                                            dashboardController
                                                .amountReceivedList[0]
                                                .incomeAmount!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(ROUTE_TRANSACTION_LIST);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xFFE0D9FF)),
                                        child: Row(
                                          children: [
                                            Text("view_details".tr,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12)),
                                            SizedBox(width: 5),
                                            Image.asset(
                                              "assets/images/share.png",
                                              color: Colors.black,
                                              height: 14,
                                              width: 14,
                                            )
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                  if (dashboardController.responseCode == '200')
                    Container(
                      padding: EdgeInsets.all(15.r),
                      child: Center(
                        child: Text(
                          'quick_link'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontSize: TextUtils.commonTextSize,
                                  color: textColor,
                                  fontWeight: TextUtils.titleTextWeight),
                        ),
                      ),
                    ),
                  if (dashboardController.responseCode == '200')
                    if (dashboardController.menuListData.length > 0)
                      Container(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: GridView.count(
                            childAspectRatio:
                                MediaQuery.of(context).size.height /
                                    MediaQuery.of(context).size.width *
                                    0.5,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 15,
                            crossAxisCount: 3,
                            children: List.generate(
                                dashboardController.menuListData.length,
                                (index) {
                              var data =
                                  dashboardController.menuListData[index];
                              return DashboardCard(
                                dashCard: data,
                              );
                            }),
                          ))
                    else
                      ErrorMessage(
                        errorCode: '300',
                      ),
                  if (dashboardController.responseCode == '200')
                    Container(
                      padding:
                          const EdgeInsets.only(top: 24, bottom: 24, left: 10),
                      child: Text(
                        'my_menu'.tr,
                        style: TextStyle(
                            color: textColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  if (dashboardController.responseCode == '200')
                    if (userRole != GROWER)
                      Container(
                        child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(10),
                            itemCount: userRole == CFA
                                ? sideCFAMenuList.length
                                : sideCDOMenuList.length,
                            itemBuilder: (BuildContext context, int index) {
                              var data = userRole == CFA
                                  ? sideCFAMenuList[index]
                                  : sideCDOMenuList[index];
                              return Align(
                                alignment: Alignment.topLeft,
                                child: MenuTile(
                                    title: data['title'],
                                    icon: data['icon'],
                                    id: data['id']),
                              );
                            }),
                      )
                    else
                      Container(
                        child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio:
                                        MediaQuery.of(context).size.height /
                                            MediaQuery.of(context).size.width *
                                            0.5,
                                    crossAxisCount: 3),
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(10),
                            itemCount: sideGrowerMenuList.length,
                            itemBuilder: (BuildContext context, int index) {
                              var data = sideGrowerMenuList[index];
                              return Align(
                                alignment: Alignment.topLeft,
                                child: GrowerMenuTile(
                                    title: data['title'],
                                    icon: data['icon'],
                                    id: data['id'],
                                    color: data['color']),
                              );
                            }),
                      ),
                  // Container(
                  //   child: SingleChildScrollView(
                  //     scrollDirection: Axis.horizontal,
                  //     child: Column(
                  //       children: [
                  //         Row(
                  //           children: [
                  //             for (int i = 0;
                  //                 i < sideGrowerMenuList1.length;
                  //                 i++)
                  //               Container(
                  //                 height: 150,
                  //                 width: 150,
                  //                 child: MenuTile(
                  //                     title: sideGrowerMenuList1[i]
                  //                         ['title'],
                  //                     icon: sideGrowerMenuList1[i]['icon'],
                  //                     id: sideGrowerMenuList1[i]['id'],
                  //                     color: sideGrowerMenuList1[i]
                  //                         ['color']),
                  //               )
                  //           ],
                  //         ),
                  //         Row(
                  //           children: [
                  //             for (int i = 0;
                  //                 i < sideGrowerMenuList2.length;
                  //                 i++)
                  //               Container(
                  //                 height: 150,
                  //                 width: 150,
                  //                 child: MenuTile(
                  //                     title: sideGrowerMenuList2[i]
                  //                         ['title'],
                  //                     icon: sideGrowerMenuList2[i]['icon'],
                  //                     id: sideGrowerMenuList2[i]['id'],
                  //                     color: sideGrowerMenuList2[i]
                  //                         ['color']),
                  //               )
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  //   GridView.builder(
                  //       shrinkWrap: true,
                  //       gridDelegate:
                  //           SliverGridDelegateWithFixedCrossAxisCount(
                  //               crossAxisCount: 2),
                  //       physics: NeverScrollableScrollPhysics(),
                  //       padding: EdgeInsets.all(10),
                  //       itemCount:  userRole == CFA
                  //               ? sideCFAMenuList.length
                  //               : sideCDOMenuList.length,
                  //       itemBuilder: (BuildContext context, int index) {
                  //         var data =  userRole == CFA
                  //                 ? sideCFAMenuList[index]
                  //                 : sideCDOMenuList[index];
                  //         return Align(
                  //           alignment: Alignment.topLeft,
                  //           child: MenuTile(
                  //               title: data['title'],
                  //               icon: data['icon'],
                  //               id: data['id']),
                  //         );
                  //       }),
                  // ),
                  if (userRole == GROWER)
                    Container(
                        color: Color(0xFFFAFFEF),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (userRole == GROWER &&
                                dashboardController.growerListData.length > 0)
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 24, bottom: 24, left: 10),
                                child: Text(
                                  'pending_activity'.tr,
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            if (userRole == GROWER &&
                                dashboardController.growerListData.length > 0)
                              Container(
                                padding: EdgeInsets.only(
                                    left: 5, top: 5, bottom: 15),
                                child: TabBar(
                                  labelPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                  isScrollable: true,
                                  unselectedLabelColor: black,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xFF4A3699)),
                                  controller: dashboardController.tabController,
                                  tabs: dashboardController.growerListData.value
                                      .map(
                                        (e) => Tab(
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: Color(0xFF4A3699),
                                                    width: 1)),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child:
                                                  Text('${e.type}(${e.area})'),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            if (userRole == GROWER &&
                                dashboardController.growerListData.length > 0)
                              Container(
                                  height: 200,
                                  padding: EdgeInsets.only(left: 15),
                                  child: TabBarView(
                                    controller:
                                        dashboardController.tabController,
                                    children: dashboardController
                                        .growerListData.value
                                        .map((Groweractivities e) {
                                      return GrowerTile(
                                        model: e.activity!,
                                      );
                                    }).toList(),
                                  )),
                            if (userRole == GROWER &&
                                dashboardController.growerListData.length > 0)
                              SizedBox(
                                height: 56,
                              ),
                          ],
                        )),
                  if (userRole == CFA &&
                      dashboardController.cfaListData.length > 0)
                    Container(
                      padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
                      child: Text(
                        "recent_farmers_queries".tr,
                        style: TextStyle(
                            color: primaryColorDark,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  if (userRole == CFA &&
                      dashboardController.cfaListData.length > 0)
                    Container(
                      height: 220,
                      padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: dashboardController.cfaListData.length,
                          itemBuilder: (context, index) {
                            var data = dashboardController.cfaListData[index];
                            return CfaTile(
                              model: data,
                              onPressed: () {
                                Get.toNamed(ROUTE_REQUEST_LIST);
                              },
                            );
                          }),
                    ),
                  if (userRole == ZONAL_INCHARGE &&
                      dashboardController.cdoListData.length > 0)
                    Container(
                      padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
                      child: Text(
                        "recent_farmers_queries".tr,
                        style: TextStyle(
                            color: primaryColorDark,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  if (userRole == ZONAL_INCHARGE &&
                      dashboardController.cdoListData.length > 0)
                    Container(
                      height: 220,
                      padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: dashboardController.cdoListData.length,
                          itemBuilder: (context, index) {
                            var data = dashboardController.cdoListData[index];
                            return CdoTile(
                              model: data,
                              onPressed: () {
                                Get.toNamed(ROUTE_REQUEST_LIST);
                              },
                            );
                          }),
                    )
                  else if (dashboardController.responseCode == '404')
                    ErrorMessage(
                      errorCode: '300',
                    )
                  else if (dashboardController.responseCode == '500')
                    ErrorMessage(
                      errorCode: '300',
                    )
                  else
                    Container()
                ],
              ),
            ));
  }

  Widget updateDialog(BuildContext context) {
    return GetBuilder<DashboardController>(
        builder: (controller) => Container(
              margin: EdgeInsets.all(10),
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    kColorLightGrey.withOpacity(0.7),
                    kColorLightGrey.withOpacity(0.7),
                  ],
                  stops: [0.0, 0.5],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  // angle: 0,
                  // scale: undefined,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Text(
                    "update_available".tr,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.black,
                        fontSize: TextUtils.commonTextSize,
                        fontWeight: TextUtils.normalTextWeight),
                  ),
                  Spacer(),
                  SizedBox(
                      width: 80.w,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              onPrimary: Colors.white,
                              primary: primaryColor,
                              minimumSize: Size(88.r, 36.r),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.r, vertical: 12.r),
                              shadowColor: primaryLightColor),
                          child: Container(
                            width: 88.w,
                            margin: EdgeInsets.symmetric(horizontal: 10.r),
                            child: Align(
                              alignment: Alignment.center,
                              child: FittedBox(
                                child: Text(
                                  "update".tr,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.button,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            controller.checkVersion(context);
                          }))
                ],
              ),
            ));
  }

  Widget Carousel(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) => CarouselData(
        controller: controller,
        model: controller.bannerListData,
        onPress: () {
          print('DATa ON PRESS POSITION ${controller.carouselPosition.value}');
        },
      ),
    );
  }
}

class CarouselData extends StatelessWidget {
  dynamic controller;
  List<Banners>? model;
  Function()? onPress;

  CarouselData({this.controller, this.model, this.onPress});

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: 400,
        height: 210,
        alignment: Alignment.topCenter,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  height: 160,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, index1) {
                    controller.carouselPosition.value = index;
                    controller.update();
                  }),
              items: model!.map((res) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: EdgeInsets.only(left: 2, right: 2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          res.image!,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Container(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(model!, (index, url) {
                  return Container(
                    alignment: Alignment.bottomCenter,
                    width: 6.0,
                    height: 6.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.carouselPosition.value == index
                          ? primaryColor
                          : Color(0xFFc4c4c4),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GrowerMenuTile extends StatelessWidget {
  String? title;
  String? icon;
  int? id;
  Color? color;

  GrowerMenuTile({this.id, this.title, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    String userRole = Prefs.getString(ROLE_ID);

    return InkWell(
        onTap: () => onClickEVent(userRole),
        child: Stack(
          children: [
            Container(
                width: double.infinity,
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          icon!,
                          fit: BoxFit.fill,
                        )),
                    Spacer(),
                    Text(
                      '${title!.tr}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getLanguage() == 1 ? 12 : 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                  ],
                )),
            Positioned(
                right: 4,
                top: 4,
                child: Container(
                    child: Image.asset("assets/images/transparent.png"))),
          ],
        ));
  }

  void onClickEVent(String userRole) {
    switch (id) {
      case 1:
        {
          Get.toNamed(ROUTE_PROFILE);
          break;
        }
      case 2:
        {
          Get.toNamed(ROUTE_ACTIVITY_LIST_GROWER);
          break;
        }
      case 3:
        {
          Get.toNamed(ROUTE_REQUEST_LIST);
          break;
        }
      case 4:
        {
          Get.toNamed(ROUTE_TRANSACTION_LIST);
          break;
        }
      case 5:
        {
          //instance Diagnois
          Get.toNamed(ROUTE_INFO_CENTER_LIST);
          break;
        }
      case 6:
        {
          Get.toNamed(ROUTE_WEATHER);
          break;
        }
      case 7:
        {
          Get.toNamed(ROUTE_FINANCE_List);
          break;
        }
      case 8:
        {
          Get.toNamed(ROUTE_FERTILISER_CALC);
          break;
        }
      case 9:
        {
          Get.toNamed(ROUTE_ANNOUNCEMENTS_LIST);
          break;
        }
      case 10:
        {
          Get.toNamed(ROUTE_AGRI_IMPLEMENTS_LIST);
          break;
        }
      case 11:
        {
          Get.toNamed(ROUTE_SETTING);
          break;
        }
      case 12:
        {
          Get.toNamed(ROUTE_ACTIVITY_CFA_GROWER);
          break;
        }
      case 13:
        {
          Get.toNamed(ROUTE_VILLAGE_LIST);
          break;
        }
      case 14:
        {
          Get.toNamed(ROUTE_ACTIVITY_CDO_GRAPH);
          break;
        }
      case 15:
        {
          Get.toNamed(ROUTE_INSTANT_DIAGNOSIS);
          break;
        }
      case 16:
        {
          Get.toNamed(ROUTE_ACTIVITY_CFA_REPORT);
          break;
        }
      case 17:
        {
          Get.toNamed(ROUTE_ACTIVITY_CDO_REPORT_LIST);
          break;
        }

      case 20:
        {
          Get.toNamed(ROUTE_YARD_ACTIVIY);
          break;
        }
      case 21:
        {
          Get.toNamed(ROUTE_FAQ);
          break;
        }
      case 98:
        {
          Get.to(() => Harvesting());
          break;
        }
      case 99:
        {
          Get.to(() => InstantDiagnosisList());
          break;
        }
      case 100:
        {
          Get.to(() => FormListPage());
          break;
        }
    }
  }
}

class MenuTile extends StatelessWidget {
  String? title;
  String? icon;
  int? id;
  Color? color;

  MenuTile({this.id, this.title, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    String userRole = Prefs.getString(ROLE_ID);

    return InkWell(
        onTap: () => onClickEVent(userRole),
        child: Container(
            width: double.infinity,
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              color: color,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 2.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Container(
                    width: 56,
                    height: 56,
                    alignment: Alignment.center,
                    child: Image.asset(
                      icon!,
                      fit: BoxFit.fill,
                    )),
                Spacer(),
                Text(
                  '${title!.tr}',
                  style: TextStyle(
                    color: textColor,
                    fontSize: getLanguage() == 1 ? 14 : 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
              ],
            )));
  }

  void onClickEVent(String userRole) {
    switch (id) {
      case 1:
        {
          Get.toNamed(ROUTE_PROFILE);
          break;
        }
      case 2:
        {
          Get.toNamed(ROUTE_ACTIVITY_LIST_GROWER);
          break;
        }
      case 3:
        {
          Get.toNamed(ROUTE_REQUEST_LIST);
          break;
        }
      case 4:
        {
          Get.toNamed(ROUTE_TRANSACTION_LIST);
          break;
        }
      case 5:
        {
          //instance Diagnois
          Get.toNamed(ROUTE_INFO_CENTER_LIST);
          break;
        }
      case 6:
        {
          Get.toNamed(ROUTE_WEATHER);
          break;
        }
      case 7:
        {
          Get.toNamed(ROUTE_FINANCE_List);
          break;
        }
      case 8:
        {
          Get.toNamed(ROUTE_FERTILISER_CALC);
          break;
        }
      case 9:
        {
          Get.toNamed(ROUTE_ANNOUNCEMENTS_LIST);
          break;
        }
      case 10:
        {
          Get.toNamed(ROUTE_AGRI_IMPLEMENTS_LIST);
          break;
        }
      case 11:
        {
          Get.toNamed(ROUTE_SETTING);
          break;
        }
      case 12:
        {
          Get.toNamed(ROUTE_ACTIVITY_CFA_GROWER);
          break;
        }
      case 13:
        {
          Get.toNamed(ROUTE_VILLAGE_LIST);
          break;
        }
      case 14:
        {
          Get.toNamed(ROUTE_ACTIVITY_CDO_GRAPH);
          break;
        }
      case 15:
        {
          Get.toNamed(ROUTE_INSTANT_DIAGNOSIS);
          break;
        }
      case 16:
        {
          Get.toNamed(ROUTE_ACTIVITY_CFA_REPORT);
          break;
        }
      case 17:
        {
          Get.toNamed(ROUTE_ACTIVITY_CDO_REPORT_LIST);
          break;
        }

      case 20:
        {
          Get.toNamed(ROUTE_YARD_ACTIVIY);
          break;
        }
      case 21:
        {
          Get.toNamed(ROUTE_FAQ);
          break;
        }
      case 98:
        {
          Get.to(() => Harvesting());
          break;
        }
      case 99:
        {
          Get.to(() => InstantDiagnosisList());
          break;
        }
      case 100:
        {
          Get.to(() => FormListPage());
          break;
        }
    }
  }
}

class GrowerTile extends StatelessWidget {
  List<Activity>? model;

  GrowerTile({this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (model!.length > 0)
            Container(
              height: 195,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: model!.length,
                  itemBuilder: (context, index) {
                    var data = model![index];
                    return GowerActivityTile(
                      activityModel: data,
                      onPressed: () {
                        Get.toNamed(ROUTE_ACTIVITY_LIST_GROWER);
                      },
                    );
                  }),
            )
        ],
      ),
    );
  }
}

class GowerActivityTile extends StatelessWidget {
  Activity? activityModel;
  Function()? onPressed;

  GowerActivityTile({this.activityModel, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width / 2.2,
        margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFDADADA)),
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              height: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: activityModel!.overduestatus == 'Overdue'
                    ? Banner(
                        message: activityModel!.overduestatus!,
                        textStyle: TextStyle(
                          fontSize: 10,
                        ),
                        location: BannerLocation.topStart,
                        color: Colors.red,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PhotoTile(
                                imageUrl: activityModel!.activityImage,
                                width: double.infinity,
                                height: 100,
                                leftTopRadius: 8,
                                rightTopRadius: 8,
                                leftBottomRadius: 8,
                                rightBottomRadius: 8,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${activityModel!.activityEndMonth}',
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 6,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${activityModel!.activityName}',
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PhotoTile(
                              imageUrl: activityModel!.activityImage,
                              width: double.infinity,
                              height: 100,
                              leftTopRadius: 8,
                              rightTopRadius: 8,
                              leftBottomRadius: 8,
                              rightBottomRadius: 8,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${activityModel!.activityEndMonth}',
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 6,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${activityModel!.activityName}',
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            Positioned(
              right: 0,
              top: 4,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  top: 6,
                ),
                child: Transform(
                  transform: new Matrix4.identity()..scale(0.8),
                  child: Chip(
                    avatar: Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.orange,
                    ),
                    label: Text(
                      '${activityModel!.activityRewardPoints.toString()}',
                    ),
                    backgroundColor: kColorPrimaryGradient1,
                    labelStyle: TextStyle(
                        fontSize: 16,
                        color: primaryColorDark,
                        fontWeight: FontWeight.w800),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
            ),
            // Positioned(
            //     bottom: 0,
            //     left: 0,
            //     right: 0,
            //     child: Container(
            //       padding: EdgeInsets.only(top: 15, bottom: 15),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.only(
            //           bottomLeft: Radius.circular(8),
            //           bottomRight: Radius.circular(8),
            //         ),
            //         color: Colors.white.withOpacity(0.7),
            //       ),
            //       child: Column(
            //         children: [
            //           Container(
            //             padding: EdgeInsets.only(
            //               left: 10,
            //               right: 10,
            //               top: 6,
            //             ),
            //             child: Row(
            //               children: [
            //                 Expanded(
            //                   child: Text(
            //                     '${activityModel!.activityName}',
            //                     style: TextStyle(
            //                       color: textColor,
            //                       fontSize: 18,
            //                       fontWeight: FontWeight.w700,
            //                       fontStyle: FontStyle.normal,
            //                     ),
            //                     maxLines: 1,
            //                     overflow: TextOverflow.ellipsis,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Padding(
            //               padding: EdgeInsets.only(
            //                 left: 10,
            //                 right: 10,
            //               ),
            //               child: Row(
            //                 children: [
            //                   Expanded(
            //                     flex: 1,
            //                     child: Align(
            //                       alignment: Alignment.centerLeft,
            //                       child: Text(
            //                         '${activityModel!.activityEndMonth}',
            //                         style: TextStyle(
            //                           color: textColor,
            //                           fontSize: 12,
            //                           fontWeight: FontWeight.w700,
            //                           fontStyle: FontStyle.normal,
            //                         ),
            //                         maxLines: 1,
            //                         overflow: TextOverflow.ellipsis,
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               )),
            //         ],
            //       ),
            //     ))
          ],
        ),
      ),
    );
  }
}

class CfaTile extends StatelessWidget {
  Cfarequest? model;
  Function()? onPressed;

  CfaTile({this.model, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 290,
        margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              height: 470,
              child: PhotoTile(
                imageUrl: model!.image,
                width: double.infinity,
                height: 470,
                leftTopRadius: 8,
                rightTopRadius: 8,
                leftBottomRadius: 8,
                rightBottomRadius: 8,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                color: Colors.white.withOpacity(0.7),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${model!.reqType}',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${'farmer'.tr} : ',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${model!.name}',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       '${'plot'.tr} : ',
                  //       style: TextStyle(
                  //         color: textColor,
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w400,
                  //         fontStyle: FontStyle.normal,
                  //       ),
                  //       maxLines: 1,
                  //       overflow: TextOverflow.ellipsis,
                  //     ),
                  //     Text(
                  //       '${model!.plot}',
                  //       style: TextStyle(
                  //         color: textColor,
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w600,
                  //         fontStyle: FontStyle.normal,
                  //       ),
                  //       maxLines: 1,
                  //       overflow: TextOverflow.ellipsis,
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${model!.date}',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${model!.status}',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CdoTile extends StatelessWidget {
  Cdorequest? model;
  Function()? onPressed;

  CdoTile({this.model, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 290,
        margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              height: 470,
              child: PhotoTile(
                imageUrl: model!.image,
                width: double.infinity,
                height: 470,
                leftTopRadius: 8,
                rightTopRadius: 8,
                leftBottomRadius: 8,
                rightBottomRadius: 8,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                color: Colors.white.withOpacity(0.7),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${model!.reqType}',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${'farmer'.tr} : ',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${model!.name}',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       '${'plot'.tr} : ',
                  //       style: TextStyle(
                  //         color: textColor,
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w400,
                  //         fontStyle: FontStyle.normal,
                  //       ),
                  //       maxLines: 1,
                  //       overflow: TextOverflow.ellipsis,
                  //     ),
                  //     Text(
                  //       '${model!.plot}',
                  //       style: TextStyle(
                  //         color: textColor,
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w600,
                  //         fontStyle: FontStyle.normal,
                  //       ),
                  //       maxLines: 1,
                  //       overflow: TextOverflow.ellipsis,
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${model!.date}',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${model!.status}',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
