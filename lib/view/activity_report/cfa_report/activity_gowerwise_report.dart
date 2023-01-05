import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/controller/activity_cfa_report_gower_list_controller.dart';
import 'package:dwarikesh/model/activity_cfa_report_gower_list_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityCFAreportGowerList extends StatelessWidget {
  final _controller = Get.put(ActivityCFAReportGowerListController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: Toolbar(
          title: Prefs.getString(TITLE_GOWER_OR_NAME),
          leftsideIcon: backIcon,
          leftsideBtnPress: () {
            Get.back();
          },
        ),
        body: Obx(() => SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 0,
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CupertinoSlidingSegmentedControl(
                            padding: EdgeInsets.all(6),
                            children: <int, Widget>{
                              0: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  'approved'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color:
                                              _controller.tabPosition.value == 0
                                                  ? Colors.black
                                                  : grey,
                                          fontSize: TextUtils.commonTextSize,
                                          fontWeight:
                                              TextUtils.titleTextWeight),
                                ),
                              ),
                              1: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  'unapproved'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color:
                                              _controller.tabPosition.value == 1
                                                  ? Colors.black
                                                  : grey,
                                          fontSize: TextUtils.commonTextSize,
                                          fontWeight:
                                              TextUtils.titleTextWeight),
                                ),
                              ),
                            },
                            groupValue: _controller.tabPosition.toInt(),
                            onValueChanged: (val) {
                              _controller
                                  .updatetabPosition(int.parse(val.toString()));
                            }),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                if (_controller.responseCode.value == '200')
                  _controller.resListData.length > 0
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: _controller.resListData.length,
                          itemBuilder: (context, index) {
                            var data = _controller.resListData[index];

                            return data.activitystatus == '0' &&
                                    _controller.tabPosition.value == 1
                                ? GowerTile(model: data)
                                : data.activitystatus == '1' &&
                                        _controller.tabPosition.value == 0
                                    ? GowerTile(
                                        model: data,
                                      )
                                    : Container();
                          })
                      : ErrorMessage(
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
              ]),
            )),
      ),
    );
  }
}

class GowerTile extends StatelessWidget {
  Data? model;

  GowerTile({this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(0x1f000000),
              offset: Offset(0, 3),
              blurRadius: 14,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              '${model!.growername} - (${model!.growercode})',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 16, color: textColor),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Text(
                    '${model!.caneareaha} - (${model!.growervillage})',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.grey),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          launch("tel://" + model!.phoneNumber!);
                        },
                        child: Container(
                          width: 56,
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0x20000000),
                                    blurRadius: 1,
                                    offset: Offset(0, 3))
                              ]),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.call,
                                color: Colors.white,
                                size: 12,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                'call'.tr,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              )
                            ],
                          ),
                        )),
                  ),
                )
              ],
            ),
            Container(
              child: Divider(),
              padding: EdgeInsets.only(left: 10, right: 10, top: 5),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 25, right: 25),
                    decoration: BoxDecoration(
                        color: model!.status == 'rejected'.tr
                            ? Colors.red
                            : model!.status == 'approved'.tr
                                ? primaryColor
                                : Colors.orangeAccent,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x20000000),
                              blurRadius: 1,
                              offset: Offset(0, 3))
                        ]),
                    child: Row(
                      children: [
                        Icon(
                          model!.status == 'rejected'.tr
                              ? Icons.thumb_down_alt_rounded
                              : model!.status == 'approved'.tr
                                  ? Icons.thumb_up
                                  : Icons.error_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(model!.status!,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                  if (model!.status != 'pending'.tr &&
                      model!.latlongvillage != '')
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 25, right: 25),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: textColor,
                            size: 24,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(model!.latlongvillage!,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        color: textColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
