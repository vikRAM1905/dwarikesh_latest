import 'package:dwarikesh/components/photos_widget.dart';
import 'package:dwarikesh/controller/grower_activity_rep_controller.dart';
import 'package:dwarikesh/model/activity_list_grower_model.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GrowerActivityReport extends StatelessWidget {
  final GrowerActivityRepCtrl activityListGrowerController =
      Get.put(GrowerActivityRepCtrl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('activities'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: GetBuilder<GrowerActivityRepCtrl>(
          init: activityListGrowerController,
          builder: (value) {
            if (value.isLoading.value) {
              print('VALUE OF STATS ${value.isLoading.value}');
              return loadingOverlay();
            } else
              return SafeArea(
                  child: Container(
                child: Column(
                  children: [tabMenu(context), tabDetail(context)],
                ),
              ));
          }),
    );
  }
}

Widget tabMenu(BuildContext context) {
  return GetBuilder<GrowerActivityRepCtrl>(
      builder: (controller) => Container(
          height: 48.h,
          width: double.infinity,
          padding:
              EdgeInsets.only(top: 5.h, bottom: 5.h, left: 15.w, right: 15.w),
          child: CupertinoSlidingSegmentedControl(
              children: <int, Widget>{
                0: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'current'.tr,
                  ),
                ),
                1: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'upcoming'.tr,
                  ),
                ),
                2: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'completed'.tr,
                  ),
                ),
              },
              groupValue: controller.tabPosition.toInt(),
              onValueChanged: (val) {
                controller.updatetabPosition(int.parse(val.toString()));
              })));
}

Widget tabDetail(BuildContext context) {
  return GetBuilder<GrowerActivityRepCtrl>(
      builder: (controller) => Expanded(
              child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: controller.scrollController,
            itemCount: controller.activityListData
                .where((x) => x.type
                    .toString()
                    .contains(controller.tabPosition.value.toString()))
                .toList()
                .length,
            itemBuilder: (context, int index) {
              if ((index ==
                      controller.activityListData
                              .where((x) => x.type.toString().contains(
                                  controller.tabPosition.value.toString()))
                              .toList()
                              .length -
                          1) &&
                  controller.activityListData
                          .where((x) => x.type.toString().contains(
                              controller.tabPosition.value.toString()))
                          .toList()
                          .length <
                      (controller.totalRecords.value)) {
                return Container(
                    height: 100,
                    child: Align(
                      alignment: Alignment.center,
                      child: loadingOverlay(),
                    ));
              } else {
                return dataTile(
                  context,
                  controller.activityListData
                      .where((x) => x.type
                          .toString()
                          .contains(controller.tabPosition.value.toString()))
                      .toList()[index],
                );
              }
            },
          )));
}

Widget dataTile(BuildContext context, Data model) {
  return GetBuilder<GrowerActivityRepCtrl>(
      builder: (controller) => InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              margin: EdgeInsets.all(15.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      PhotoTile(
                        imageUrl: model.activityImage,
                        width: double.infinity,
                        height: 150,
                        leftTopRadius: 8,
                        rightTopRadius: 8,
                        leftBottomRadius: 0,
                        rightBottomRadius: 0,
                      ),
                      if (model.overduestatus != '')
                        Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8)),
                                color: overdueColor,
                              ),
                              padding: EdgeInsets.only(
                                  left: 10.r,
                                  right: 10.r,
                                  top: 5.r,
                                  bottom: 5.r),
                              child: Text(
                                '${model.overduedays} ${model.overduestatus}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: TextUtils.hintTextSize,
                                        color: white,
                                        fontWeight:
                                            TextUtils.mediumtTextWeight),
                              ),
                            ))
                    ],
                  ),
                  contentTile(context, model)
                ],
              ),
            ),
          ));
}

Widget contentTile(BuildContext context, Data model) {
  return Container(
    padding: EdgeInsets.all(10.r),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.activityName!,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6!.copyWith(
              fontSize: TextUtils.commonTextSize, color: primaryColor),
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          model.growerCompletedDate! == null || model.growerCompletedDate! == ''
              ? model.activityEndMonth!
              : model.growerCompletedDate!,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: TextUtils.hintTextSize,
              color: grey,
              fontWeight: TextUtils.mediumtTextWeight),
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          children: [
            Icon(
              plotIcon,
              color: primaryColor,
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              '${'plot'.tr} - ${model.plotId}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: TextUtils.hintTextSize,
                  color: primaryColor,
                  fontWeight: TextUtils.mediumtTextWeight),
            ),
            Container(
              margin: EdgeInsets.only(left: 5.r, right: 5.r),
              child: Text(
                ',',
                style: TextStyle(fontSize: TextUtils.headerTextSize),
              ),
            ),
            Text(
              '${model.villageName} ( ${model.caneAreaHa} )',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: TextUtils.hintTextSize,
                  color: textColor,
                  fontWeight: TextUtils.mediumtTextWeight),
            ),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          children: [
            Icon(
              orderIcon,
              color: primaryColor,
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              '${'season'.tr}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: TextUtils.hintTextSize,
                  color: primaryColor,
                  fontWeight: TextUtils.mediumtTextWeight),
            ),
            Text(
              ' : ${model.activitySeason}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: TextUtils.hintTextSize,
                  color: textColor,
                  fontWeight: TextUtils.mediumtTextWeight),
            ),
          ],
        ),
        Divider(),
        SizedBox(
          height: 8.h,
        ),
        Row(
          children: [
            Row(
              children: [
                Icon(
                  cupIcon,
                  color: Colors.orange[200],
                  size: 28.r,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '${'points'.tr} : ${model.activityRewardPoints}',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: TextUtils.hintTextSize,
                        color: primaryColor,
                        fontWeight: TextUtils.mediumtTextWeight),
                  ),
                ),
              ],
            ),
            Spacer(),
            taskStatus(context, model)
          ],
        )
      ],
    ),
  );
}

Widget taskStatus(BuildContext context, Data model) {
// activity_status =     0 - pending 1- approved 2 - rejected  3 - re assign
  return GetBuilder<GrowerActivityRepCtrl>(builder: (controller) {
    IconData? icons;
    Color? color;
    var title;

    switch (model.activityStatus) {
      case 0:
        title = 'waiting'.tr;
        icons = waitIcon;
        color = kColorLogoOrange;
        break;
      case 1:
        title = 'approved'.tr;
        icons = checkIcon;
        color = tabCompletedColor;
        break;
      case 2:
        title = 'rejected'.tr;
        icons = cancelIcon;
        color = tabCancelledColor;
        break;
      case 3:
        title = 'reassigned'.tr;
        icons = cancelIcon;
        color = tabCancelledColor;
        break;
    }

    if (controller.tabPosition == 2) {
      return Row(
        children: [
          Icon(
            icons,
            color: color,
            size: 28.r,
          ),
          SizedBox(
            width: 5.w,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: TextUtils.hintTextSize,
                  color: color,
                  fontWeight: TextUtils.mediumtTextWeight),
            ),
          ),
        ],
      );
    } else if (controller.tabPosition == 0 && model.activityStatus == 3) {
      return Row(
        children: [
          Icon(
            icons,
            color: color,
            size: 28.r,
          ),
          SizedBox(
            width: 5.w,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: TextUtils.hintTextSize,
                  color: color,
                  fontWeight: TextUtils.mediumtTextWeight),
            ),
          ),
        ],
      );
    } else
      return Container();
  });
}

Widget loadingOverlay() {
  return Container(
    height: double.infinity,
    child: Stack(
      children: [
        new Opacity(
          opacity: 0.1,
          child: ModalBarrier(dismissible: false, color: Colors.white),
        ),
        new Center(
            child: Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        )),
        new Center(
          child: new CircularProgressIndicator(
            strokeWidth: 3.0,
            valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
          ),
        ),
      ],
    ),
  );
}
