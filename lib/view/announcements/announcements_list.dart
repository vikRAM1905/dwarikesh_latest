import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/components/photos_widget.dart';
import 'package:dwarikesh/controller/announcements_controller.dart';
import 'package:dwarikesh/model/announcements_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';

class AnnouncementsList extends StatelessWidget {
  final AnnouncementsController _controller =
      Get.put(AnnouncementsController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: Toolbar(
          title: 'important_message'.tr,
          leftsideIcon: backIcon,
          leftsideBtnPress: () {
            Get.back();
          },
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            GetBuilder<AnnouncementsController>(builder: (_controller) {
              return _controller.listData.length > 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _controller.listData.length,
                      itemBuilder: (context, index) {
                        var data = _controller.listData[index];
                        return dataTile(context, data);
                      })
                  : ErrorMessage(
                      errorCode: '403',
                    );
            })
          ]),
        ),
      ),
    );
  }

  Widget dataTile(BuildContext context, Data data) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(ROUTE_ANNOUNCEMENTS_DETAIL, arguments: data);
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: MediaQuery.of(context).size.width,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PhotoTile(
                      imageUrl: data.image,
                      width: double.infinity,
                      height: 150,
                      leftTopRadius: 8,
                      rightTopRadius: 8,
                      leftBottomRadius: 8,
                      rightBottomRadius: 8,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.title!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color: Colors.black,
                                            fontSize: TextUtils.commonTextSize,
                                            fontWeight:
                                                TextUtils.headerTextWeight),
                                  ),
                                  data.subtitle != ''
                                      ? SizedBox(height: 4.h)
                                      : Container(),
                                  data.subtitle != ''
                                      ? Container(
                                          child: Text(
                                            data.subtitle!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                    color: grey,
                                                    fontWeight: TextUtils
                                                        .mediumtTextWeight),
                                          ),
                                        )
                                      : Container(),
                                  SizedBox(height: 8.h),
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          plotIcon,
                                          color: primaryColor,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          '${data.date}',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontSize:
                                                      TextUtils.hintTextSize,
                                                  color: primaryColor,
                                                  fontWeight: TextUtils
                                                      .mediumtTextWeight),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnnouncementsTile extends StatelessWidget {
  Data? model;

  AnnouncementsTile({this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(ROUTE_ANNOUNCEMENTS_DETAIL, arguments: model);
      },
      child: Container(
        margin: EdgeInsets.all(5),
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
          children: <Widget>[
            Container(
              height: 125,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: PhotoTile(
                  imageUrl: model!.image,
                  width: double.infinity,
                  height: 100,
                  leftTopRadius: 8,
                  rightTopRadius: 8,
                  leftBottomRadius: 0,
                  rightBottomRadius: 0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5),
              child: Text(
                '${model!.title}',
                style: TextStyle(
                  color: primaryColorDark,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 1),
              child: Text(
                '${model!.subtitle}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
