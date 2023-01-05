import 'package:dwarikesh/controller/cfareport_grower_details.dart';
import 'package:dwarikesh/model/cfa_grower_detrail_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GowerPlotDetail extends StatelessWidget {
  CFaReportGrowerDetail controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: Toolbar(
          title: 'grower_plot'.tr,
          leftsideIcon: backIcon,
          leftsideBtnPress: () {
            Get.back();
          },
        ),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: controller.plotdataList.length,
          itemBuilder: (BuildContext cntx, int index) {
            var data = controller.plotdataList[index];
            var count = index + 1;
            return dataTile(context, data);
          },
        ),
      ),
    );
  }

  Widget dataTile(BuildContext context, Plotdata model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        titleTile(context, 'plot'.tr + ' ' + model.plotid.toString()),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'cropType'.tr + " : ",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: TextUtils.mediumTextSize,
                    color: primaryColor,
                    fontWeight: TextUtils.headerTextWeight),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                model.croptype!,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: TextUtils.mediumTextSize,
                    color: textColor,
                    fontWeight: TextUtils.normalTextWeight),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'plantationStartDate'.tr + " : ",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: TextUtils.hintTextSize,
                    color: textColor,
                    fontWeight: TextUtils.normalTextWeight),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                model.plationdate!,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: TextUtils.hintTextSize,
                    color: textColor,
                    fontWeight: TextUtils.titleTextWeight),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: titleMessage(context, 'caneArea'.tr, model.canearea!),
              ),
              Expanded(
                child:
                    titleMessage(context, 'caneVariety'.tr, model.canevarity!),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: titleMessage(
                    context, '${"cfa".tr} ${"name".tr}', model.cfaname!),
              ),
              Expanded(
                child: titleMessage(
                    context, "${"cfa".tr} ${"phone".tr}", model.cfphone!),
              )
            ],
          ),
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
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: primaryColor,
              fontWeight: TextUtils.mediumtTextWeight,
              fontSize: TextUtils.hintTextSize)),
    );
  }

  Widget titleMessage(BuildContext context, String title, String message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: primaryColor,
                fontSize: TextUtils.commonTextSize,
                fontWeight: TextUtils.headerTextWeight)),
        SizedBox(
          height: 5,
        ),
        Text(message,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: textColor)),
      ],
    );
  }
}
