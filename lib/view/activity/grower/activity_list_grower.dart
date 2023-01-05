import 'dart:convert';

import 'package:dwarikesh/components/photos_widget.dart';

import 'package:dwarikesh/controller/activity_list_grower_controller.dart';

import 'package:dwarikesh/model/activity_list_grower_model.dart';
import 'package:dwarikesh/model/login_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ActivityListGrower extends StatelessWidget {
  ActivityListGrower({Key? key}) : super(key: key);
  final ActivityListGrowerController activityListGrowerController =
      Get.put(ActivityListGrowerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('activity_schedule'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
        // actions: [
        //   Container(
        //     width: 56,
        //     child: GetBuilder<ActivityListGrowerController>(
        //         builder: (controller) => PopupMenuButton(
        //               color: Colors.white,
        //               itemBuilder: (context) => controller.menuListData.map(
        //                 (val) {
        //                   return PopupMenuItem(
        //                     value: val.plotId,
        //                     child: Text(
        //                       val.plotName.toString() ?? '',
        //                       style: TextStyle(
        //                           color: Colors.black,
        //                           fontWeight: FontWeight.bold,
        //                           fontSize: 14),
        //                     ),
        //                   );
        //                 },
        //               ).toList(),
        //               onSelected: (value) async {
        //                 print(value);

        //                 controller.onSearchTextChanged(value.toString());

        //                 // Note You must create respective pages for navigation
        //               },
        //               child: Container(
        //                 margin: EdgeInsets.only(right: 10),
        //                 child: Icon(Icons.tune, size: 24, color: Colors.white),
        //               ),
        //             )),
        //   )
        // ],
      ),
      floatingActionButton:
          Obx(() => (activityListGrowerController.tabPosition.value == 2)
              ? FloatingActionButton.extended(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  label: Text(
                      activityListGrowerController.totalRewardPoint.value ??
                          '-'),
                  onPressed: () async {},
                  icon: Icon(Icons.emoji_events),
                )
              : SizedBox()),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: GetBuilder<ActivityListGrowerController>(
          init: activityListGrowerController,
          builder: (value) {
            if (value.isLoading.value) {
              print('VALUE OF STATS ${value.isLoading.value}');
              return loadingOverlay();
            } else
              return SafeArea(
                  child: Container(
                child: Column(
                  children: [tabMenu(context), tabDetail(context)],
                ),
              ));
          }),
    );
  }
}

Widget tabMenu(BuildContext context) {
  return GetBuilder<ActivityListGrowerController>(
      builder: (controller) => Container(
          width: double.infinity,
          padding:
              EdgeInsets.only(top: 20.h, bottom: 5.h, left: 10.w, right: 10.w),
          child: CupertinoSlidingSegmentedControl(
              padding: EdgeInsets.all(6),
              children: <int, Widget>{
                0: Padding(
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10, top: 15, bottom: 15),
                  child: Text(
                    'current'.tr,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: controller.tabPosition.value == 0
                            ? Colors.black
                            : grey,
                        fontSize: TextUtils.hintTextSize,
                        fontWeight: controller.tabPosition.value == 0
                            ? TextUtils.titleTextWeight
                            : TextUtils.normalTextWeight),
                  ),
                ),
                1: Padding(
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10, top: 15, bottom: 15),
                  child: Text(
                    'upcoming'.tr,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: controller.tabPosition.value == 1
                            ? Colors.black
                            : grey,
                        fontSize: TextUtils.hintTextSize,
                        fontWeight: controller.tabPosition.value == 1
                            ? TextUtils.titleTextWeight
                            : TextUtils.normalTextWeight),
                  ),
                ),
                2: Padding(
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10, top: 15, bottom: 15),
                  child: Text(
                    'completed'.tr,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: controller.tabPosition.value == 2
                            ? Colors.black
                            : grey,
                        fontSize: TextUtils.hintTextSize,
                        fontWeight: controller.tabPosition.value == 2
                            ? TextUtils.titleTextWeight
                            : TextUtils.normalTextWeight),
                  ),
                ),
              },
              groupValue: controller.tabPosition.toInt(),
              onValueChanged: (val) {
                controller.updatetabPosition(int.parse(val.toString()));
              })));
}

Widget tabDetail(BuildContext context) {
  return GetBuilder<ActivityListGrowerController>(
      builder: (controller) => Expanded(
              child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: controller.scrollController,
            itemCount: controller.activityListData
                .where((x) => x.type
                    .toString()
                    .contains(controller.tabPosition.value.toString()))
                .toList()
                .length,
            itemBuilder: (context, int index) {
              int arr_lenth = controller.activityListData
                  .where((x) => x.type
                      .toString()
                      .contains(controller.tabPosition.value.toString()))
                  .toList()
                  .length;

              if ((index ==
                      controller.activityListData
                              .where((x) => x.type.toString().contains(
                                  controller.tabPosition.value.toString()))
                              .toList()
                              .length -
                          1) &&
                  controller.activityListData
                          .where((x) => x.type.toString().contains(
                              controller.tabPosition.value.toString()))
                          .toList()
                          .length <
                      (controller.totalRecords.value)) {
                return Container(
                    height: 100,
                    child: Align(
                      alignment: Alignment.center,
                      child: loadingOverlay(),
                    ));
              } else {
                return demoTile(
                  context,
                  controller.activityListData
                      .where((x) => x.type
                          .toString()
                          .contains(controller.tabPosition.value.toString()))
                      .toList()[index],
                  index,
                );
              }
            },
          )));
}

Widget demoTile(BuildContext context, Data model, int index) {
  return GetBuilder<ActivityListGrowerController>(
      builder: (controller) => InkWell(
          onTap: () {
            if (controller.tabPosition.value == 0) {
              Prefs.setString(ENABLE_BTN, '1');
            } else {
              Prefs.setString(ENABLE_BTN, '0');
            }

            Get.toNamed(ROUTE_ACTIVITY_DETAIL_GROWER, arguments: model);
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.20,
            width: MediaQuery.of(context).size.width * 0.95,
            child: Card(
              elevation: 3,
              shadowColor: Color.fromARGB(255, 219, 218, 218),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          PhotoTile(
                            imageUrl: model.activityImage,
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.height * 0.13,
                            leftTopRadius: 8,
                            rightTopRadius: 0,
                            leftBottomRadius: 0,
                            rightBottomRadius: 0,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.005,
                                MediaQuery.of(context).size.height * 0.005,
                                MediaQuery.of(context).size.width * 0.005,
                                MediaQuery.of(context).size.height * 0.005),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(model.activityName!,
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.010),
                                Text(
                                    model.growerCompletedDate == null ||
                                            model.growerCompletedDate == ''
                                        ? model.activityEndMonth!
                                        : model.growerCompletedDate!,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.020),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset("assets/images/calender.png",
                                        height: 18, width: 18),
                                    Text("crop_type".tr,
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    Text(": ${model.cropType!}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.010),
                                Container(
                                    height: 0.3,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    color: primaryColor),
                              ],
                            ),
                          )
                        ],
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 100.0),
                      //   child: Divider(),
                      // ),
                      Row(
                        children: [
                          Spacer(),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/cup.png",
                                    height: MediaQuery.of(context).size.height *
                                        0.040,
                                    width: MediaQuery.of(context).size.width *
                                        0.040),
                                Text(
                                    controller.tabPosition.value != 2
                                        ? '${'points'.tr} : ${model.activityRewardPoints}'
                                        : '${'points'.tr} : ${model.activityEarnedPoints}',
                                    style: TextStyle(color: primaryColor))
                              ],
                            ),
                          ),
                          Spacer(),
                          taskStatus(context, model)
                        ],
                      )
                    ],
                  ),
                  if (model.overduestatus != '')
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.only(topRight: Radius.circular(8)),
                            color: overdueColor,
                          ),
                          padding: EdgeInsets.only(
                              left: 10.r, right: 10.r, top: 5.r, bottom: 5.r),
                          child: Text(
                            '${model.overduedays} ${model.overduestatus}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: TextUtils.hintTextSize,
                                    color: white,
                                    fontWeight: TextUtils.mediumtTextWeight),
                          ),
                        ))
                ],
              ),
            ),
          )));
}

// Widget dataTile(BuildContext context, Data model, int index, int arr) {
//   return GetBuilder<ActivityListGrowerController>(
//       builder: (controller) => InkWell(
//             onTap: () {
//               if (controller.tabPosition.value == 0) {
//                 Prefs.setString(ENABLE_BTN, '1');
//               } else {
//                 Prefs.setString(ENABLE_BTN, '0');
//               }

//               Get.toNamed(ROUTE_ACTIVITY_DETAIL_GROWER, arguments: model);
//             },
//             child: Column(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5.0),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey,
//                         offset: Offset(0.0, 1.0), //(x,y)
//                         blurRadius: 6.0,
//                       ),
//                     ],
//                   ),
//                   margin: EdgeInsets.all(15.r),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Stack(
//                         children: [
//                           PhotoTile(
//                             imageUrl: model.activityImage,
//                             width: double.infinity,
//                             height: 150,
//                             leftTopRadius: 8,
//                             rightTopRadius: 8,
//                             leftBottomRadius: 0,
//                             rightBottomRadius: 0,
//                           ),
//                           if (model.overduestatus != '')
//                             Positioned(
//                                 top: 0,
//                                 right: 0,
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                         topRight: Radius.circular(8)),
//                                     color: overdueColor,
//                                   ),
//                                   padding: EdgeInsets.only(
//                                       left: 10.r,
//                                       right: 10.r,
//                                       top: 5.r,
//                                       bottom: 5.r),
//                                   child: Text(
//                                     '${model.overduedays} ${model.overduestatus}',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyText1!
//                                         .copyWith(
//                                             fontSize: TextUtils.hintTextSize,
//                                             color: white,
//                                             fontWeight:
//                                                 TextUtils.mediumtTextWeight),
//                                   ),
//                                 ))
//                         ],
//                       ),
//                       contentTile(context, model)
//                     ],
//                   ),
//                 ),
//                 if (index == arr && controller.tabPosition.value == 2)
//                   SizedBox(
//                     height: 70,
//                   )
//               ],
//             ),
//           ));
// }

// Widget contentTile(BuildContext context, Data model) {
//   return Container(
//     padding: EdgeInsets.all(10.r),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           model.activityName!,
//           textAlign: TextAlign.center,
//           style: Theme.of(context)
//               .textTheme
//               .headline6!
//               .copyWith(fontSize: TextUtils.commonTextSize, color: textColor),
//         ),
//         SizedBox(
//           height: 8.h,
//         ),
//         Text(
//           model.growerCompletedDate == null || model.growerCompletedDate == ''
//               ? model.activityEndMonth!
//               : model.growerCompletedDate!,
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.bodyText1!.copyWith(
//               fontSize: TextUtils.hintTextSize,
//               color: grey,
//               fontWeight: TextUtils.mediumtTextWeight),
//         ),
//         SizedBox(
//           height: 8.h,
//         ),
//         Row(
//           children: [
//             Icon(
//               plotIcon,
//               color: primaryColor,
//             ),
//             SizedBox(
//               width: 5.w,
//             ),
//             Text(
//               '${'plot'.tr} - ${model.plotId}',
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                   fontSize: TextUtils.hintTextSize,
//                   color: primaryColor,
//                   fontWeight: TextUtils.mediumtTextWeight),
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 5.r, right: 5.r),
//               child: Text(
//                 ',',
//                 style: TextStyle(fontSize: TextUtils.headerTextSize),
//               ),
//             ),
//             Text(
//               '${model.villageName} ( ${model.caneAreaHa} )',
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                   fontSize: TextUtils.hintTextSize,
//                   color: textColor,
//                   fontWeight: TextUtils.mediumtTextWeight),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 8.h,
//         ),
//         Row(
//           children: [
//             Icon(
//               orderIcon,
//               color: primaryColor,
//             ),
//             SizedBox(
//               width: 5.w,
//             ),
//             Text(
//               '${'season'.tr}',
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                   fontSize: TextUtils.hintTextSize,
//                   color: primaryColor,
//                   fontWeight: TextUtils.mediumtTextWeight),
//             ),
//             Text(
//               ' : ${model.activitySeason}',
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                   fontSize: TextUtils.hintTextSize,
//                   color: textColor,
//                   fontWeight: TextUtils.mediumtTextWeight),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Icon(
//               descriptionIcon,
//               color: primaryColor,
//             ),
//             SizedBox(
//               width: 5.w,
//             ),
//             Text(
//               '${'cane_variety'.tr}',
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                   fontSize: TextUtils.hintTextSize,
//                   color: primaryColor,
//                   fontWeight: TextUtils.mediumtTextWeight),
//             ),
//             Text(
//               ' : ${model.cropType}',
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                   fontSize: TextUtils.hintTextSize,
//                   color: textColor,
//                   fontWeight: TextUtils.mediumtTextWeight),
//             ),
//           ],
//         ),
//         Divider(),
//         SizedBox(
//           height: 8.h,
//         ),
//         Row(
//           children: [
//             Row(
//               children: [
//                 Icon(
//                   cupIcon,
//                   color: Colors.orange[200],
//                   size: 28.r,
//                 ),
//                 SizedBox(
//                   width: 5.w,
//                 ),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Text(
//                     '${'points'.tr} : ${model.activityRewardPoints}',
//                     style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                         fontSize: TextUtils.hintTextSize,
//                         color: primaryColor,
//                         fontWeight: TextUtils.mediumtTextWeight),
//                   ),
//                 ),
//               ],
//             ),
//             Spacer(),
//             taskStatus(context, model)
//           ],
//         )
//       ],
//     ),
//   );
// }

Widget taskStatus(BuildContext context, Data model) {
// activity_status =     0 - pending 1- approved 2 - rejected  3 - re assign
  return GetBuilder<ActivityListGrowerController>(builder: (controller) {
    IconData? icons;
    Color? color;
    var title;

    switch (model.activityStatus) {
      case 0:
        title = 'waiting'.tr;
        icons = waitIcon;
        color = kColorLogoOrange;
        break;
      case 1:
        title = 'approved'.tr;
        icons = checkIcon;
        color = tabCompletedColor;
        break;
      case 2:
        title = 'rejected'.tr;
        icons = cancelIcon;
        color = tabCancelledColor;
        break;
      case 3:
        title = 'reassigned'.tr;
        icons = cancelIcon;
        color = tabCancelledColor;
        break;
    }

    if (controller.tabPosition == 2) {
      return Row(
        children: [
          Icon(
            icons,
            color: color,
            size: 28.r,
          ),
          SizedBox(
            width: 5.w,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: TextUtils.hintTextSize,
                  color: color,
                  fontWeight: TextUtils.mediumtTextWeight),
            ),
          ),
        ],
      );
    } else if (controller.tabPosition == 0 && model.activityStatus == 3) {
      return Row(
        children: [
          Icon(
            icons,
            color: color,
            size: 28.r,
          ),
          SizedBox(
            width: 5.w,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: TextUtils.hintTextSize,
                  color: color,
                  fontWeight: TextUtils.mediumtTextWeight),
            ),
          ),
        ],
      );
    } else
      return Container();
  });
}

Widget loadingOverlay() {
  return Container(
    height: double.infinity,
    child: Stack(
      children: [
        new Opacity(
          opacity: 0.1,
          child: ModalBarrier(dismissible: false, color: Colors.white),
        ),
        new Center(
            child: Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        )),
        new Center(
          child: new CircularProgressIndicator(
            strokeWidth: 3.0,
            valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
          ),
        ),
      ],
    ),
  );
}
