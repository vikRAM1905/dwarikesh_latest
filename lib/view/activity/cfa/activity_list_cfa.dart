import 'dart:convert';

import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/components/normal_button.dart';
import 'package:dwarikesh/components/photos_widget.dart';
import 'package:dwarikesh/controller/activity_list_cfa_controller.dart';
import 'package:dwarikesh/model/activity_list_cfa_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/snackbar_message.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityListCfa extends StatelessWidget {
  final ActivityListCfaController _controller =
      Get.put(ActivityListCfaController());

  @override
  Widget build(BuildContext context) {
    String userRole = Prefs.getString(ROLE_ID);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: new AppBar(
          title: Text(
            'activity_schedule'.tr,
            style: TextStyle(color: white),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Get.back(),
          ),
          actions: [
            Container(
              width: 56,
              child: GetBuilder<ActivityListCfaController>(
                  builder: (controller) => PopupMenuButton(
                        color: Colors.white,
                        itemBuilder: (context) => controller.filterListData.map(
                          (val) {
                            return PopupMenuItem(
                              value: val.village,
                              child: Text(
                                val.village.toString() ?? '',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            );
                          },
                        ).toList(),
                        onSelected: (value) async {
                          print(value);

                          controller.onSearchTextChanged(value.toString());

                          // Note You must create respective pages for navigation
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          child:
                              Icon(Icons.tune, size: 24, color: Colors.white),
                        ),
                      )),
            )
          ],
        ),
        floatingActionButton:
            GetBuilder<ActivityListCfaController>(builder: (controller) {
          return controller.tabPosition.value == 0 &&
                  controller.reqListData.length > 0
              ? FloatingActionButton.extended(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  label: Text("submit".tr),
                  onPressed: () async {
                    controller.apiSubmit();
                  },
                  icon: Icon(Icons.check_circle),
                )
              : Container();
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Obx(() => SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Row(
                    children: [
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
                                  'pending'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color:
                                              _controller.tabPosition.value == 0
                                                  ? Colors.black
                                                  : grey,
                                          fontSize: TextUtils.hintTextSize,
                                          fontWeight:
                                              _controller.tabPosition.value == 0
                                                  ? TextUtils.titleTextWeight
                                                  : TextUtils.normalTextWeight),
                                ),
                              ),
                              1: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  'approved'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color:
                                              _controller.tabPosition.value == 1
                                                  ? Colors.black
                                                  : grey,
                                          fontSize: TextUtils.hintTextSize,
                                          fontWeight:
                                              _controller.tabPosition.value == 1
                                                  ? TextUtils.titleTextWeight
                                                  : TextUtils.normalTextWeight),
                                ),
                              ),
                              2: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  'rejected'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color:
                                              _controller.tabPosition.value == 1
                                                  ? Colors.black
                                                  : grey,
                                          fontSize: TextUtils.hintTextSize,
                                          fontWeight:
                                              _controller.tabPosition.value == 1
                                                  ? TextUtils.titleTextWeight
                                                  : TextUtils.normalTextWeight),
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
                      ),
                    ],
                  ),
                ),
                if (_controller.responseCode == '200')
                  if (_controller.reqListData.length > 0)
                    if (_controller.searchListData.length > 0)
                      ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(bottom: 70),
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: _controller.searchListData.length,
                          itemBuilder: (context, index) {
                            var data = _controller.searchListData[index];
                            return _controller.tabPosition.value == 0 &&
                                    data.activitystatus == 0
                                ? searchSwipeData(model: data)
                                : _controller.tabPosition.value == 1 &&
                                        data.activitystatus == 1
                                    ? ActivityTile(data)
                                    : _controller.tabPosition.value == 2 &&
                                            data.activitystatus == 2
                                        ? ActivityTile(data)
                                        : Container();
                          })
                    else if (_controller.searchListData.length == 0 &&
                        _controller.filterAvailable.value == false)
                      ErrorMessage(
                        errorCode: '403',
                      )
                    else
                      ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(bottom: 70),
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: _controller.reqListData.length,
                          itemBuilder: (context, index) {
                            var data = _controller.reqListData[index];
                            return _controller.tabPosition.value == 0 &&
                                    data.activitystatus == 0
                                ? searchSwipeData(model: data)
                                : _controller.tabPosition.value == 1 &&
                                        data.activitystatus == 1
                                    ? ActivityTile(data)
                                    : _controller.tabPosition.value == 2 &&
                                            data.activitystatus == 2
                                        ? ActivityTile(data)
                                        : Container();
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
              ]),
            )),
      ),
    );
  }
}

class searchSwipeData extends StatefulWidget {
  Data? model;

  searchSwipeData({this.model});

  @override
  _searchSwipeDataState createState() => _searchSwipeDataState();
}

class _searchSwipeDataState extends State<searchSwipeData> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActivityListCfaController>(builder: (controller) {
      return Dismissible(
        key: Key(widget.model!.id.toString()),
        background: slideRightBackground(),
        secondaryBackground: slideLeftBackground(),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            final bool res = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text(
                        "${'are_you_sure_you_want_to_reject'.tr} ${widget.model!.activityname}?"),
                    actions: <Widget>[
                      ElevatedButton(
                        child: Text(
                          "cancel".tr,
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        child: Text(
                          "reject".tr,
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          setState(() {
                            widget.model!.set_status = '2';
                            controller.addStatusData(
                                widget.model!.id.toString(), '2');
                          });

                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
            return res;
          } else {
            setState(() {
              widget.model!.set_status = '1';
              controller.addStatusData(widget.model!.id.toString(), '1');
            });

            return false;
            // TODO: Navigate to edit page;
          }
        },
        child: InkWell(
          onTap: () {
            print(" clicked");
          },
          child: ActivityTile(widget.model!),
        ),
      );
    });
  }

  Widget slideRightBackground() {
    return Container(
      color: primaryColor,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              "approve".tr,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              "reject".tr,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}

class ActivityTile extends StatelessWidget {
  Data model;

  ActivityTile(this.model);

  @override
  Widget build(BuildContext context) {
    return model.saveStatus == '1'
        ? Container(
            width: double.infinity,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.green,
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
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Banner(
                    message: model.saveStatus == '2'
                        ? 'rejected'.tr
                        : model.saveStatus == '1'
                            ? 'approved'.tr
                            : '',
                    textStyle: TextStyle(
                      fontSize: 10,
                    ),
                    location: BannerLocation.topEnd,
                    color: model.saveStatus == '2'
                        ? Colors.red
                        : model.saveStatus == '1'
                            ? Colors.green
                            : Colors.white,
                    child: ActivityLable(
                        context,
                        model.growername!,
                        model.growerid!,
                        model.activityname!,
                        model.redostatus.toString(),
                        model.growervillage!,
                        model.caneareaha!,
                        model.activityseason!,
                        model.growercompletiondate!,
                        model.overduestatus!,
                        model.overduedays!,
                        model.growerphone!,
                        model.groweractivityimage!,
                        model.fullrewardpoints!))),
          )
        : model.saveStatus == '2'
            ? Container(
                width: double.infinity,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.red,
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
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: Banner(
                        message: model.saveStatus == '2'
                            ? 'rejected'.tr
                            : model.saveStatus == '1'
                                ? 'approved'.tr
                                : '',
                        textStyle: TextStyle(
                          fontSize: 10,
                        ),
                        location: BannerLocation.topEnd,
                        color: model.saveStatus == '2'
                            ? Colors.red
                            : model.saveStatus == '1'
                                ? Colors.green
                                : Colors.white,
                        child: ActivityLable(
                            context,
                            model.growername!,
                            model.growerid!,
                            model.activityname!,
                            model.redostatus.toString(),
                            model.growervillage!,
                            model.caneareaha!,
                            model.activityseason!,
                            model.growercompletiondate!,
                            model.overduestatus!,
                            model.overduedays!,
                            model.growerphone!,
                            model.groweractivityimage!,
                            model.fullrewardpoints!))),
              )
            : ActivityLable(
                context,
                model.growername!,
                model.growerid!,
                model.activityname!,
                model.redostatus.toString(),
                model.growervillage!,
                model.caneareaha!,
                model.activitytype!,
                model.growercompletiondate!,
                model.overduestatus!,
                model.overduedays!,
                model.growerphone!,
                model.groweractivityimage!,
                model.fullrewardpoints!);
  }

  Widget ActivityLable(
      BuildContext context,
      String growerName,
      String growerID,
      String activity,
      String redo,
      String village,
      String area,
      String cropType,
      String completedDate,
      String overdueStatus,
      String overdude,
      String phone,
      List<Groweractivityimage> image,
      int reward_points) {
    return Container(
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
          Text(
            '${growerName} - [${growerID}]',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: textColor),
          ),
          SizedBox(
            height: 15,
          ),
          Text.rich(
            TextSpan(
              text: '${activity} ',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey),
              children: <TextSpan>[
                TextSpan(
                  text: redo != '1' ? ' (${redo} Times)' : '',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.redAccent),
                ),

                // can add more TextSpans here...
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'village'.tr,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${village}',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: textColor),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Expanded(
                  child: Wrap(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.emoji_events,
                    color: Colors.orange,
                    size: 20,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text('${'points'.tr} : ${reward_points.toString()}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ))
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'caneArea'.tr,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${area} ${'ha'.tr}',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: textColor),
                  ),
                ],
              )),
              Spacer(),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'date'.tr,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${completedDate}',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: textColor),
                  ),
                ],
              )),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'cropType'.tr,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${cropType}',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: textColor),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'over_due'.tr,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${overdueStatus == 'Overdue' ? overdude : '-'}',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.red),
                  ),
                ],
              )),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                height: 45,
                width: MediaQuery.of(context).size.width / 2.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(primaryColor)),
                    onPressed: () {
                      launch("tel://" + phone);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.call,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text("call".tr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                height: 45,
                width: MediaQuery.of(context).size.width / 2.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.grey[100]!)),
                    onPressed: () {
                      model.groweractivityimage!.length > 0
                          ? showImageDialog(context: context, imageUrl: image)
                          : snakbarMsg(
                              icon: Icons.photo,
                              title: 'No Image',
                              msg: 'Image not available ! ',
                              colors: Colors.white,
                              bgColor: Colors.redAccent);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.remove_red_eye_rounded,
                          color: textColor,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text("preview".tr,
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}

showImageDialog({BuildContext? context, imageUrl}) {
  showDialog(
    barrierDismissible: true,
    context: context!,
    builder: (context) {
      List<Groweractivityimage> image_arr = imageUrl;

      final List<Widget> imageSliders = image_arr
          .map((item) => Container(
                  child: Stack(
                children: <Widget>[
                  PhotoTile(
                    imageUrl: item.image,
                    width: 400,
                    height: 400,
                    leftTopRadius: 8,
                    rightTopRadius: 8,
                    leftBottomRadius: 8,
                    rightBottomRadius: 8,
                  ),
                  Positioned(
                    child: new IconButton(
                      icon: new Icon(Icons.cancel),
                      color: Colors.deepOrange,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    top: 0,
                    right: 0,
                  ),
                ],
              )))
          .toList();

      return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.transparent,
          // child: WaitCircularProgress(title: 'Please wait'),
          child: Container(
              child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 2,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(
                      seconds: 5,
                    ),
                    autoPlayAnimationDuration: Duration(
                      milliseconds: 500,
                    ),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: imageSliders)));
    },
  );
}
