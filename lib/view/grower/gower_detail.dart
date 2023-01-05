import 'package:dwarikesh/components/photos_widget.dart';
import 'package:dwarikesh/controller/cfareport_grower_details.dart';
import 'package:dwarikesh/controller/grower_list_controller.dart';
import 'package:dwarikesh/model/cfa_grower_detrail_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GowerDetailReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CFaReportGrowerDetail>(
        builder: (controller) => SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: Toolbar(
                  title: 'grower_detail'.tr,
                  leftsideIcon: backIcon,
                  leftsideBtnPress: () {
                    Get.back();
                  },
                ),
                body: SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        nameTile(context, controller.growerName.value),
                        SizedBox(
                          height: 6.h,
                        ),
                        message(context, 'mobile'.tr + " : ",
                            controller.growerPhone.value),
                        SizedBox(
                          height: 6.h,
                        ),
                        message(context, 'fatherName'.tr + " : ",
                            controller.growerFather.value),
                        SizedBox(
                          height: 4.h,
                        ),
                        rewardTile(context, "earn_point".tr + " : ",
                            controller.growerReward.value),
                        SizedBox(
                          height: 6.h,
                        ),
                        message(context, 'bank_account'.tr + " : ",
                            controller.bank.value),
                        SizedBox(
                          height: 6.h,
                        ),
                        message(context, 'aadhar'.tr + " : ",
                            controller.aadhar.value),
                        SizedBox(
                          height: 20.h,
                        ),
                        Divider(),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.all(1),
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            children: List.generate(controller.menuList.length,
                                (index) {
                              var data = controller.menuList[index];
                              return dataTile(
                                context,
                                data,
                              );
                            }),
                          ),
                        )
                      ]),
                )),
              ),
            ));
  }
}

Widget nameTile(BuildContext context, String title) {
  return Text(
    title,
    style: Theme.of(context).textTheme.bodyText1!.copyWith(
        color: textColor,
        fontSize: TextUtils.commonTextSize,
        fontWeight: TextUtils.mediumtTextWeight),
  );
}

Widget message(BuildContext context, String title, String mesage) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: TextUtils.hintTextSize,
            color: textColor,
            fontWeight: TextUtils.normalTextWeight),
      ),
      SizedBox(
        width: 4.h,
      ),
      Text(
        mesage,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: TextUtils.hintTextSize,
            color: textColor,
            fontWeight: TextUtils.normalTextWeight),
      ),
    ],
  );
}

Widget rewardTile(BuildContext context, String title, String message) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        title,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: TextUtils.hintTextSize,
            color: textColor,
            fontWeight: TextUtils.normalTextWeight),
      ),
      SizedBox(
        width: 4.w,
      ),
      Icon(
        starIcon,
        color: Colors.yellow,
      ),
      SizedBox(
        width: 2.w,
      ),
      Text(
        message,
        style: Theme.of(context).textTheme.headline6!.copyWith(
            color: primaryColor,
            fontWeight: TextUtils.mediumtTextWeight,
            fontSize: TextUtils.mediumTextSize),
      ),
    ],
  );
}

Widget dataTile(BuildContext context, Menu model) {
  return GestureDetector(
    onTap: () {
      if (model.type == "1")
        Get.toNamed(ROUTE_CFA_REPORT_GROWER_PLOT);
      else if (model.type == "2") {
        Get.toNamed(ROUTE_CFA_REPORT_GROWER_ACTIVIY);
      } else if (model.type == "3") {
        Get.toNamed(ROUTE_CFA_REPORT_GROWER_REQ);
      }
    },
    child: Container(
      height: 150,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: Colors.grey[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Expanded(
              child: Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/circle_image_loading.png',
                    image: model.icon!,
                  ))),
          SizedBox(
            height: 10.0,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            color: primaryColor,
            child: Column(
              children: [
                Text(model.title!,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: TextUtils.hintTextSize,
                        fontWeight: TextUtils.mediumtTextWeight,
                        color: Colors.white)),
                SizedBox(height: 5),
                Text(model.count.toString(),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: TextUtils.commonTextSize,
                        fontWeight: TextUtils.mediumtTextWeight,
                        color: Colors.white))
              ],
            ),
          )
        ],
      ),
    ),
  );
}
