import 'package:dwarikesh/controller/formList_controller.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/view/form/form_1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constant.dart';
import 'form_2.dart';
import 'form_view.dart';

class FormListPage extends StatelessWidget {
  FormListPage({Key? key}) : super(key: key);
  final formListController = Get.put(FormListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Demo Plot Form"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: GetBuilder<FormListController>(
          builder: (controller) => controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          child: ListView.builder(
                            itemBuilder: ((context, index) => Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ListTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      tileColor: Color(0xFFF3F3F3),
                                      title: Text(
                                        controller.plotList[index].name!,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                      ),
                                      onTap: () => {
                                            if (index == 0)
                                              {
                                                Get.toNamed(ROUTE_FORM_1),
                                              }
                                            else
                                              Get.toNamed(ROUTE_FORM_2),
                                          }),
                                )),
                            itemCount: controller.plotList.length,
                          ),
                        ),
                        Container(
                            height: 70,
                            width: double.infinity,
                            color: primaryColor,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Demo Plot Header/Transaction",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )
                                ])),
                        Container(
                          // height: 40,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Text(
                              //   "S.No",
                              //   style:
                              //       TextStyle(color: Colors.grey, fontSize: 16),
                              // ),
                              Container(
                                width: 70,
                                child: Text(
                                  "Village Code",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 0.5,
                                color: Color(0xFFE7E7E7),
                              ),
                              // Text(
                              //   "Village Name",
                              //   style:
                              //       TextStyle(color: Colors.grey, fontSize: 16),
                              // ),
                              Container(
                                width: 70,
                                child: Text(
                                  "Farmer Code",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 0.5,
                                color: Color(0xFFE7E7E7),
                              ),
                              Container(
                                width: 70,
                                child: Text(
                                  "Crop Type",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 0.5,
                                color: Color(0xFFE7E7E7),
                              ),
                              // Text(
                              //   "Grower Father Name",
                              //   style:
                              //       TextStyle(color: Colors.grey, fontSize: 16),
                              // ),
                              Container(
                                width: 70,
                                child: Text(
                                  "Variety Name",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 0.5,
                                color: Color(0xFFE7E7E7),
                              ),
                              Container(
                                width: 40,
                                child: Text(
                                  "View",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 0.5,
                                color: Color(0xFFE7E7E7),
                              ),
                              Container(
                                width: 40,
                                child: Text(
                                  "Update",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        ),
                        controller.formList.isEmpty
                            ? Container(
                                child: Center(child: Text("No Data")),
                              )
                            : Align(
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                  // height: 400,
                                  // width: double.infinity,
                                  child: ListView.builder(
                                    itemCount: controller.formList.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: ((context, index) => Container(
                                          color: index % 2 == 0
                                              ? Color(0xFFF1F1F1)
                                              : Colors.white,
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              // Text(
                                              //   "S.No",
                                              //   style:
                                              //       TextStyle(color: Colors.grey, fontSize: 16),
                                              // ),
                                              Container(
                                                width: 70,
                                                child: Text(
                                                  controller.formList[index]
                                                      .villageCode!,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              Container(
                                                height: 60,
                                                width: 0.5,
                                                color: Color(0xFFE7E7E7),
                                              ),
                                              // Text(
                                              //   "Village Name",
                                              //   style:
                                              //       TextStyle(color: Colors.black, fontSize: 16),
                                              // ),
                                              Container(
                                                width: 70,
                                                child: Text(
                                                  controller.formList[index]
                                                      .growerCode!,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              Container(
                                                  height: 60,
                                                  width: 0.5,
                                                  color: Color(0xFFE7E7E7)),
                                              Container(
                                                width: 70,
                                                child: Text(
                                                  controller.formList[index]
                                                      .croptype!,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              Container(
                                                height: 60,
                                                width: 0.5,
                                                color: Color(0xFFE7E7E7),
                                              ),
                                              // Text(
                                              //   "Grower Father Name",
                                              //   style:
                                              //       TextStyle(color: Colors.grey, fontSize: 16),
                                              // ),
                                              Container(
                                                width: 70,
                                                child: Text(
                                                  controller.formList[index]
                                                      .varietyName!,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              Container(
                                                height: 60,
                                                width: 0.5,
                                                color: Color(0xFFE7E7E7),
                                              ),
                                              Container(
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(0, 1),
                                                        blurRadius: 1,
                                                        color: Colors.grey,
                                                        spreadRadius: 1)
                                                  ],
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    print(controller
                                                        .formList[index].id);
                                                    Get.toNamed(ROUTE_FORM_VIEW,
                                                        arguments: controller
                                                            .formList[index]
                                                            .id);
                                                  },
                                                  child: CircleAvatar(
                                                    maxRadius: 13,
                                                    backgroundColor:
                                                        Color(0xFFF1F1F1),
                                                    child: Image.asset(
                                                      "assets/images/view_icon.png",
                                                      height: 16,
                                                      width: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 60,
                                                width: 0.5,
                                                color: Color(0xFFE7E7E7),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(0, 1),
                                                        blurRadius: 1,
                                                        color: Colors.grey,
                                                        spreadRadius: 1)
                                                  ],
                                                ),
                                                width: 40,
                                                child: InkWell(
                                                  onTap: () {
                                                    print(controller
                                                        .formList[index].id);
                                                    Get.toNamed(ROUTE_FORM_2,
                                                        arguments: controller
                                                            .formList[index]
                                                            .id);
                                                  },
                                                  child: CircleAvatar(
                                                    maxRadius: 13,
                                                    backgroundColor:
                                                        Color(0xFFF1F1F1),
                                                    child: Image.asset(
                                                      "assets/images/edit_icon.png",
                                                      height: 16,
                                                      width: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                        // Container(
                        //   width: double.infinity,
                        //   margin: EdgeInsets.all(10),
                        //   padding: EdgeInsets.all(15),
                        //   decoration: BoxDecoration(
                        //     gradient: LinearGradient(
                        //       colors: [
                        //         kColorCloudyGradient3,
                        //         kColorCloudyGradient3,
                        //       ],
                        //       stops: [0.0, 1.0],
                        //       begin: Alignment.topCenter,
                        //       end: Alignment.bottomCenter,
                        //       // angle: 0,
                        //       // scale: undefined,
                        //     ),
                        //     borderRadius: BorderRadius.circular(12),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Color(0x1f000000),
                        //         offset: Offset(0, 3),
                        //         blurRadius: 33,
                        //         spreadRadius: 0,
                        //       ),
                        //     ],
                        //   ),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     children: [
                        //       SizedBox(
                        //         height: 10,
                        //       ),
                        //       Container(
                        //         margin: EdgeInsets.only(right: 10, left: 10),
                        //         child: Text(
                        //           "yr!",
                        //           style: TextStyle(
                        //               color: primaryColor,
                        //               fontSize: 12.0,
                        //               fontWeight: FontWeight.w400),
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         height: 10.0,
                        //       ),
                        //       Row(
                        //         children: [
                        //           Container(
                        //             width: 24,
                        //             height: 24,
                        //             margin:
                        //                 EdgeInsets.only(right: 10, left: 10),
                        //             // child: Image.asset(
                        //             //   "expanse",
                        //             //   fit: BoxFit.cover,
                        //             // ),
                        //           ),
                        //           Text(
                        //             '${'total_expenses'.tr} : ',
                        //             style: TextStyle(
                        //                 color: textColor,
                        //                 fontSize: 16.0,
                        //                 fontWeight: FontWeight.w400),
                        //           ),
                        //           Text(
                        //             "kdgjdg",
                        //             style: TextStyle(
                        //                 color: Colors.redAccent,
                        //                 fontSize: 25.0,
                        //                 fontWeight: FontWeight.w600),
                        //           ),
                        //         ],
                        //       ),
                        //       SizedBox(
                        //         height: 8,
                        //       ),
                        //       Row(
                        //         children: [
                        //           Container(
                        //             width: 24,
                        //             height: 24,
                        //             margin:
                        //                 EdgeInsets.only(right: 10, left: 10),
                        //             // child: Image.asset(
                        //             //   "income",
                        //             //   fit: BoxFit.cover,
                        //             // ),
                        //           ),
                        //           Text(
                        //             '${'total_income'.tr} : ',
                        //             style: TextStyle(
                        //                 color: textColor,
                        //                 fontSize: 16.0,
                        //                 fontWeight: FontWeight.w400),
                        //           ),
                        //           Text(
                        //             "jhdjgn",
                        //             style: TextStyle(
                        //                 color: primaryColor,
                        //                 fontSize: 16.0,
                        //                 fontWeight: FontWeight.w600),
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ),
                )),
    );
  }
}
