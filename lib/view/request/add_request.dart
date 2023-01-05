import 'dart:convert';
import 'dart:io';

import 'package:dwarikesh/components/dropdown_picker.dart';
import 'package:dwarikesh/components/transparent_text_form_wo_icon_field.dart';
import 'package:dwarikesh/controller/request_add_controller.dart';
import 'package:dwarikesh/model/login_model.dart';
import 'package:dwarikesh/model/login_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/bottom_dialog.dart';
import 'package:dwarikesh/widgets/button.dart';
import 'package:dwarikesh/widgets/input_field.dart';
import 'package:dwarikesh/widgets/rounded_button.dart';
import 'package:dwarikesh/widgets/rounded_input_field.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dwarikesh/utils/constant.dart';

class AddNewRequest extends StatelessWidget {
  final RequestAddController requestAddController =
      Get.put(RequestAddController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: primaryColorDark,
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
    );

    return SafeArea(
      child: Scaffold(
          appBar: Toolbar(
            title: "addRequest".tr,
            leftsideIcon: backIcon,
            leftsideBtnPress: () {
              Get.back();
            },
          ),
          body: Container(
            width: double.infinity,
            child: LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  "requestType".tr + ' *',
                                  style: textStyle,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    color: primaryColorDark.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: GetBuilder<RequestAddController>(
                                    builder: (controller) => DropdownButton(
                                      hint: controller.menuListData.value ==
                                              'selectrequestType'.tr
                                          ? Text('selectrequestType'.tr)
                                          : Text(
                                              controller.req_type.value,
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontSize:
                                                    TextUtils.commonTextSize,
                                                fontWeight:
                                                    TextUtils.titleTextWeight,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                      isExpanded: true,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 0,
                                      underline: SizedBox(),
                                      style: TextStyle(color: textColor),
                                      items: controller.menuListData.map(
                                        (val) {
                                          return DropdownMenuItem<String>(
                                            value: val.type,
                                            child: Text(
                                              val.type,
                                              style: TextStyle(
                                                color: textColor,
                                                fontSize:
                                                    TextUtils.commonTextSize,
                                                fontWeight:
                                                    TextUtils.titleTextWeight,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (val) {
                                        controller.updateValue(val.toString());
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Text(
                                  "subrequestType".tr + ' *',
                                  style: textStyle,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    color: primaryColorDark.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: GetBuilder<RequestAddController>(
                                    builder: (controller) => DropdownButton(
                                      hint: controller.subRequestData.value ==
                                              "selectsubrequestType".tr
                                          ? Text("selectsubrequestType".tr)
                                          : Text(
                                              controller.sub_req_type.value,
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontSize:
                                                    TextUtils.commonTextSize,
                                                fontWeight:
                                                    TextUtils.titleTextWeight,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                      isExpanded: true,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 0,
                                      underline: SizedBox(),
                                      style: TextStyle(color: textColor),
                                      items: controller.subRequestData.map(
                                        (val) {
                                          return DropdownMenuItem<String>(
                                            value: val.subquery,
                                            child: Text(
                                              val.subquery!,
                                              style: TextStyle(
                                                color: textColor,
                                                fontSize:
                                                    TextUtils.commonTextSize,
                                                fontWeight:
                                                    TextUtils.titleTextWeight,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (val) {
                                        controller.updateSubreqestValue(
                                            val.toString());
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Text(
                                  'comment'.tr + ' *',
                                  style: textStyle,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                InputField(
                                  keyboardType: TextInputType.text,
                                  moveCurser: TextInputAction.done,
                                  controller: requestAddController
                                      .commentTextController,
                                  maxLines: 5,
                                  onChanged: (value) {},
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                GetBuilder<RequestAddController>(
                                  builder: (controller) => Container(
                                    alignment: Alignment.topRight,
                                    child: ClipOval(
                                      child: Material(
                                        color: unselectedColor, // button color
                                        child: InkWell(
                                          splashColor:
                                              primaryLightColor, // inkwell color
                                          child: SizedBox(
                                              width: 56,
                                              height: 56,
                                              child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: 24,
                                                  color: primaryColor)),
                                          onTap: () {
                                            showModalBottomSheet<void>(
                                              context: context,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            20.0)),
                                              ),
                                              builder: (BuildContext context) {
                                                return BottomDialog(
                                                    title: 'upload_picture'.tr,
                                                    message:
                                                        "upload_the_image_via_camera_or_gallery"
                                                            .tr,
                                                    rightSideIcons:
                                                        Icons.photo_album,
                                                    rightSideBtn: 'album'.tr,
                                                    leftSideIcons:
                                                        Icons.photo_camera,
                                                    leftSideBtn: 'camera'.tr,
                                                    yesBtn: () async {
                                                      Get.back();
                                                      await controller.getImage(
                                                          ImageSource.camera);
                                                    },
                                                    noBtn: () async {
                                                      controller.getImage(
                                                          ImageSource.gallery);
                                                      Get.back();
                                                    });
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GetBuilder<RequestAddController>(
                                  builder: (controller) => controller
                                                  .image_arr.length ==
                                              null ||
                                          controller.image_arr.isEmpty
                                      ? Container()
                                      : GridView.count(
                                          crossAxisCount: 3,
                                          shrinkWrap: true,
                                          children: List.generate(
                                              controller.image_arr.length,
                                              (index) {
                                            var image =
                                                controller.image_arr[index];
                                            return Container(
                                              margin: EdgeInsets.all(3),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    width: 170,
                                                    height: 100,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.file(
                                                        image,
                                                        height: double.infinity,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        child: ClipOval(
                                                          child: Material(
                                                            color:
                                                                unselectedBtnColor, // button color
                                                            child: InkWell(
                                                              splashColor:
                                                                  deActiveIconColor, // inkwell color
                                                              child: SizedBox(
                                                                  width: 24,
                                                                  height: 24,
                                                                  child: Icon(
                                                                      Icons
                                                                          .delete_outlined,
                                                                      size: 16,
                                                                      color: Color(
                                                                          0xFFD32F2F))),
                                                              onTap: () {
                                                                controller
                                                                    .removeImage(
                                                                        index);
                                                              },
                                                            ),
                                                          ),
                                                        )),
                                                  )
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ButtonField(
                                    text: "send".tr,
                                    color: primaryColor,
                                    press: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      requestAddController.validation();
                                    },
                                  ),
                                ),
                              ]),
                        ),
                      )),
                );
              },
            ),
          )),
    );
  }
}
