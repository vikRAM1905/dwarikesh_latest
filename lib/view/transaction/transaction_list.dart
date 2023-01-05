import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/controller/transaction_list_controller.dart';
import 'package:dwarikesh/model/transaction_list_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionList extends StatelessWidget {
  final _controller = Get.put(TransactionListController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: Toolbar(
          title: 'my_data_lists'.tr,
          leftsideIcon: backIcon,
          leftsideBtnPress: () {
            Get.back();
          },
        ),
        // ignore: missing_return
        body: GetBuilder<TransactionListController>(builder: (controller) {
          if (controller.responseCode.value == '200' &&
              controller.status.value == true)
            return Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  buildMenubar(context, _controller),
                  SizedBox(
                    height: 15.h,
                  ),
                  tabMenuView(context, _controller),
                ],
              ),
            );
          else
            return ErrorMessage(
              errorCode: '403',
            );
        }),
      ),
    );
  }
}

Widget buildMenubar(
    BuildContext context, TransactionListController controller) {
  return GetBuilder<TransactionListController>(
      init: controller,
      builder: (controller) {
        if (controller.resListData.length > 0 &&
            controller.responseCode.value == '200')
          return Container(
            margin: EdgeInsets.only(left: 15.r, right: 15.r),
            child: CupertinoSlidingSegmentedControl(
                children: <int, Widget>{
                  for (int i = 0; i < controller.resListData.length; i++)
                    i: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Text(
                        controller.resListData[i].tabName!.tr,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.black,
                            fontSize: TextUtils.hintTextSize,
                            fontWeight: TextUtils.mediumtTextWeight),
                      ),
                    ),
                },
                groupValue: controller.tabPosition.toInt(),
                onValueChanged: (val) {
                  print('DATA IS ${controller.resListData[0].tabName!.tr}');
                  controller.updatetabPosition(int.parse(val.toString()));
                }),
          );
        else
          return Container();
      });
}

Widget tabMenuView(BuildContext context, TransactionListController controller) {
  return GetBuilder<TransactionListController>(
      init: controller,
      builder: (controller) {
        if (controller.resListData.length > 0 &&
            controller.responseCode.value == '200')
          return Flexible(
              child: Container(
            color: Colors.grey[100],
            child: ListView.builder(
                itemCount: controller.resListData[0].tabType == 0 &&
                        controller.tabPosition.value == 0
                    ? controller.resListData[0].values!.length
                    : controller.resListData[1].tabType == 1 &&
                            controller.tabPosition.value == 1
                        ? controller.resListData[1].values!.length
                        : controller.resListData[2].tabType == 2 &&
                                controller.tabPosition.value == 2
                            ? controller.resListData[2].values!.length
                            : controller.resListData[3].values!.length,
                itemBuilder: (context, index) {
                  // ignore: missing_return
                  var data = controller.resListData[0].tabType == 0 &&
                          controller.tabPosition.value == 0
                      ? controller.resListData[0].values![index]
                      : controller.resListData[1].tabType == 1 &&
                              controller.tabPosition.value == 1
                          ? controller.resListData[1].values![index]
                          : controller.resListData[2].tabType == 2 &&
                                  controller.tabPosition.value == 2
                              ? controller.resListData[2].values![index]
                              : controller.resListData[3].values![index];

                  var arr = controller.resListData[0].tabType == 0 &&
                          controller.tabPosition.value == 0
                      ? controller.resListData[0].values
                      : controller.resListData[1].tabType == 1 &&
                              controller.tabPosition.value == 1
                          ? controller.resListData[1].values
                          : controller.resListData[2].tabType == 2 &&
                                  controller.tabPosition.value == 2
                              ? controller.resListData[2].values
                              : controller.resListData[3].values;

                  var heading = controller.resListData[0].tabType == 0 &&
                          controller.tabPosition.value == 0
                      ? controller.resListData[0].tabName
                      : controller.resListData[1].tabType == 1 &&
                              controller.tabPosition.value == 1
                          ? controller.resListData[1].tabName
                          : controller.resListData[2].tabType == 2 &&
                                  controller.tabPosition.value == 2
                              ? controller.resListData[2].tabName
                              : controller.resListData[3].tabName;

                  return controller.resListData[0].tabType == 0 &&
                          controller.tabPosition.value == 0
                      ? millPurchyDataTile(
                          model: data,
                          pos: index,
                          arr_data: arr!,
                          heading: heading!)
                      : controller.resListData[1].tabType == 1 &&
                              controller.tabPosition.value == 1
                          ? supplyTicketDataTile(
                              model: data,
                              pos: index,
                              arr_data: arr!,
                              heading: heading!)
                          : controller.resListData[2].tabType == 2 &&
                                  controller.tabPosition.value == 2
                              ? paymentsDataTile(
                                  model: data,
                                  pos: index,
                                  arr_data: arr!,
                                  heading: heading!)
                              : plotDataTile(
                                  model: data,
                                  pos: index,
                                  arr_data: arr!,
                                  heading: heading!);
                }),
          ));
        else
          return ErrorMessage(
            errorCode: '403',
          );
      });
}

class millPurchyDataTile extends StatelessWidget {
  final Values? model;
  final int? pos;
  String? tempDate;
  final _controller = Get.put(TransactionListController());
  List? arr_data;
  String? heading;
  int? serialNumber;

  millPurchyDataTile(
      {Key? key, @required this.model, this.pos, this.arr_data, this.heading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    serialNumber = pos;
    // serialNumber++;

    if (pos == 0) {
      _controller.tempDate.value = model!.deliveryDate!;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          datePrint(context, model!.deliveryDate!),
          SizedBox(
            height: 10.h,
          ),
          millpurchTile(
              context, pos!, serialNumber!, heading!, arr_data!, model!),
        ],
      );
    } else {
      if (_controller.tempDate.value == model!.deliveryDate) {
        return millpurchTile(
            context, pos!, serialNumber!, heading!, arr_data!, model!);
      } else {
        _controller.tempDate.value = model!.deliveryDate!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            datePrint(context, model!.deliveryDate!),
            SizedBox(
              height: 10.h,
            ),
            millpurchTile(
                context, pos!, serialNumber!, heading!, arr_data!, model!)
          ],
        );
      }
    }
  }
}

class supplyTicketDataTile extends StatelessWidget {
  final Values? model;
  final int? pos;
  String? tempDate;
  final _controller = Get.put(TransactionListController());
  List? arr_data;
  String? heading;
  int? serialNumber;

  supplyTicketDataTile(
      {Key? key, @required this.model, this.pos, this.arr_data, this.heading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    serialNumber = pos;
    // serialNumber++;

    if (pos == 0) {
      _controller.tempDate.value = model!.supplyDate!;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          datePrint(context, model!.supplyDate!),
          SizedBox(
            height: 10.h,
          ),
          supplyTile(context, pos!, serialNumber!, heading!, arr_data!, model!)
        ],
      );
    } else {
      if (_controller.tempDate.value == model!.supplyDate) {
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                child: Divider(),
                margin: EdgeInsets.only(left: 48.r, right: 48.r),
              ),
              supplyTile(
                  context, pos!, serialNumber!, heading!, arr_data!, model!)
            ],
          ),
        );
      } else {
        _controller.tempDate.value = model!.supplyDate!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            datePrint(context, model!.supplyDate!),
            SizedBox(
              height: 10.h,
            ),
            supplyTile(
                context, pos!, serialNumber!, heading!, arr_data!, model!)
          ],
        );
      }
    }
  }
}

Widget datePrint(BuildContext context, String date) {
  return Container(
    margin: EdgeInsets.only(left: 15.r),
    child: Text(
      '${date}',
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: primaryColor,
          fontSize: TextUtils.commonTextSize,
          fontWeight: TextUtils.mediumtTextWeight),
    ),
  );
}

class paymentsDataTile extends StatelessWidget {
  final Values? model;
  final int? pos;
  String? tempDate;
  final _controller = Get.put(TransactionListController());
  List? arr_data;
  String? heading;

  int? serialNumber;

  paymentsDataTile(
      {Key? key,
      @required this.model,
      this.pos,
      this.arr_data,
      this.heading,
      this.serialNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    serialNumber = pos;
    // serialNumber++;

    if (pos == 0) {
      _controller.tempDate.value = model!.paymentdate!;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          datePrint(context, model!.paymentdate!),
          SizedBox(
            height: 10.h,
          ),
          paymentTile(context, pos!, serialNumber!, heading!, arr_data!, model!)
        ],
      );
    } else {
      if (_controller.tempDate.value == model!.paymentdate!) {
        return paymentTile(
            context, pos!, serialNumber!, heading!, arr_data!, model!);
      } else {
        _controller.tempDate.value = model!.paymentdate!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            datePrint(context, model!.paymentdate!),
            SizedBox(
              height: 10.h,
            ),
            paymentTile(
                context, pos!, serialNumber!, heading!, arr_data!, model!)
          ],
        );
      }
    }
  }
}

class plotDataTile extends StatelessWidget {
  final Values? model;
  final int? pos;
  String? tempDate;
  final _controller = Get.put(TransactionListController());
  List? arr_data;
  String? heading;

  int? serialNumber;

  plotDataTile(
      {Key? key,
      @required this.model,
      this.pos,
      this.arr_data,
      this.heading,
      this.serialNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    serialNumber = pos;
    // serialNumber++;

    return plotTile(context, pos!, serialNumber!, heading!, arr_data!, model!);
  }
}

Widget millpurchTile(BuildContext context, int pos, int serialNumber,
    String heading, List arr_data, Values model) {
  Size size = MediaQuery.of(context).size;
  return GestureDetector(
      onTap: () {
        Prefs.setInt('index', pos);
        Prefs.setString('transationTile', heading);
        Get.toNamed(ROUTE_MILL_PURCHY_DETAIL, arguments: arr_data);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding:
            EdgeInsets.only(top: 20.r, right: 10.r, left: 15.r, bottom: 20.r),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    '${serialNumber}.',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: grey,
                        fontSize: TextUtils.hintTextSize,
                        fontWeight: TextUtils.headerTextWeight),
                  ),
                  padding: const EdgeInsets.only(right: 15),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.purchyNumber!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: TextUtils.commonTextSize,
                                  fontWeight: TextUtils.headerTextWeight),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          child: Text(
                            '${model.type}',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    color: grey,
                                    fontWeight: TextUtils.mediumtTextWeight),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  '${model.status}',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: primaryColor,
                      ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 10.sp, color: grey),
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Icon(
                  nextIcon,
                  color: Colors.grey,
                  size: 15.r,
                ),
                SizedBox(
                  width: 5.w,
                ),
              ],
            ),
          ],
        ),
      ));
}

Widget supplyTile(BuildContext context, int pos, int serialNumber,
    String heading, List arr_data, Values model) {
  Size size = MediaQuery.of(context).size;
  return GestureDetector(
      onTap: () {
        Prefs.setInt('index', pos);
        Prefs.setString('transationTile', heading);
        Get.toNamed(ROUTE_SUPPLY_TICKET_DETAIL, arguments: arr_data);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding:
            EdgeInsets.only(top: 20.r, right: 10.r, left: 15.r, bottom: 20.r),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    '${serialNumber}.',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: grey,
                        fontSize: TextUtils.hintTextSize,
                        fontWeight: TextUtils.headerTextWeight),
                  ),
                  padding: const EdgeInsets.only(right: 15),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.mPurchiNo!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: TextUtils.commonTextSize,
                                  fontWeight: TextUtils.headerTextWeight),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          child: Text(
                            '${model.amount}',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    color: grey,
                                    fontWeight: TextUtils.mediumtTextWeight),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  '${model.status}',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: primaryColor,
                      ),
                ),
                Text(
                  "",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 10.sp, color: grey),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Icon(
                  nextIcon,
                  color: Colors.grey,
                  size: 15.r,
                ),
                SizedBox(
                  width: 5.w,
                ),
              ],
            ),
          ],
        ),
      ));
}

Widget paymentTile(BuildContext context, int pos, int serialNumber,
    String heading, List arr_data, Values model) {
  Size size = MediaQuery.of(context).size;
  return GestureDetector(
      onTap: () {
        Prefs.setInt('index', pos);
        Prefs.setString('transationTile', heading);
        Get.toNamed(ROUTE_PAYMENTS_DETAIL, arguments: arr_data);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding:
            EdgeInsets.only(top: 20.r, right: 10.r, left: 15.r, bottom: 20.r),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    '${serialNumber}.',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: grey,
                        fontSize: TextUtils.hintTextSize,
                        fontWeight: TextUtils.headerTextWeight),
                  ),
                  padding: const EdgeInsets.only(right: 15),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.millPurchyNumber!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: TextUtils.commonTextSize,
                                  fontWeight: TextUtils.headerTextWeight),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          child: Text(
                            '${model.paymentdate}',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    color: grey,
                                    fontWeight: TextUtils.mediumtTextWeight),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  '\u{20B9} ${model.paidAmount}',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: primaryColor,
                      ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Icon(
                  nextIcon,
                  color: Colors.grey,
                  size: 15.r,
                ),
                SizedBox(
                  width: 5.w,
                ),
              ],
            ),
          ],
        ),
      ));
}

Widget plotTile(BuildContext context, int pos, int serialNumber, String heading,
    List arr_data, Values model) {
  Size size = MediaQuery.of(context).size;
  return GestureDetector(
      onTap: () {
        Prefs.setInt('index', pos);
        Prefs.setString('transationTile', heading);
        Get.toNamed(ROUTE_PLOT_DETAIL, arguments: arr_data);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding:
            EdgeInsets.only(top: 20.r, right: 10.r, left: 15.r, bottom: 20.r),
        margin: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    '${serialNumber}.',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: grey,
                        fontSize: TextUtils.hintTextSize,
                        fontWeight: TextUtils.headerTextWeight),
                  ),
                  padding: const EdgeInsets.only(right: 15),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.plotserial!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: TextUtils.commonTextSize,
                                  fontWeight: TextUtils.headerTextWeight),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          child: Text(
                            '${model.varietyName}',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    color: grey,
                                    fontWeight: TextUtils.mediumtTextWeight),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  '${model.sharepercentage} %',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: primaryColor,
                      ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Icon(
                  nextIcon,
                  color: Colors.grey,
                  size: 15.r,
                ),
                SizedBox(
                  width: 5.w,
                ),
              ],
            ),
          ],
        ),
      ));
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';

  String get allInCaps => this.toUpperCase();

  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => str.capitalize).join(" ");
}
