import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/form_view_controller.dart';

class FormViewPage extends StatelessWidget {
  FormViewPage({Key? key}) : super(key: key);
  final formViewController = Get.put(FormViewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Demo Plot View",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GetBuilder<FormViewController>(
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
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 600,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green[100]),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Row(
                                    //   children: [
                                    //     Text("Id : ",
                                    //         style: TextStyle(
                                    //             color: Colors.black54,
                                    //             fontWeight: FontWeight.w600,
                                    //             fontSize: 16)),
                                    //     Text(
                                    //         controller.formDetail[index].id
                                    //             .toString(),
                                    //         style: TextStyle(
                                    //             color: Colors.black,
                                    //             fontWeight: FontWeight.bold,
                                    //             fontSize: 18)),
                                    //   ],
                                    // ),
                                    Row(
                                      children: [
                                        Text("Village Code : ",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)),
                                        Text(
                                            controller
                                                .formDetail[index].villageCode!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Village Name : ",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)),
                                        Text(
                                            controller
                                                .formDetail[index].villageName!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Grower Code : ",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)),
                                        Text(
                                            controller
                                                .formDetail[index].growerCode!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Grower Name : ",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)),
                                        Text(
                                            controller
                                                .formDetail[index].growerName!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Grower Father Name : ",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)),
                                        Text(
                                            controller.formDetail[index]
                                                .growerFatherName!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Variety Code : ",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)),
                                        Text(
                                            controller
                                                .formDetail[index].varietyCode!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Variety Name : ",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)),
                                        Text(
                                            controller
                                                .formDetail[index].varietyName!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Crop Type : ",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)),
                                        Text(
                                            controller
                                                .formDetail[index].cropType!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Activity Type : ",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)),
                                        Text(
                                            controller.formDetail[index]
                                                .activityType!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Activity Code : ",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)),
                                        Text(
                                            controller.formDetail[index]
                                                .activityCode!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Activity Name : ",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)),
                                        Text(
                                            controller.formDetail[index]
                                                .activityName!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Activity Date : ",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)),
                                        Text(
                                            controller.formDetail[index]
                                                .activityDate!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Input Qty : ",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)),
                                        Text(
                                            controller
                                                .formDetail[index].inputQty!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Insect/Pest/Disease : ",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)),
                                        Text(
                                            controller
                                                .formDetail[index].valueChar!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Remarks : ",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)),
                                        Text(
                                            controller
                                                .formDetail[index].remarks!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Update By : ",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)),
                                        Text(
                                            controller
                                                .formDetail[index].updatedBy!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child:
                                          controller.formDetail[index].image ==
                                                      "" ||
                                                  controller.formDetail[index]
                                                      .image!.isEmpty
                                              ? Container(
                                                  color: Colors.grey,
                                                  child: Image.asset(
                                                      "assets/images/no_image_circle.png",
                                                      height: 200,
                                                      width: 300),
                                                )
                                              : Image.network(
                                                  controller
                                                      .formDetail[index].image!,
                                                  height: 200,
                                                  width: 300,
                                                  fit: BoxFit.fill),
                                    ),
                                  ]),
                            ),
                          );
                        },
                        itemCount: controller.formDetail.length,
                      )),
                    ),
                  ),
      ),
    );
  }
}
