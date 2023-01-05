import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/controller/village_list_controller.dart';
import 'package:dwarikesh/model/villagewise_list_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VillagewiseList extends StatelessWidget {
  VillageWiseListController _controller = Get.put(VillageWiseListController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          title: GetBuilder<VillageWiseListController>(
            builder: (controller) => Text(
              'village_list'.tr + " (${controller.totalVillage.value})",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            GetBuilder<VillageWiseListController>(builder: (controller) {
              if (_controller.responseCode == '200')
                return _controller.resListData.length > 0
                    ? Padding(
                        padding: EdgeInsets.all(15),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _controller.resListData.length,
                          itemBuilder: ((context, index) {
                            var data = _controller.resListData[index];
                            return villageTile(
                              model: data,
                            );
                          }),
                        ),

                        // GridView.count(
                        //   shrinkWrap: true,
                        //   physics: NeverScrollableScrollPhysics(),
                        //   // crossAxisSpacing: 16,
                        //   mainAxisSpacing: 10,
                        //   crossAxisCount: 1,
                        //   children: List.generate(
                        //       _controller.resListData.length, (index) {
                        //     var data = _controller.resListData[index];
                        //     return villageTile(
                        //       model: data,
                        //     );
                        //   }),
                        // ),
                      )
                    : ErrorMessage(
                        errorCode: '403',
                      );
              else if (_controller.responseCode == '404')
                return ErrorMessage(
                  errorCode: '404',
                );
              else if (_controller.responseCode == '500')
                return ErrorMessage(
                  errorCode: '500',
                );
              else
                return ErrorMessage(
                  errorCode: '403',
                );
            })
          ]),
        ),
      ),
    );
  }
}

class villageTile extends StatelessWidget {
  Data? model;
  villageTile({this.model});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        // onTap: () {
        //   Prefs.setString(VILLAGE_ID, model!.villageid.toString());
        //   Get.toNamed(ROUTE_GROWER_LIST);
        // },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.20,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              titleMessage(context, 'village'.tr,
                  model!.villagename!.capitalizeFirst!, 20.0, 20.0),
              countMessage(context, 'total_growers'.tr,
                  model!.growercount.toString(), 20.0, 20.0, () {
                Prefs.setString(VILLAGE_ID, model!.villageid.toString());
                Get.toNamed(ROUTE_GROWER_LIST);
              }),
              countMessage(context, 'not_downloaded'.tr,
                  model!.notdownloadcount.toString(), 20.0, 20.0, () {
                Prefs.setString(VILLAGE_ID, model!.villageid.toString());
                Get.toNamed(ROUTE_GROWER_NO_APP_LIST);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleMessage(BuildContext context, String title, String message,
      var titleSize, var msgSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: textColor,
                fontSize: titleSize,
                fontWeight: TextUtils.titleTextWeight)),
        SizedBox(
          height: 4.h,
        ),
        Text(message,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: msgSize,
                color: primaryColor,
                fontWeight: TextUtils.titleTextWeight)),
      ],
    );
  }
}

Widget countMessage(BuildContext context, String title, String message,
    var titleSize, var msgSize, onTap) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text("${title}:",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: textColor,
              fontSize: titleSize,
              fontWeight: TextUtils.titleTextWeight)),
      SizedBox(
        width: 10.w,
      ),
      Text(message,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: msgSize,
              color: primaryColor,
              fontWeight: TextUtils.titleTextWeight)),
      SizedBox(
        width: 20.w,
      ),
      Container(
        height: 25,
        width: 60,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: Offset(0.5, 2),
              blurRadius: 0.5,
              spreadRadius: 1,
              color: white)
        ], color: primaryColor, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: InkWell(
            onTap: onTap,
            child: Text(
              "view".tr,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    ],
  );
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => str.capitalize).join(" ");
}
