import 'dart:io';

import 'package:dwarikesh/components/app_bar_widget.dart';
import 'package:dwarikesh/components/section_title_only_widget.dart';
import 'package:dwarikesh/controller/instant_diagnosis_controller.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class InstantDiagnosisList extends StatelessWidget {
  final _controller = Get.put(InstantDiagnosisListController());

  TextStyle titleStyle = kTextStyleSubtitle1.copyWith(
    color: primaryColorDark,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          'instant_diagnosis'.tr,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: GetBuilder<InstantDiagnosisListController>(
        builder: (controller) => controller.resp == null &&
                controller.isRun == false
            ? FloatingActionButton.extended(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                label: Text('upload_image'.tr),
                onPressed: () async {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 140,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle),
                                  child: InkWell(
                                    onTap: () {
                                      Get.back();
                                      controller.getImage(ImageSource.gallery);
                                    },
                                    child: Icon(Icons.insert_photo_outlined,
                                        size: 40, color: Colors.white),
                                  )
                                  // onPressed: () {
                                  // },
                                  // child: Text("PICK FROM GALLERY"),
                                  ),
                              Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle),
                                  child: InkWell(
                                    onTap: () {
                                      Get.back();
                                      controller.getImage(
                                        ImageSource.camera,
                                      );
                                    },
                                    child: Icon(Icons.camera_alt,
                                        size: 40, color: Colors.white),
                                  )
                                  // onPressed: () {
                                  // },
                                  // child: Text("PICK FROM GALLERY"),
                                  ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                  // controller.getImage(ImageSource.camera);
                },
                icon: Icon(Icons.camera_alt),
              )
            : Container(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: GetBuilder<InstantDiagnosisListController>(
          builder: (controller) => controller.resp != null &&
                  controller.isRun == false
              ? Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: controller.isError == false
                        ? SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                      height: 180,
                                      width: double.infinity,
                                      child: Image.file(
                                        File(controller.image!.path),
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                // resultWidget(
                                //     "Key : ",
                                //     18.00,
                                //     controller.resp.result.key != null &&
                                //             controller.resp.result.key != ""
                                //         ? controller.resp.result.key
                                //         : "null",
                                //     true),
                                resultWidget(
                                    "Disease Name : ",
                                    18.00,
                                    controller.resp!.result!.otherInfo!.name !=
                                                null &&
                                            controller.resp!.result!.otherInfo!
                                                    .name !=
                                                ""
                                        ? controller
                                            .resp!.result!.otherInfo!.name!
                                        : "null",
                                    true),
                                resultWidget(
                                    "Message : ",
                                    20.00,
                                    controller.resp!.result!.message != null &&
                                            controller.resp!.result!.message !=
                                                ""
                                        ? controller.resp!.result!.message!
                                        : "null",
                                    true),
                                resultWidget(
                                    "Category : ",
                                    18.00,
                                    controller.resp!.result!.otherInfo!
                                                    .category !=
                                                null &&
                                            controller.resp!.result!.otherInfo!
                                                    .category !=
                                                ""
                                        ? controller
                                            .resp!.result!.otherInfo!.category!
                                        : "null",
                                    true),
                                resultWidget(
                                    "CropType : ",
                                    18.00,
                                    controller.resp!.result!.otherInfo!
                                                    .cropType !=
                                                null &&
                                            controller.resp!.result!.otherInfo!
                                                    .cropType !=
                                                ""
                                        ? controller
                                            .resp!.result!.otherInfo!.cropType!
                                        : "null",
                                    true),
                                resultWidget(
                                    "Cause : ",
                                    18.00,
                                    controller.resp!.result!.otherInfo!.cause !=
                                                null &&
                                            controller.resp!.result!.otherInfo!
                                                    .cause !=
                                                ""
                                        ? controller
                                            .resp!.result!.otherInfo!.cause!
                                        : "null",
                                    true),
                                resultWidget(
                                    "Symptoms : ",
                                    18.00,
                                    controller.resp!.result!.otherInfo!
                                                    .symptoms !=
                                                null &&
                                            controller.resp!.result!.otherInfo!
                                                    .symptoms !=
                                                ""
                                        ? controller
                                            .resp!.result!.otherInfo!.symptoms!
                                        : "null",
                                    true),
                                resultWidget(
                                    "Management : ",
                                    18.00,
                                    controller.resp!.result!.otherInfo!
                                                    .management !=
                                                null &&
                                            controller.resp!.result!.otherInfo!
                                                    .management !=
                                                ""
                                        ? controller.resp!.result!.otherInfo!
                                            .management!
                                        : "null",
                                    true),
                                resultWidget(
                                    "Comments : ",
                                    18.00,
                                    controller.resp!.result!.otherInfo!
                                                    .comments !=
                                                null &&
                                            controller.resp!.result!.otherInfo!
                                                    .comments !=
                                                ""
                                        ? controller
                                            .resp!.result!.otherInfo!.comments!
                                        : "null",
                                    true),
                                SizedBox(
                                  height: 200,
                                )
                              ],
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            height: double.infinity,
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white70,
                            ),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                        height: 180,
                                        width: double.infinity,
                                        child: Image.file(
                                          File(controller.image!.path),
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 200,
                                    height: 200,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        'assets/images/no_data_available.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "No Data Available",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "ai_result_failed".tr,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                )
              : controller.resp == null && controller.isRun == true
                  ? Container(
                      width: double.infinity,
                      height: double.infinity,
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white70,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                  height: 180,
                                  width: double.infinity,
                                  child: Image.file(
                                    File(controller.image!.path),
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 200,
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/no_data_available.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "No Match Found",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "ai_result_failed".tr,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      height: double.infinity,
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white70,
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/plant.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'please_take_a_close_up_picture_of_the_leaf_or_stem_for_which_you_want_to_diagnose_the_problem'
                                    .tr,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
    );
  }

  Padding resultWidget(String title, double size, String msg, bool weight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text.rich(
        TextSpan(
          children: <InlineSpan>[
            WidgetSpan(
              child: Container(
                width: 150,
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: size,
                      fontWeight: weight ? FontWeight.bold : FontWeight.normal),
                ),
              ),
            ),
            WidgetSpan(
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  msg,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: size,
                      fontWeight: weight ? FontWeight.bold : FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
