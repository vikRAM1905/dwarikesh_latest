import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../controller/form2_controller.dart';
import '../../controller/form_view_controller.dart';
import '../../utils/colorUtils.dart';
import '../../utils/constant.dart';
import '../../utils/textUtils.dart';

class Form2 extends StatefulWidget {
  const Form2({Key? key}) : super(key: key);

  @override
  State<Form2> createState() => _Form2State();
}

class _Form2State extends State<Form2> {
  final form2Controller = Get.put(Form2Controller());
  AutoCompleteTextField? searchTextField3;
  final TextEditingController autocompleteTextfield = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  DateTime? startDate;
  DateTime? endDate;

  Widget tabMenu(BuildContext context) {
    return GetBuilder<Form2Controller>(
        builder: (controller) => Container(
            width: double.infinity,
            padding: EdgeInsets.only(
                top: 20.h, bottom: 5.h, left: 10.w, right: 10.w),
            child: CupertinoSlidingSegmentedControl(
                padding: EdgeInsets.all(6),
                children: <int, Widget>{
                  0: Padding(
                    padding: EdgeInsets.only(
                        left: 10.0, right: 10, top: 15, bottom: 15),
                    child: Text(
                      'Demo Activities Update'.tr,
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
                      'Previous Details'.tr,
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
                },
                groupValue: controller.tabPosition.toInt(),
                onValueChanged: (val) {
                  controller.updatetabPosition(int.parse(val.toString()));
                })));
  }

  Widget tabDetail(BuildContext context) {
    return GetBuilder<Form2Controller>(
        builder: (controller) =>
            // Expanded(
            //         child: ListView.builder(
            //       physics: const AlwaysScrollableScrollPhysics(),
            //       controller: controller.scrollController,
            //       itemCount: controller.activityListData
            //           .where((x) => x.type
            //               .toString()
            //               .contains(controller.tabPosition.value.toString()))
            //           .toList()
            //           .length,
            //       itemBuilder: (context, int index) {
            //         int arr_lenth = controller.activityListData
            //             .where((x) => x.type
            //                 .toString()
            //                 .contains(controller.tabPosition.value.toString()))
            //             .toList()
            //             .length;

            controller.tabPosition == 0 ? formTab(context) : detailsTab());
  }

  // )));
  onWillPop() {
    Get.offNamed(ROUTE_FORM_LIST);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Text("Demo Activities Update"),
            backgroundColor: primaryColor,
            centerTitle: true,
          ),
          body: GetBuilder<Form2Controller>(
              builder: ((controller) =>
                  controller.isLoading.value || controller.autofillData.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              tabMenu(context),
                              SizedBox(
                                height: 10,
                              ),
                              tabDetail(context),
                            ],
                          ),
                        )))),
    );
  }

  Widget formTab(BuildContext context) {
    return GetBuilder<Form2Controller>(
        builder: (controller) => controller.isLoading.value ||
                controller.autofillData.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : Container(
                padding: EdgeInsets.all(5),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Row(
                      children: [
                        Container(
                          width: 150,
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            readOnly: true,
                            enabled: false,
                            focusNode: controller.node1,
                            style: TextStyle(
                              color: textColor,
                              fontSize: TextUtils.hintTextSize,
                              fontWeight: TextUtils.titleTextWeight,
                              fontStyle: FontStyle.normal,
                            ),
                            controller: controller.villageCodeText,
                            decoration: InputDecoration(
                                // suffixIcon: controller.searchVillage.value
                                //     ? InkWell(
                                //         child: Icon(
                                //           Icons.search,
                                //           color: Colors.grey,
                                //         ),
                                //         onTap: () async {
                                //           Get.dialog(Progressbar());
                                //           controller.callVillageApi(
                                //               controller.villageCodeText.text);
                                //           controller.update();
                                //         },
                                //       )
                                //     : null,
                                labelText: 'Village Code *',
                                labelStyle: TextStyle(fontSize: 14)),
                            // onChanged: (value) {
                            //   if (value.length != 0)
                            //     controller.villageBoolChange();
                            //   controller.update();
                            // },
                          ),
                        ),
                        Container(
                          width: 240,
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: TextStyle(
                              color: textColor,
                              fontSize: TextUtils.hintTextSize,
                              fontWeight: TextUtils.titleTextWeight,
                              fontStyle: FontStyle.normal,
                            ),
                            controller: controller.villageNameText,
                            // ..text = controller.villageName.value,
                            readOnly: true,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: "Village Name *",
                              labelStyle: TextStyle(fontSize: 14),
                            ),
                            // onChanged: (pattern) async {
                            //   if (response.statusCode == 200) {
                            //     Map<String, dynamic> userss =
                            //         json.decode(response.body);
                            //     List<dynamic> users = userss["items"];

                            //     //  return users.map((json) => auto.Item.fromJson(json)).where((user) {
                            //     //  final nameLower = user.title!.toLowerCase();
                            //     //  final queryLower = query.toLowerCase();
                            //     //  return nameLower.contains(queryLower);
                            //     //  }).toList();
                            //   } else {
                            //     throw Exception();
                            //   }
                            // },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        readOnly: true,
                        enabled: false,
                        focusNode: controller.node2,
                        style: TextStyle(fontSize: 18),
                        controller: controller.growerCodeText,
                        decoration: InputDecoration(
                            // suffixIcon: controller.searchFarmer.value
                            //     ? InkWell(
                            //         child: Icon(
                            //           Icons.search,
                            //           color: Colors.black,
                            //         ),
                            //         onTap: () async {
                            //           Get.dialog(Progressbar());
                            //           controller.callGrowerApi(
                            //               controller.growerCodeText.text);
                            //           controller.update();
                            //         },
                            //       )
                            //     : null,
                            labelText: 'Farmer Code *',
                            labelStyle: TextStyle(fontSize: 14)),
                        // onChanged: (value) async {
                        //   if (value.length != 0) controller.farmerBoolChange();
                        //   controller.update();
                        // },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        style: TextStyle(fontSize: 18),
                        controller: controller.growerNameText,
                        // ..text = controller.farmerName.value,
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: "Name *",
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                        // onChanged: (pattern) async {
                        //   if (response.statusCode == 200) {
                        //     Map<String, dynamic> userss =
                        //         json.decode(response.body);
                        //     List<dynamic> users = userss["items"];

                        //     //  return users.map((json) => auto.Item.fromJson(json)).where((user) {
                        //     //  final nameLower = user.title!.toLowerCase();
                        //     //  final queryLower = query.toLowerCase();
                        //     //  return nameLower.contains(queryLower);
                        //     //  }).toList();
                        //   } else {
                        //     throw Exception();
                        //   }
                        // },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        style: TextStyle(fontSize: 18),
                        controller: controller.growerFatherNameText,
                        // ..text = controller.fatherName.value,
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: "Father Name *",
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                        // onChanged: (pattern) async {
                        //   if (response.statusCode == 200) {
                        //     Map<String, dynamic> userss =
                        //         json.decode(response.body);
                        //     List<dynamic> users = userss["items"];

                        //     //  return users.map((json) => auto.Item.fromJson(json)).where((user) {
                        //     //  final nameLower = user.title!.toLowerCase();
                        //     //  final queryLower = query.toLowerCase();
                        //     //  return nameLower.contains(queryLower);
                        //     //  }).toList();
                        //   } else {
                        //     throw Exception();
                        //   }
                        // },
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 180,
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            readOnly: true,
                            enabled: false,
                            style: TextStyle(fontSize: 18),
                            focusNode: controller.node3,
                            controller: controller.varietyCodeText,
                            decoration: InputDecoration(
                              // suffixIcon: controller.searchVeriety.value
                              //     ? InkWell(
                              //         child: Icon(
                              //           Icons.search,
                              //           color: Colors.black,
                              //         ),
                              //         onTap: () async {
                              //           Get.dialog(Progressbar());
                              //           controller.callVarietyApi(
                              //               controller.varietyCodeText.text);
                              //           controller.update();
                              //         },
                              //       )
                              //     : null,
                              labelText: 'Variety Code *',
                              labelStyle: TextStyle(fontSize: 14),
                            ),
                            // onChanged: (value) async {
                            //   if (value.length != 0)
                            //     controller.verietyBoolChange();
                            //   controller.update();
                            // },
                          ),
                        ),
                        Container(
                          width: 220,
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: TextStyle(fontSize: 18),
                            controller: controller.varietyNameText,
                            // ..text = controller.varietyName.value,
                            readOnly: true,
                            enabled: false,
                            decoration: const InputDecoration(
                              labelText: "Variety Name *",
                              labelStyle: TextStyle(fontSize: 14),
                            ),
                            // onChanged: (pattern) async {
                            //   if (response.statusCode == 200) {
                            //     Map<String, dynamic> userss =
                            //         json.decode(response.body);
                            //     List<dynamic> users = userss["items"];

                            //     //  return users.map((json) => auto.Item.fromJson(json)).where((user) {
                            //     //  final nameLower = user.title!.toLowerCase();
                            //     //  final queryLower = query.toLowerCase();
                            //     //  return nameLower.contains(queryLower);
                            //     //  }).toList();
                            //   } else {
                            //     throw Exception();
                            //   }
                            // },
                          ),
                        ),
                      ],
                    ),

                    Container(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: TextStyle(fontSize: 18),
                          controller: controller.cropTypeText,
                          // ..text = controller.varietyName.value,
                          readOnly: true,
                          enabled: false,
                          decoration: const InputDecoration(
                            labelText: "Crop Type *",
                            labelStyle: TextStyle(fontSize: 14),
                          ),
                        )),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: DropdownButtonFormField(
                    //     hint: Text(
                    //       controller.cropType.value,
                    //       style: TextStyle(
                    //           // fontSize: 14,
                    //           // color:
                    //           //  growerController.currentFactoryName.value == "Crob Type"
                    //           //     ?
                    //           // Colors.grey[400],
                    //           // : textColor,
                    //           // fontWeight: growerController.currentFactoryName.value == "${"factory_select".tr}" ?TextUtils.headerTextWeight : TextUtils.normalTextWeight,
                    //           ),
                    //     ),
                    //     isExpanded: true,
                    //     icon: Icon(Icons.arrow_drop_down),
                    //     iconSize: 25,
                    //     style: TextStyle(color: textColor),
                    //     decoration: const InputDecoration(
                    //       border: OutlineInputBorder(),
                    //     ),
                    //     items: controller.cropTypeList.map(
                    //       (val) {
                    //         return DropdownMenuItem<String>(
                    //           value: val.name,
                    //           child: Text(
                    //             val.name!,
                    //             style: TextStyle(
                    //               color: textColor,
                    //               fontSize: TextUtils.hintTextSize,
                    //               fontWeight: TextUtils.titleTextWeight,
                    //               fontStyle: FontStyle.normal,
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     ).toList(),
                    //     onChanged: (val) {
                    //       controller.updateCropType(val);
                    //       print("val:    ${controller.cropType.value}");
                    //     },
                    //   ),
                    // ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField(
                        onTap: () {
                          if (controller.changeValue.value == true)
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Want to change Activity Type"),
                                    content: Text(
                                      "It will reload the form\n click Ok to continue",
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      Colors.blue[400]!)),
                                          onPressed: () {
                                            Get.back();
                                            Get.back();
                                          },
                                          child: Text("Cancel",
                                              style: TextStyle(
                                                  color: Colors.white))),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      Colors.green[400]!)),
                                          onPressed: () {
                                            controller.changeValue.value =
                                                false;
                                            Get.back();
                                            Get.offAndToNamed(ROUTE_FORM_2,
                                                arguments: controller.id);
                                          },
                                          child: Text("OK",
                                              style: TextStyle(
                                                  color: Colors.white))),
                                    ],
                                  );
                                });
                        },
                        hint: Text(
                          controller.activityTypeSelect.value,
                          style: TextStyle(
                              // fontSize: 14,
                              // color:
                              //  growerController.currentFactoryName.value == "Crob Type"
                              //     ?
                              // Colors.grey[400],
                              // : textColor,
                              // fontWeight: growerController.currentFactoryName.value == "${"factory_select".tr}" ?TextUtils.headerTextWeight : TextUtils.normalTextWeight,
                              ),
                        ),
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 25,
                        style: TextStyle(color: textColor),
                        decoration: const InputDecoration(
                          labelText: "Activity Type *",
                          labelStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(),
                        ),
                        items: controller.activityTypeList.map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val.type,
                              child: Text(
                                val.type!,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: TextUtils.hintTextSize,
                                  fontWeight: TextUtils.titleTextWeight,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          controller.selectActivityType(val);
                          print(
                              "val:    ${controller.activityTypeSelect.value}");
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField(
                        hint: Text(
                          controller.activityNameSelect.value,
                          style: TextStyle(
                              // fontSize: 14,
                              // color:
                              //  growerController.currentFactoryName.value == "Crob Type"
                              //     ?
                              // Colors.grey[400],
                              // : textColor,
                              // fontWeight: growerController.currentFactoryName.value == "${"factory_select".tr}" ?TextUtils.headerTextWeight : TextUtils.normalTextWeight,
                              ),
                        ),
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 25,
                        style: TextStyle(color: textColor),
                        decoration: const InputDecoration(
                          labelText: "Activity Code *",
                          labelStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(),
                        ),
                        items: controller.activityList.map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val.codeName,
                              child: Text(
                                val.codeName!,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: TextUtils.hintTextSize,
                                  fontWeight: TextUtils.titleTextWeight,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          controller.selectActivityCode(val);
                          print(
                              "val:    ${controller.activityNameSelect.value}");
                        },
                      ),
                    ),

                    // Row(
                    //   children: [
                    //     Container(
                    //       width: 150,
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: searchTextField3 =
                    //           AutoCompleteTextField<String>(
                    //         controller: controller.plotEntityCodeText
                    //           ..text = controller.activityCodeSelect.value,
                    //         key: key,
                    //         suggestions: controller.activityCodeList,
                    //         style: new TextStyle(
                    //             color: Colors.black, fontSize: 16.0),
                    //         decoration: new InputDecoration(
                    //             // suffixIcon: Container(
                    //             //   width: 85.0,
                    //             //   height: 60.0,
                    //             // ),
                    //             // contentPadding:
                    //             //     EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                    //             filled: true,
                    //             labelText: 'Activity Code',
                    //             labelStyle: TextStyle(fontSize: 14)),
                    //         itemFilter: (item, query) {
                    //           return item
                    //               .toLowerCase()
                    //               .startsWith(query.toLowerCase());
                    //         },
                    //         itemSorter: (a, b) {
                    //           return a.compareTo(b);
                    //         },
                    //         itemSubmitted: (item) {
                    //           setState(() {
                    //             controller.activityCodeSelect.value =
                    //                 item.toString();
                    //             searchTextField3!.textField!.controller!.text =
                    //                 item.toString();
                    //             controller.update();
                    //             controller.getActivityCodeName(
                    //                 controller.activityCodeSelect.value);
                    //           });
                    //         },
                    //         itemBuilder: (context, item) {
                    //           return Container(
                    //               padding: const EdgeInsets.all(15.0),
                    //               decoration: BoxDecoration(
                    //                   color: Colors.white,
                    //                   border: Border.symmetric(
                    //                     vertical: BorderSide(),
                    //                     horizontal: BorderSide.none,
                    //                   )),
                    //               child: Text(item,
                    //                   style: TextStyle(
                    //                       fontSize: 16.0,
                    //                       color: Colors.black)));
                    //         },
                    //       ),
                    //     ),

                    // Row(
                    //   children: [
                    //     Container(
                    //       width: 150,
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: searchTextField3 =
                    //           AutoCompleteTextField<String>(
                    //         controller: controller.plotEntityCodeText
                    //           ..text = controller.activityCodeSelect.value,
                    //         key: key,
                    //         suggestions: controller.activityCodeList,
                    //         style: new TextStyle(
                    //             color: Colors.black, fontSize: 16.0),
                    //         decoration: new InputDecoration(
                    //             // suffixIcon: Container(
                    //             //   width: 85.0,
                    //             //   height: 60.0,
                    //             // ),
                    //             // contentPadding:
                    //             //     EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                    //             filled: true,
                    //             labelText: 'Activity Code',
                    //             labelStyle: TextStyle(fontSize: 14)),
                    //         itemFilter: (item, query) {
                    //           return item
                    //               .toLowerCase()
                    //               .startsWith(query.toLowerCase());
                    //         },
                    //         itemSorter: (a, b) {
                    //           return a.compareTo(b);
                    //         },
                    //         itemSubmitted: (item) {
                    //           setState(() {
                    //             controller.activityCodeSelect.value =
                    //                 item.toString();
                    //             searchTextField3!.textField!.controller!.text =
                    //                 item.toString();
                    //             controller.update();
                    //             controller.getActivityCodeName(
                    //                 controller.activityCodeSelect.value);
                    //           });
                    //         },
                    //         itemBuilder: (context, item) {
                    //           return Container(
                    //               padding: const EdgeInsets.all(15.0),
                    //               decoration: BoxDecoration(
                    //                   color: Colors.white,
                    //                   border: Border.symmetric(
                    //                     vertical: BorderSide(),
                    //                     horizontal: BorderSide.none,
                    //                   )),
                    //               child: Text(item,
                    //                   style: TextStyle(
                    //                       fontSize: 16.0,
                    //                       color: Colors.black)));
                    //         },
                    //       ),
                    //     ),
                    //     Container(
                    //       width: 250,
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: TextField(
                    //         style: TextStyle(fontSize: 16),
                    //         controller: controller.plotEntityCodeNameText
                    //           ..text = controller.activityNameSelect.value,
                    //         readOnly: true,
                    //         enabled: false,
                    //         decoration: const InputDecoration(
                    //           labelText: "Activity Name",
                    //           labelStyle: TextStyle(fontSize: 14),
                    //         ),
                    //         // onChanged: (pattern) async {
                    //         //   if (response.statusCode == 200) {
                    //         //     Map<String, dynamic> userss =
                    //         //         json.decode(response.body);
                    //         //     List<dynamic> users = userss["items"];

                    //         //     //  return users.map((json) => auto.Item.fromJson(json)).where((user) {
                    //         //     //  final nameLower = user.title!.toLowerCase();
                    //         //     //  final queryLower = query.toLowerCase();
                    //         //     //  return nameLower.contains(queryLower);
                    //         //     //  }).toList();
                    //         //   } else {
                    //         //     throw Exception();
                    //         //   }
                    //         // },
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    /* Row(
                      children: [
                        Container(
                          width: 150,
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            focusNode: controller.node4,
                            style: TextStyle(fontSize: 18),
                            controller: controller.plotEntityCodeText,
                            decoration: InputDecoration(
                                suffixIcon: controller.searchVillage.value
                                    ? InkWell(
                                        child: Icon(
                                          Icons.search,
                                          color: Colors.grey,
                                        ),
                                        onTap: () async {
                                          Get.dialog(Progressbar());
                                          controller.callEntityCodeApi(
                                              controller
                                                  .plotEntityCodeText.text);
                                          controller.update();
                                        },
                                      )
                                    : null,
                                labelText: 'Activity Code',
                                labelStyle: TextStyle(fontSize: 14)),
                            onChanged: (value) {
                              if (value.length != 0)
                                controller.villageBoolChange();
                              controller.update();
                            },
                          ),
                        ),
                        Container(
                          width: 240,
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: TextStyle(fontSize: 18),
                            controller: controller.plotEntityCodeNameText
                              ..text = controller.codeName.value,
                            readOnly: true,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: "Activity Name",
                              labelStyle: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),*/
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        readOnly: true,
                        onTap: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          DateTime? date = DateTime.now();

                          date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now());
                          controller.dateText.value =
                              DateFormat("yyyy-MM-dd").format(date!);
                        },
                        controller: controller.valueDateText
                          ..text = controller.dateText.value,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                          labelText: "Activity Date",
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField(
                        hint: Text(
                          controller.valueString.value,
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                //  growerController.currentFactoryName.value == "Crob Type"
                                //     ?
                                Colors.grey[400],
                            // : textColor,
                            // fontWeight: growerController.currentFactoryName.value == "${"factory_select".tr}" ?TextUtils.headerTextWeight : TextUtils.normalTextWeight,
                          ),
                        ),
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 25,
                        style: TextStyle(color: textColor),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Insect / Pest / Disease",
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                        items: controller.valueCharList.map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val.string,
                              child: Text(
                                val.string!,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: TextUtils.hintTextSize,
                                  fontWeight: TextUtils.titleTextWeight,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          controller.updateValueString(val);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 1.8,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 18),
                                controller: controller.valueNumberText,
                                decoration: InputDecoration(
                                  suffixText: "Nos",
                                  suffixStyle: TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                  // style: TextStyle(
                                  //     fontSize: 12, color: Colors.black54)),
                                  labelText: 'Input Qty',
                                  labelStyle: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 15,
                              width: MediaQuery.of(context).size.width / 3.0,
                              child: DropdownButtonFormField(
                                hint: Text(
                                  controller.unitString.value,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        //  growerController.currentFactoryName.value == "Crob Type"
                                        //     ?
                                        Colors.grey[400],
                                    // : textColor,
                                    // fontWeight: growerController.currentFactoryName.value == "${"factory_select".tr}" ?TextUtils.headerTextWeight : TextUtils.normalTextWeight,
                                  ),
                                ),
                                isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 25,
                                style: TextStyle(color: textColor),
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Unit",
                                    labelStyle: TextStyle(fontSize: 14)),
                                items: controller.measureList.map(
                                  (val) {
                                    return DropdownMenuItem<String>(
                                      value: val.name,
                                      child: Text(
                                        val.name!,
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: TextUtils.hintTextSize,
                                          fontWeight: TextUtils.titleTextWeight,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                  controller.updateUnitValue(val);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: TextField(
                              readOnly: true,
                              // enabled: false,
                              controller: controller.fileNameText
                                ..text = controller.fileName.value,
                              style: TextStyle(fontSize: 14),
                              // controller: controller.textController10,
                              decoration: InputDecoration(
                                labelText: "Photo Capture *",
                                labelStyle: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              bottomSheet(context, controller);
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 16,
                              width: MediaQuery.of(context).size.width / 7.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all()),
                              child:
                                  Icon(Icons.file_upload, color: primaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    controller.fileName.value != ""
                        ? Padding(
                            padding: EdgeInsets.all(5),
                            child: Container(
                                height: 150,
                                width: 150,
                                child: Image.file(controller.image!)),
                          )
                        : SizedBox(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        readOnly: true,
                        enabled: true,
                        controller: controller.plotGpsCoordinatesText
                          ..text = !controller.plotGpsCoordinates.isNull
                              ? "Lat : ${controller.plotGpsCoordinates!.latitude}, Long : ${controller.plotGpsCoordinates!.longitude}"
                              : "",
                        style: TextStyle(fontSize: 18),
                        // controller: controller.textController10,
                        decoration: InputDecoration(
                          labelText: "Plot GPS Coordinates *",
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        // readOnly: true,
                        controller: controller.remarksText,
                        style: TextStyle(fontSize: 18),
                        // controller: controller.textController11,
                        decoration: InputDecoration(
                          labelText: "Remarks (if any)",
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                          style: ButtonStyle(),
                          onPressed: () => (
                                  // controller
                                  //           .villageCodeText.text.isEmpty ||
                                  //       controller.villageCodeText.text == "" ||
                                  //       controller.villageName.value.isEmpty ||
                                  //       controller.villageName.value == "" ||
                                  //       controller.growerCodeText.text.isEmpty ||
                                  //       controller.growerCodeText.text == "" ||
                                  //       controller.growerNameText.text.isEmpty ||
                                  //       controller.growerNameText.text == "" ||
                                  //       controller
                                  //           .growerFatherNameText.text.isEmpty ||
                                  //       controller.growerFatherNameText.text == "" ||
                                  // controller.cropType.value.isEmpty ||
                                  //     controller.cropType.value ==
                                  //         "Crop Type" ||
                                  // controller.varietyCodeText.text.isEmpty ||
                                  // controller.varietyCodeText.text == "" ||
                                  // controller.varietyNameText.text.isEmpty ||
                                  // controller.varietyNameText.text == "" ||
                                  // controller.plotEntityCodeText.text.isEmpty ||
                                  //     controller.plotEntityCodeText.text ==
                                  //         "" ||
                                  controller.plotEntityCodeNameText.text
                                          .isEmpty ||
                                      controller.plotEntityCodeNameText.text ==
                                          "" ||
                                      controller.image.isNull ||
                                      controller.image == "" ||
                                      controller.plotGpsCoordinatesText.text
                                          .isEmpty ||
                                      controller.plotGpsCoordinatesText.text ==
                                          "")
                              ? Get.snackbar(
                                  "Error", "Fill All the Required Fields",
                                  colorText: Colors.white,
                                  backgroundColor: Colors.red,
                                  snackPosition: SnackPosition.TOP)
                              : controller.onSubmit(),
                          // controller.villageCode.value,
                          // controller.villageName.value,
                          // controller.growerCodeText.text,
                          // controller.growerNameText.text,
                          // controller.growerFatherNameText.text,
                          // controller.cropType.value,
                          // controller.varietyCodeText.text,
                          // controller.varietyNameText.text,
                          // controller.plotEntityCodeText.text,
                          // controller.plotEntityCodeNameText.text,
                          // controller.dateText.value,
                          // controller.valueNumberText.text,
                          // controller.valueString.value ?? null,
                          // controller.image!,
                          // controller.remarksText.text,
                          // controller.plotGpsCoordinates!.latitude
                          //     .toString(),
                          // controller.plotGpsCoordinates!.longitude
                          //     .toString()),
                          child: Container(
                            color: primaryColor,
                            height: 50,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
              ));
  }

  Widget detailsTab() {
    return GetBuilder<Form2Controller>(
        builder: (controller) => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: primaryColor,
              ))
            : controller.formDetail.length == 0
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/no_data_available.png",
                          height: 200, width: 200, fit: BoxFit.fill),
                      Text("No data added yet",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                    ],
                  ))
                : Column(
                    children: [
                      Container(
                          height: 70,
                          width: double.infinity,
                          color: primaryColor,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              width: 80,
                              child: Text(
                                "Activity Date",
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
                              width: 150,
                              child: Text(
                                "Activity Name",
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
                            // Container(
                            //   height: 40,
                            //   width: 0.5,
                            //   color: Color(0xFFE7E7E7),
                            // ),
                            // Container(
                            //   height: 40,
                            //   width: 0.5,
                            //   color: Color(0xFFE7E7E7),
                            // ),
                            // Container(
                            //   width: 40,
                            //   child: Text(
                            //     "Edit",
                            //     textAlign: TextAlign.center,
                            //     style: TextStyle(
                            //         color: Colors.black, fontSize: 14),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      controller.formDetail.isEmpty
                          ? Container(
                              child: Center(child: Text("No Data")),
                            )
                          : Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                // height: 400,
                                // width: double.infinity,
                                child: ListView.builder(
                                  itemCount: controller.formDetail.length,
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
                                              width: 80,
                                              child: Text(
                                                controller.formDetail[index]
                                                    .activityUpdatedDate!,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
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
                                              width: 150,
                                              child: Text(
                                                controller.formDetail[index]
                                                    .activityName!,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
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
                                                controller.formDetail[index]
                                                    .cropType!,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
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
                                                controller.formDetail[index]
                                                    .varietyName!,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            // Container(
                                            //   height: 60,
                                            //   width: 0.5,
                                            //   color: Color(0xFFE7E7E7),
                                            // ),

                                            // Container(
                                            //   width: 70,
                                            //   child: Text(
                                            //     controller.formDetail[index]
                                            //         .activityCode!,
                                            //     textAlign: TextAlign.center,
                                            //     style: TextStyle(
                                            //         color: Colors.black,
                                            //         fontWeight: FontWeight.bold,
                                            //         fontSize: 16),
                                            //   ),
                                            // ),
                                            // Container(
                                            //   height: 60,
                                            //   width: 0.5,
                                            //   color: Color(0xFFE7E7E7),
                                            // ),
                                            // Container(
                                            //   decoration: BoxDecoration(
                                            //     color: Colors.white,
                                            //     shape: BoxShape.circle,
                                            //     boxShadow: [
                                            //       BoxShadow(
                                            //           offset: Offset(0, 1),
                                            //           blurRadius: 1,
                                            //           color: Colors.grey,
                                            //           spreadRadius: 1)
                                            //     ],
                                            //   ),
                                            //   width: 40,
                                            //   child: InkWell(
                                            //     onTap: () {
                                            //       print(controller
                                            //           .formDetail[index].id);
                                            //       Get.toNamed(ROUTE_FORM_2,
                                            //           arguments: controller
                                            //               .formDetail[index]
                                            //               .id);
                                            //     },
                                            //     child: CircleAvatar(
                                            //       maxRadius: 13,
                                            //       backgroundColor:
                                            //           Color(0xFFF1F1F1),
                                            //       child: Image.asset(
                                            //         "assets/images/edit_icon.png",
                                            //         height: 16,
                                            //         width: 16,
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      )),
                                ),
                              ),
                            )
                    ],
                  ));
  }

  Future<void> bottomSheet(BuildContext context, Form2Controller controller) {
    return showModalBottomSheet<void>(
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
                        color: primaryColor, shape: BoxShape.circle),
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
                        color: primaryColor, shape: BoxShape.circle),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                        controller.getImage(
                          ImageSource.camera,
                        );
                      },
                      child:
                          Icon(Icons.camera_alt, size: 40, color: Colors.white),
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
  }
}
