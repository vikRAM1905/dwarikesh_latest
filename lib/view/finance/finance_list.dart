import 'dart:io';

import 'package:dwarikesh/components/error_message.dart';

import 'package:dwarikesh/controller/finance_list_controller.dart';
import 'package:dwarikesh/model/finance_list_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class FinanceList extends StatelessWidget {
  final FinanceListController _controller = Get.put(FinanceListController());

  @override
  Widget build(BuildContext context) {
    String userRole = Prefs.getString(ROLE_ID);
    return Obx(
      () => SafeArea(
        child: Scaffold(
          appBar: Toolbar(
            title: "accounting".tr,
            leftsideIcon: backIcon,
            leftsideBtnPress: () {
              Get.back();
            },
          ),
          floatingActionButton: userRole == GROWER
              ? FloatingActionButton.extended(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  label: Text("addRecord".tr),
                  onPressed: () async {
                    await Get.toNamed(ROUTE_EXPENSE_ADD);
                  },
                  icon: Icon(Icons.add),
                )
              : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: SingleChildScrollView(
            child: RefreshIndicator(
                onRefresh: () async {
                  _controller.apiGetUserList();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfitLossCard(
                      totalIncome: '${_controller.totalIncome.value}',
                      yr: '${_controller.year.value}',
                      totalExpanse: '${_controller.totalExpanse.value}',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Text('expense_history'.tr,
                            style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600))),
                    SizedBox(
                      height: 15,
                    ),
                    if (_controller.responseCode == '200')
                      if (_controller.resListData.length > 0)
                        ListView.builder(
                            shrinkWrap: true,
                            padding:
                                EdgeInsets.only(bottom: kToolbarHeight + 10),
                            scrollDirection: Axis.vertical,
                            itemCount: _controller.resListData.length,
                            itemBuilder: (context, index) {
                              // ignore: missing_return
                              var data = _controller.resListData[index];
                              return FinanceItems(
                                request: data,
                              );
                            })
                      else
                        ErrorMessage(
                          errorCode: '403',
                        )
                    else if (_controller.responseCode == '404')
                      ErrorMessage(
                        errorCode: '404',
                      )
                    else if (_controller.responseCode == '500')
                      ErrorMessage(
                        errorCode: '500',
                      )
                    else
                      ErrorMessage(
                        errorCode: '403',
                      )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class ProfitLossCard extends StatelessWidget {
  final String? yr;
  final String? totalIncome, totalExpanse;

  const ProfitLossCard({
    Key? key,
    @required this.yr,
    @required this.totalIncome,
    @required this.totalExpanse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            kColorCloudyGradient3,
            kColorCloudyGradient3,
          ],
          stops: [0.0, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // angle: 0,
          // scale: undefined,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0x1f000000),
            offset: Offset(0, 3),
            blurRadius: 33,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(right: 10, left: 10),
            child: Text(
              yr!,
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                margin: EdgeInsets.only(right: 10, left: 10),
                child: Image.asset(
                  expanse,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                '${'total_expenses'.tr} : ',
                style: TextStyle(
                    color: textColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                '${totalExpanse}' ?? '',
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                margin: EdgeInsets.only(right: 10, left: 10),
                child: Image.asset(
                  income,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                '${'total_income'.tr} : ',
                style: TextStyle(
                    color: textColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                '${totalIncome}' ?? '',
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FinanceItems extends StatelessWidget {
  final Data? request;

  FinanceItems({
    Key? key,
    @required this.request,
  }) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FinanceListController _controller = Get.put(FinanceListController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<FinanceListController>(
        builder: (controller) => GestureDetector(
              onTap: () {
                controller.resListData
                    .forEach((element) => element.view = false);

                if (!request!.getViewButton) {
                  request!.setViewButton = true;
                } else {
                  request!.setViewButton = false;
                }

                controller.resListData.refresh();
                controller.update();
              },
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      width: 0.5, //                   <--- border width here
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 80,
                            padding: const EdgeInsets.all(5),
                            child: Icon(Icons.trending_down,
                                color: Colors.redAccent),
                          ),
                          Container(
                            width: 10,
                            height: 10,
                          ),
                          Expanded(
                            child: Container(
                              width: size.width * .85,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('${'area'.tr} : ',
                                          style: TextStyle(
                                              color: textColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                      Text(request!.area!,
                                          style: TextStyle(
                                              color: textColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(request!.createdDate!,
                                      style: TextStyle(
                                          color: textColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400)),
                                  SizedBox(height: 5),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text('${'total_expenses'.tr} : ',
                                              style: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600)),
                                          Text(request!.totalExpense.toString(),
                                              style: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                      Icon(
                                        request!.getViewButton
                                            ? Icons.arrow_drop_up_sharp
                                            : Icons.arrow_drop_down_sharp,
                                        size: 24,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                            width: 10,
                          ),
                        ],
                      ),
                      request!.getViewButton
                          ? Container(
                              margin:
                                  EdgeInsets.only(left: kToolbarHeight / 1.5),
                              child: Text('particulars'.tr,
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            )
                          : Container(),
                      request!.getViewButton
                          ? GetBuilder<FinanceListController>(
                              builder: (controller) => ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(
                                      top: kToolbarHeight / 2.5,
                                      left: kToolbarHeight / 1.5),
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: request!.particulars!.length,
                                  itemBuilder: (context, index) {
                                    var subDatas = request!.particulars![index];
                                    //print("Current section Index : $sectionIndex$index");
                                    return productTile(
                                        context, subDatas, index);
                                  }))
                          : Container()
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget productTile(BuildContext context, Particulars data, int index) {
    final controller = Get.put(FinanceListController());

    if (index == 0) {
      controller.tempHeadingName.value = data.categoryName!;
      return GetBuilder<FinanceListController>(
          builder: (controller) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.categoryName ?? '',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(data.productTitle ?? '',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text('${'expense'.tr} : ',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                      Text(data.expense.toString() ?? '',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ));
    } else {
      if (controller.tempHeadingName.value == data.categoryName)
        return GetBuilder<FinanceListController>(
            builder: (controller) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.productTitle ?? '',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text('${'expense'.tr} : ',
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w400)),
                        Text(data.expense.toString() ?? '',
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ));
      else {
        controller.tempHeadingName.value = data.categoryName!;
        return GetBuilder<FinanceListController>(
            builder: (controller) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.categoryName ?? '',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(data.productTitle ?? '',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text('${'expense'.tr} : ',
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w400)),
                        Text(data.expense.toString() ?? '',
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ));
      }
    }
  }
}
