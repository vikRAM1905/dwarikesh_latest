import 'dart:convert';
import 'package:dwarikesh/components/normal_button.dart';
import 'package:dwarikesh/controller/profile_controller.dart';
import 'package:dwarikesh/model/login_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:dwarikesh/widgets/input_field.dart';
import 'package:dwarikesh/widgets/profileTile.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: Toolbar(
          title: "personal_info".tr,
          leftsideIcon: backIcon,
          leftsideBtnPress: () {
            Get.back();
          },
        ),
        body: GetBuilder<ProfileController>(
          builder: (controller) {
            if (controller.isLoading.value) {
              return Align(
                alignment: Alignment.center,
                child: Container(
                  width: kToolbarHeight,
                  height: kToolbarHeight,
                  child: Progressbar(),
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          top: 15, bottom: 15, left: 20, right: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            primaryColor,
                            primaryColor,
                          ],
                          stops: [0.0, 1.0],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          // angle: 0,
                          // scale: undefined,
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black54,
                              blurRadius: 10.0,
                              offset: Offset(0.0, 1.75))
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MainProfileTile(
                              title: "name".tr,
                              message:
                                  '${controller.usermodel!.name.toString() ?? DATA_NULL_HANDLER} - ( ${controller.usermodel!.code.toString() ?? DATA_NULL_HANDLER} )'),
                          MainProfileTile(
                            title: "fatherName".tr,
                            message:
                                controller.usermodel!.fathername.toString() ??
                                    DATA_NULL_HANDLER,
                          ),
                          controller.usermodel!.roleId == GROWER
                              ? Container(
                                  margin: EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: MainProfileTile(
                                          title: "phone".tr,
                                          message: controller
                                                  .usermodel!.phonenumber
                                                  .toString() ??
                                              DATA_NULL_HANDLER,
                                          onclickFunction: () {
                                            launch("tel://" +
                                                controller
                                                    .usermodel!.phonenumber!);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: MainProfileTile(
                                            title: "culturableArea".tr,
                                            message: controller
                                                    .usermodel!.culturablearea
                                                    .toString() ??
                                                DATA_NULL_HANDLER),
                                      )
                                    ],
                                  ),
                                )
                              : MainProfileTile(
                                  title: "phone".tr,
                                  message: controller.usermodel!.phonenumber
                                          .toString() ??
                                      DATA_NULL_HANDLER,
                                  onclickFunction: () {
                                    launch("tel://" +
                                        controller.usermodel!.phonenumber!);
                                  },
                                ),
                          if (controller.usermodel!.roleId == CFA)
                            MainProfileTile(
                              title:
                                  '${"reporting".tr} ${"cdo".tr} ${"name".tr}',
                              message:
                                  '${controller.usermodel!.reportingName.toString() ?? DATA_NULL_HANDLER} - ( ${controller.usermodel!.reportingCode.toString() ?? DATA_NULL_HANDLER} )',
                            ),
                          if (controller.usermodel!.roleId == GROWER)
                            MainProfileTile(
                              title: "aadhar".tr,
                              message: controller.usermodel!.aadharNumber
                                      .toString() ??
                                  DATA_NULL_HANDLER,
                            ),
                          if (controller.usermodel!.roleId == GROWER)
                            if (controller.usermodel!.roleId == GROWER)
                              MainProfileTile(
                                title: "bank_account".tr,
                                message: controller.usermodel!.accountNumber
                                        .toString() ??
                                    DATA_NULL_HANDLER,
                              ),
                          controller.usermodel!.roleId != GROWER
                              ? MainProfileTile(
                                  title: "factoryname".tr,
                                  message: controller.usermodel!.factoryname
                                          .toString() ??
                                      DATA_NULL_HANDLER,
                                  onclickFunction: () {
                                    launch("tel://" +
                                        controller.usermodel!.phonenumber!);
                                  },
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    if (controller.usermodel!.roleId == CFA ||
                        controller.usermodel!.roleId == ZONAL_INCHARGE)
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(
                            top: 15, bottom: 15, left: 10, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CdoProfileTile(
                              title: "noOfVillages".tr,
                              message: controller.usermodel!.villagecount
                                      .toString() ??
                                  DATA_NULL_HANDLER,
                            ),
                            CdoProfileTile(
                              title: controller.usermodel!.roleId == CFA
                                  ? "noOfGrowers".tr
                                  : "noOfCFAs".tr,
                              message: controller.usermodel!.roleId ==
                                      ZONAL_INCHARGE
                                  ? controller.usermodel!.count.toString() ??
                                      DATA_NULL_HANDLER
                                  : controller.usermodel!.count.toString() ??
                                      DATA_NULL_HANDLER,
                            ),
                            CdoProfileTile(
                              title: "totalCulturableArea".tr,
                              message: controller.usermodel!.culturablearea
                                      .toString() ??
                                  DATA_NULL_HANDLER,
                            ),
                            CdoProfileTile(
                              title: "cdototalCaneArea".tr,
                              message:
                                  controller.usermodel!.canearea.toString() ??
                                      DATA_NULL_HANDLER,
                            ),
                          ],
                        ),
                      ),
                    if (controller.usermodel!.roleId == GROWER)
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.usermodel!.centre!.length,
                        itemBuilder: (BuildContext cntx, int index) {
                          var data = controller.usermodel!.centre![index];
                          return Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                                top: 36, bottom: 15, left: 15, right: 15),
                            decoration: BoxDecoration(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                centerProfileTile(
                                  title: "centre".tr,
                                  message: data.centre.toString() ??
                                      DATA_NULL_HANDLER,
                                ),
                                centerProfileTile(
                                  title: "society".tr,
                                  message: data.society.toString() ??
                                      DATA_NULL_HANDLER,
                                ),
                                centerProfileTile(
                                  title: "village".tr,
                                  message:
                                      "${data.village.toString() ?? DATA_NULL_HANDLER} (${data.villagecode.toString() ?? DATA_NULL_HANDLER})",
                                ),
                                centerProfileTile(
                                  title: "district".tr,
                                  message: data.district.toString() ??
                                      DATA_NULL_HANDLER,
                                ),
                                Container(
                                  height: 1,
                                  width: double.infinity,
                                  color: Colors.grey[100],
                                  margin: EdgeInsets.only(top: 15),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    if (controller.usermodel!.roleId == GROWER)
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.usermodel!.plot!.length,
                        itemBuilder: (BuildContext cntx, int index) {
                          var data = controller.usermodel!.plot![index];
                          var count = index + 1;
                          return Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                                top: 15, bottom: 15, left: 10, right: 10),
                            child: ClipRRect(
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: 15, bottom: 15, left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        kColorPrimaryGradient2,
                                        kColorPrimaryGradient1,
                                      ],
                                      stops: [0.0, 1.0],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      // angle: 0,
                                      // scale: undefined,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x1f000000),
                                        offset: Offset(0, 3),
                                        blurRadius: 33,
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // data.delete_btn != "0"
                                      //     ? InkWell(
                                      //         onTap: () {
                                      //           controller
                                      //               .commentTextController!
                                      //               .clear();
                                      //           ratoonRemoveDialog(context,
                                      //               data.plotid.toString());
                                      //         },
                                      //         child: Align(
                                      //           alignment:
                                      //               Alignment.centerRight,
                                      //           child: Container(
                                      //             margin: EdgeInsets.all(10),
                                      //             child: Row(
                                      //               mainAxisAlignment:
                                      //                   MainAxisAlignment.end,
                                      //               children: [
                                      //                 Icon(
                                      //                   deleteIcon,
                                      //                   color: Colors.red,
                                      //                   size: 24,
                                      //                 ),
                                      //                 Text(
                                      //                   'remove'.tr,
                                      //                   style: TextStyle(
                                      //                     color: Colors.red,
                                      //                     fontSize: TextUtils
                                      //                         .commonTextSize,
                                      //                     fontWeight: TextUtils
                                      //                         .normalTextWeight,
                                      //                   ),
                                      //                 ),
                                      //               ],
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       )
                                      //     : SizedBox(
                                      //         height: 36,
                                      //       ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 10,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: ProfileTile(
                                                title: "caneArea_profile".tr,
                                                message:
                                                    data.caneArea.toString() ??
                                                        DATA_NULL_HANDLER,
                                              ),
                                            ),
                                            Expanded(
                                              child: ProfileTile(
                                                title: "cropType".tr,
                                                message:
                                                    data.cropType.toString() ??
                                                        DATA_NULL_HANDLER,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 10,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: ProfileTile(
                                                title: "caneVariety".tr,
                                                message: data.caneVariety
                                                        .toString() ??
                                                    DATA_NULL_HANDLER,
                                              ),
                                            ),
                                            Expanded(
                                              child: ProfileTile(
                                                title: "plotshare".tr,
                                                message:
                                                    data.plotShare.toString() ??
                                                        DATA_NULL_HANDLER,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      ProfileTile(
                                          title: "plantationStartDate".tr,
                                          message: data.startDate.toString() ??
                                              DATA_NULL_HANDLER),
                                      ProfileTile(
                                          title: "estimated_yield".tr,
                                          message:
                                              data.estimatedYield.toString() ??
                                                  DATA_NULL_HANDLER),
                                      ProfileTile(
                                          title: "harvesting_date".tr,
                                          message:
                                              data.harvestingDate.toString() ??
                                                  DATA_NULL_HANDLER),
                                      ProfileTile(
                                          title: '${"cfa".tr} ${"name".tr}',
                                          message:
                                              '${data.cfaName.toString() ?? DATA_NULL_HANDLER}'),
                                      ProfileTile(
                                        title: "${"cfa".tr} ${"phone".tr}",
                                        message: data.cfaPhone.toString() ??
                                            DATA_NULL_HANDLER,
                                        onclickFunction: () {
                                          launch("tel://" + data.cfaPhone!);
                                        },
                                        phoneNumAvailable: "1",
                                      ),
                                    ],
                                  )),
                            ),
                          );
                        },
                      )
                  ],
                ),
              );
            }
          },
        ));
  }

  Future ratoonRemoveDialog(BuildContext context, String plotID) {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return GetBuilder<ProfileController>(
            builder: (controller) => Wrap(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  margin: EdgeInsets.only(top: 25, left: 20, right: 20),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "ratoon_delete".tr,
                          style: TextStyle(
                              color: textColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        "${'reason'.tr} *",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: TextUtils.commonTextSize,
                            color: primaryColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InputField(
                        keyboardType: TextInputType.text,
                        moveCurser: TextInputAction.done,
                        controller: controller.commentTextController,
                        maxLines: 5,
                        onChanged: (value) {},
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              width: size.width * 0.40,
                              child: NormalButton(
                                  text: "submit".tr,
                                  icons: sendIcon,
                                  textColor: Colors.white,
                                  color: primaryColor,
                                  press: () {
                                    Navigator.pop(context, false);
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    controller.validation(plotID);
                                  }),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: size.height * 0.05,
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              width: size.width * 0.40,
                              child: NormalButton(
                                  text: "cancel".tr,
                                  icons: cancelIcon,
                                  color: unselectedColor,
                                  textColor: textColor,
                                  press: () {
                                    Navigator.pop(context, false);
                                  }),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
