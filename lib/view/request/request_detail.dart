import 'package:dwarikesh/components/normal_button.dart';
import 'package:dwarikesh/components/photos_widget.dart';
import 'package:dwarikesh/components/reply_tile.dart';
import 'package:dwarikesh/components/section_title_only_widget.dart';
import 'package:dwarikesh/components/transparent_text_form_wo_icon_field.dart';
import 'package:dwarikesh/controller/reqest_list_controller.dart';
import 'package:dwarikesh/controller/request_add_controller.dart';
import 'package:dwarikesh/controller/request_detail_controller.dart';
import 'package:dwarikesh/model/request_list_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/bottom_dialog.dart';
import 'package:dwarikesh/widgets/rounded_button.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart';

class RequestDetail extends StatelessWidget {
  final RequestDetailController requestDetailController =
      Get.put(RequestDetailController());
  Data model = Get.arguments;
  final requestListController = Get.put(RequestListController());

  @override
  Widget build(BuildContext context) {
    var userRole = Prefs.getString(ROLE_ID);
    TextStyle titleStyle = kTextStyleSubtitle1.copyWith(
      color: primaryColorDark,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    );
    TextStyle subValueStyle = kTextStyleSubtitle1.copyWith(
      color: primaryColorDark,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );
    TextStyle valueStyle = kTextStyleSubtitle1.copyWith(
      color: primaryColorDark,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: Toolbar(
          title: userRole == ZONAL_INCHARGE
              ? 'escalationDetails'.tr
              : '${'farmers_query'.tr}',
          leftsideIcon: backIcon,
          leftsideBtnPress: () {
            Get.back();
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(0),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        kColorPrimaryGradient2.withOpacity(0.7),
                        kColorPrimaryGradient1.withOpacity(0.7),
                      ],
                      stops: [0.0, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      // angle: 0,
                      // scale: undefined,
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
                      child: (userRole == GROWER)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: <Widget>[
                                    (model.reqimage!.length > 0)
                                        ? CirclePhotoTile(
                                            imageUrl:
                                                model.reqimage!.last.image,
                                            available: true,
                                          )
                                        : CirclePhotoTile(
                                            imageUrl:
                                                'assets/images/no_image_circle.png',
                                            available: false,
                                          ),
                                    Flexible(
                                        child: Container(
                                      margin: EdgeInsets.only(left: 10),
                                      width: size.width * .85,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${model.requesttype ?? ''}',
                                            overflow: TextOverflow.ellipsis,
                                            style: titleStyle,
                                          ),
                                          SizedBox(height: 5),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    '${"plot".tr} : ${model.canearea ?? '-'} ${LAND_CALCUALTED_TYPE.tr} (${model.village})',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: kTextStyleSubtitle1
                                                        .copyWith(
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        '${model.date ?? '-'}',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            kTextStyleSubtitle1
                                                                .copyWith(
                                                          color: Colors.grey,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Text(
                                    '${model.requesttype ?? ''}',
                                    overflow: TextOverflow.ellipsis,
                                    style: titleStyle,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Text(
                                    userRole != GROWER
                                        ? '${"name".tr} : ${model.growername ?? '-'} ( ${model.growercode ?? ''} )'
                                        : '${"name".tr} : ${model.growername ?? '-'}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: kTextStyleSubtitle1.copyWith(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '${"plot".tr}  : ${model.canearea ?? '-'} ${LAND_CALCUALTED_TYPE.tr} (${model.village})',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: kTextStyleSubtitle1.copyWith(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: GestureDetector(
                                              onTap: () {
                                                launch("tel://" +
                                                    model.growerphone!);
                                              },
                                              child: Container(
                                                width: 56,
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color:
                                                              Color(0x20000000),
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
                                                      'Call',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 10,
                ),
                child: Text(
                  "query".tr,
                  overflow: TextOverflow.ellipsis,
                  style: titleStyle,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 10,
                ),
                child: Text(
                  model.query!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 12,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 5,
              ),
              PhotosWidget(
                data: model,
              ),
              SizedBox(
                height: 50,
              ),
              model.response!.length > 0
                  ? Padding(
                      padding: EdgeInsets.only(
                        left: 25,
                        right: 10,
                      ),
                      child: Text(
                        "reply".tr,
                        overflow: TextOverflow.ellipsis,
                        style: titleStyle,
                      ))
                  : Container(),
              SizedBox(
                height: 5,
              ),
              model.response!.length > 0
                  ? QueryReplyTile(model, model.id.toString())
                  : Container(),
              model.response!.length > 0
                  ? SizedBox(
                      height: 5,
                    )
                  : SizedBox(),
              if (userRole != GROWER && model.response!.length == 0)
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x20000000),
                            blurRadius: 10,
                            offset: Offset(0, 7))
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: size.width * 0.35,
                            child: Text(
                              'comment'.tr + ' *',
                              style: titleStyle,
                            ),
                          ),
                          SizedBox(
                            width: size.height * 0.02,
                          ),
                          Container(
                            width: size.width * 0.45,
                            child: GetBuilder<RequestDetailController>(
                              builder: (controller) => Container(
                                alignment: Alignment.topRight,
                                child: ClipOval(
                                  child: Material(
                                    color: unselectedColor, // button color
                                    child: InkWell(
                                      splashColor: primaryLightColor,
                                      // inkwell color
                                      child: SizedBox(
                                          width: 56,
                                          height: 56,
                                          child: Icon(Icons.camera_alt_outlined,
                                              size: 24, color: primaryColor)),
                                      onTap: () {
                                        showModalBottomSheet<void>(
                                          context: context,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(20.0)),
                                          ),
                                          builder: (BuildContext context) {
                                            return BottomDialog(
                                                title: 'upload_picture'.tr,
                                                message:
                                                    "upload the image via camera or gallary"
                                                        .tr,
                                                rightSideIcons:
                                                    Icons.photo_album,
                                                rightSideBtn: 'album'.tr,
                                                leftSideIcons:
                                                    Icons.photo_camera,
                                                leftSideBtn: 'camera'.tr,
                                                yesBtn: () async {
                                                  Get.back();
                                                  await controller.getImage(
                                                      ImageSource.camera);
                                                },
                                                noBtn: () async {
                                                  controller.getImage(
                                                      ImageSource.gallery);
                                                  Get.back();
                                                });
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (requestListController.suggestionListData.length > 0)
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            'auto_suggestion'.tr + '',
                            style: titleStyle.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                        ),
                      if (requestListController.suggestionListData.length > 0)
                        Container(
                          height: 150,
                          margin: EdgeInsets.all(15),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                requestListController.suggestionListData.length,
                            itemBuilder: (context, index) {
                              var data = requestListController
                                  .suggestionListData[index];
                              return InkWell(
                                onTap: () {
                                  requestDetailController
                                          .commentTextController!.text =
                                      _parseHtmlString(data.bcm_answer!);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        kColorPrimaryGradient2.withOpacity(0.7),
                                        kColorPrimaryGradient1.withOpacity(0.7),
                                      ],
                                      stops: [0.0, 1.0],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      // angle: 0,
                                      // scale: undefined,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  margin: EdgeInsets.all(3.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('${index + 1}.'),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Flexible(
                                        child: SectionTitleOnlyWidget(
                                          title: data.bcm_answer,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: TransparentTextFormWOIconField(
                          hintText: '',
                          controller:
                              requestDetailController.commentTextController,
                          maxlines: 5,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GetBuilder<RequestDetailController>(
                        builder: (controller) => controller.image_arr.length ==
                                    null ||
                                controller.image_arr.isEmpty
                            ? Container()
                            : GridView.count(
                                crossAxisCount: 3,
                                shrinkWrap: true,
                                children: List.generate(
                                    controller.image_arr.length, (index) {
                                  var image = controller.image_arr[index];
                                  return Container(
                                    margin: EdgeInsets.all(3),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 170,
                                          height: 100,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.file(
                                              image,
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                              padding: EdgeInsets.all(4),
                                              child: ClipOval(
                                                child: Material(
                                                  color: unselectedBtnColor,
                                                  // button color
                                                  child: InkWell(
                                                    splashColor:
                                                        deActiveIconColor,
                                                    // inkwell color
                                                    child: SizedBox(
                                                        width: 24,
                                                        height: 24,
                                                        child: Icon(
                                                            Icons
                                                                .delete_outlined,
                                                            size: 16,
                                                            color: Color(
                                                                0xFFD32F2F))),
                                                    onTap: () {
                                                      controller
                                                          .removeImage(index);
                                                    },
                                                  ),
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                              ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      if ('Factory official visit' == model.requesttype)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GetBuilder<RequestDetailController>(
                              builder: (controller) => Checkbox(
                                checkColor: Colors.white,
                                activeColor: primaryColor,
                                value: controller.visitCheck.value,
                                onChanged: (var value) {
                                  controller.updateCurrentVisit(value);
                                },
                              ),
                            ),
                            Container(
                              child: Text(
                                '${model.growername ?? '-'} Plot have been visited',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: NormalButton(
                                text: 'resolve'.tr,
                                textColor: Colors.white,
                                icons: Icons.send_rounded,
                                color: primaryColor,
                                press: () {
                                  if ('Factory official visit' ==
                                      model.requesttype)
                                    requestDetailController.feedbackValidation(
                                        model.id.toString(),
                                        '4',
                                        '',
                                        requestDetailController.visitCheck.value
                                            .toString());
                                  else
                                    requestDetailController.feedbackValidation(
                                        model.id.toString(), '4', '', '');
                                },
                              ),
                            ),
                            SizedBox(
                              width: size.height * 0.02,
                            ),
                            if (userRole != ZONAL_INCHARGE)
                              Expanded(
                                child: NormalButton(
                                  text: 'escalate'.tr,
                                  icons: Icons.festival,
                                  color: unselectedColor,
                                  textColor: textColor,
                                  press: () {
                                    if ('Factory official visit' ==
                                        model.requesttype)
                                      requestDetailController
                                          .feedbackValidation(
                                              model.id.toString(),
                                              '3',
                                              '',
                                              requestDetailController
                                                  .visitCheck.value
                                                  .toString());
                                    else
                                      requestDetailController
                                          .feedbackValidation(
                                              model.id.toString(), '3', '', '');
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }
}
