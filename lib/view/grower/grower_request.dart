import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/controller/grower_request_report.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dwarikesh/model/gower_req_rep_model.dart';

class GrowerRequestReport extends StatelessWidget {
  final GrowerRequestReportctrl controller = Get.put(GrowerRequestReportctrl());
  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: Toolbar(
              title: 'grower_request_details'.tr,
              leftsideIcon: backIcon,
              leftsideBtnPress: () {
                Get.back();
              },
            ),
            body: controller.responseCode.value == '200'
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: controller.resListData.length,
                    itemBuilder: (BuildContext cntx, int index) {
                      var data = controller.resListData[index];
                      var count = index + 1;
                      return dataTile(context, data, count.toString());
                    },
                  )
                : ErrorMessage(
                    errorCode: '403',
                  ),
          ),
        ));
  }

  Widget dataTile(BuildContext context, Data model, String count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleTile(context, model.date.toString()),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 5,
            ),
            Text(
              count + ". ",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: TextUtils.commonTextSize,
                  color: grey,
                  fontWeight: TextUtils.headerTextWeight),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: TextUtils.commonTextSize,
                      color: textColor,
                      fontWeight: TextUtils.headerTextWeight),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'request_raised'.tr + " : ",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: TextUtils.hintTextSize,
                      color: grey,
                      fontWeight: TextUtils.normalTextWeight),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  model.request!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: TextUtils.mediumTextSize,
                      color: textColor,
                      fontWeight: TextUtils.normalTextWeight),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'response'.tr + " : ",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: TextUtils.hintTextSize,
                      color: grey,
                      fontWeight: TextUtils.normalTextWeight),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  model.response!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: TextUtils.mediumTextSize,
                      color: textColor,
                      fontWeight: TextUtils.normalTextWeight),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: titleMessage(
                            context, 'plot'.tr + " : ", model.canearea!),
                      ),
                      Expanded(
                        child: titleMessage(
                            context, 'caneArea'.tr + " : ", model.canearea!),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: titleMessage(
                            context, 'season'.tr + " : ", model.croptype!),
                      ),
                      Expanded(
                        child: titleMessage(
                            context, 'status'.tr + " : ", model.status!,
                            statusColor: primaryColor),
                      )
                    ],
                  ),
                ),
              ],
            ))
          ],
        ),
        SizedBox(
          height: 14,
        ),
      ],
    );
  }

  Widget titleTile(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      color: Colors.grey[100],
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: Text(title,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: primaryColor,
              fontWeight: TextUtils.mediumtTextWeight,
              fontSize: TextUtils.hintTextSize)),
    );
  }

  Widget titleMessage(BuildContext context, String title, String message,
      {Color? statusColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: textColor,
                fontSize: TextUtils.hintTextSize,
                fontWeight: TextUtils.mediumtTextWeight)),
        SizedBox(
          height: 5,
        ),
        Text(message,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: statusColor ?? textColor)),
      ],
    );
  }
}
