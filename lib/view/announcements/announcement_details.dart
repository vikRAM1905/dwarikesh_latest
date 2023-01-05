import 'package:dwarikesh/components/app_bar_widget.dart';
import 'package:dwarikesh/components/photos_widget.dart';
import 'package:dwarikesh/components/section_title_only_widget.dart';
import 'package:dwarikesh/model/announcements_model.dart';
import 'package:dwarikesh/model/info_center_model.dart' as infoModel;
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/view/infocenter/info_center_detail.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnnouncementDetail extends StatelessWidget {
  Data model = Get.arguments;

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
        body: ListView(
          padding: EdgeInsets.all(15.r),
          children: <Widget>[
            model.image != null && model.image != ''
                ? InkWell(
                    onTap: () {
                      List<infoModel.Picture> picture_arr = [
                        infoModel.Picture(image: model.image, title: '')
                      ];

                      Get.toNamed(ROUTE_IMAGE_VIEW, arguments: picture_arr);
                    },
                    child: PhotoTile(
                      imageUrl: model.image,
                      width: double.infinity,
                      height: 150,
                      leftTopRadius: 8,
                      rightTopRadius: 8,
                      leftBottomRadius: 8,
                      rightBottomRadius: 8,
                    ),
                  )
                : SizedBox(),
            SizedBox(
              height: 10.h,
            ),
            headingTile(context, model.title!, primaryColor),
            SizedBox(
              height: 8.h,
            ),
            titleMsgTile(context, "${"title".tr} : ", model.title!),
            SizedBox(
              height: 8.h,
            ),
            titleMsgTile(context, "${"language".tr} : ",
                getLanguage() == "1" ? "English" : "Hindi"),
            model.description != null && model.description != ''
                ? headingTile(context, "${"description".tr}", Colors.black)
                : SizedBox(),
            model.description != null && model.description != ''
                ? SectionTitleOnlyWidget(
                    title: model.description,
                  )
                : Container(),
            model.videoUrl != null && model.videoUrl != ''
                ? headingTile(context, "${"video".tr}", Colors.black)
                : SizedBox(),
            model.videoUrl != null && model.videoUrl != ''
                ? InkWell(
                    onTap: () {
                      _launchYoutubeVideo(model.videoUrl!);
                    },
                    child: Container(
                        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                        child: Text(
                          model.videoUrl!,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.blue,
                                    fontSize: TextUtils.hintTextSize,
                                    fontWeight: TextUtils.headerTextWeight,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.blue,
                                  ),
                        )),
                  )
                : SizedBox(),
            model.pdf != null && model.pdf != ''
                ? headingTile(context, "${"document".tr}", Colors.black)
                : SizedBox(),
            model.pdf != null && model.pdf != ''
                ? InkWell(
                    onTap: () {
                      _launchYoutubeVideo(model.pdf!);
                    },
                    child: Container(
                        height: 78.h,
                        width: 56.w,
                        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            pdfFile,
                            fit: BoxFit.contain,
                          ),
                        )),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}

Widget headingTile(BuildContext context, String title, Color color) {
  return Container(
    margin: EdgeInsets.only(top: 25.h, bottom: 10.h),
    child: Text(
      title,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: color,
          fontSize: TextUtils.commonTextSize,
          fontWeight: TextUtils.headerTextWeight),
    ),
  );
}

Widget titleMsgTile(BuildContext context, String title, String message) {
  return Row(
    children: [
      Text(
        title,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Colors.black,
            fontSize: TextUtils.hintTextSize,
            fontWeight: TextUtils.headerTextWeight),
      ),
      Text(
        message,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Colors.black,
            fontSize: TextUtils.hintTextSize,
            fontWeight: TextUtils.normalTextWeight),
      )
    ],
  );
}

Future<void> _launchYoutubeVideo(String _youtubeUrl) async {
  if (_youtubeUrl != null && _youtubeUrl.isNotEmpty) {
    await launch(
      _youtubeUrl,
      forceSafariVC: false,
      universalLinksOnly: false,
    );
  }
}
