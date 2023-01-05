import 'package:dwarikesh/components/photos_widget.dart';
import 'package:dwarikesh/components/section_title_only_widget.dart';
import 'package:dwarikesh/components/transparent_text_form_wo_icon_field.dart';
import 'package:dwarikesh/controller/reqest_list_controller.dart';
import 'package:dwarikesh/controller/request_detail_controller.dart';
import 'package:dwarikesh/model/request_list_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/bottom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart';
import 'normal_button.dart';

class QueryReplyTile extends StatelessWidget {
  Data model;
  String requestid;

  QueryReplyTile(this.model, this.requestid);

  @override
  Widget build(BuildContext context) {
    if (model.response!.length > 0) {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: model.response!.length,
        itemBuilder: (context, index) {
          var data = model.response![index];
          return ReplyTile(
            growerName: model.growername,
            reqType: model.requesttype,
            requestID: requestid.toString(),
            responseID: data.resid.toString(),
            date: data.date,
            roll: data.role,
            name: data.resname,
            id: data.code,
            phone: data.resphone,
            answer: data.resmsg,
            resimage: data.resimage,
            thumbsBtn: data.thumbs,
            thumbsBtnunsatisfied: data.thumbsBtnunsatisfied,
            escalationsBtn: data.escalate,
            responseStatus: data.tagstatus,
          );
        },
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 22,
        ),
        child: Text(''),
      );
    }
  }
}

class ReplyTile extends StatelessWidget {
  String? reqType,
      name,
      roll,
      date,
      phone,
      answer,
      responseID,
      requestID,
      growerName,
      id;

  bool? thumbsBtn, thumbsBtnunsatisfied, escalationsBtn;
  int? responseStatus;
  List<Resimage>? resimage;
  final RequestDetailController requestDetailController =
      Get.put(RequestDetailController());

  final requestListController = Get.put(RequestListController());

  ReplyTile(
      {this.reqType,
      this.responseID,
      this.requestID,
      this.thumbsBtnunsatisfied,
      this.name,
      this.id,
      this.roll,
      this.date,
      this.phone,
      this.answer,
      this.thumbsBtn,
      this.responseStatus,
      this.escalationsBtn,
      this.resimage,
      this.growerName});

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = kTextStyleSubtitle1.copyWith(
      color: primaryColorDark,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    );
    Size size = MediaQuery.of(context).size;
    String userRole = Prefs.getString(ROLE_ID);
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
                color: Color(0x20000000), blurRadius: 1, offset: Offset(0, 3))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
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
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        'https://img.icons8.com/bubbles/2x/user-male.png'),
                    //NetworkImage
                    radius: 24,
                  ), //CircleAvatar
                  //CircleAvatar
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      {
                        launch("tel://" + phone!);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      width: size.width * .85,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: Text(
                                  userRole != GROWER
                                      ? '${name ?? ''} ( ${id} ) - ${roll == CFA ? 'cfa'.tr : roll == ZONAL_INCHARGE ? 'cdo'.tr : 'Zonal Incharge'} '
                                      : '${name ?? ''} - ${roll == CFA ? 'cfa'.tr : roll == ZONAL_INCHARGE ? 'cdo'.tr : 'Zonal Incharge'} ',
                                  style: kTextStyleSubtitle1.copyWith(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              responseStatus == 4
                                  ? Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'escalations'.tr,
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )
                                  : Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          responseStatus == 1
                                              ? Icons.thumb_up
                                              : responseStatus == 2
                                                  ? Icons.thumb_down
                                                  : null,
                                          color: responseStatus == 1
                                              ? Colors.green
                                              : responseStatus == 2
                                                  ? Colors.red
                                                  : Colors.transparent,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(height: 5),
                          GestureDetector(
                              onTap: () {
                                launch("tel://" + phone!);
                              },
                              child: Container(
                                width: 56,
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.green,
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
                                      'Call',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Text(
                '${date ?? ''}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: kTextStyleSubtitle1.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              )),
          SizedBox(
            height: 5,
          ),
          Padding(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Row(
                children: [
                  Icon(Icons.subdirectory_arrow_right),
                  Flexible(
                    child: Text(
                      '${answer}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 100,
                    ),
                  )
                ],
              )),
          resimage!.length > 0
              ? SizedBox(
                  height: 20,
                )
              : Container(),
          resimage!.length > 0
              ? Container(
                  height: 112,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      width: 15,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemCount: resimage!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var model = resimage![index];
                      return new GestureDetector(
                        child: PhotoTile(
                          imageUrl: model.image,
                          width: 170,
                          height: 100,
                          leftTopRadius: 8,
                          rightTopRadius: 8,
                          leftBottomRadius: 8,
                          rightBottomRadius: 8,
                        ),
                      );
                    },
                  ),
                )
              : Container(),
          SizedBox(
            height: 25,
          ),
          if (thumbsBtn == true && userRole == GROWER)
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: NormalButton(
                      text: 'satisfied'.tr,
                      textColor: Colors.white,
                      icons: Icons.thumb_up_alt_outlined,
                      color: primaryColor,
                      press: () {
                        requestDetailController.feedbackValidation(
                            requestID!, '1', responseID!, '');
                      },
                    ),
                  ),
                  SizedBox(
                    width: size.height * 0.02,
                  ),
                  if (thumbsBtnunsatisfied == true)
                    Expanded(
                      child: NormalButton(
                        text: 'unsatisfied'.tr,
                        icons: Icons.thumb_down,
                        color: unselectedColor,
                        textColor: textColor,
                        press: () {
                          requestDetailController.feedbackValidation(
                              requestID!, '2', responseID!, '');
                        },
                      ),
                    ),
                ],
              ),
            ),
          if (thumbsBtn == true && userRole == GROWER)
            SizedBox(
              height: 25,
            ),
          if (escalationsBtn == true && userRole != GROWER)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                                          rightSideIcons: Icons.photo_album,
                                          rightSideBtn: 'album'.tr,
                                          leftSideIcons: Icons.photo_camera,
                                          leftSideBtn: 'camera'.tr,
                                          yesBtn: () async {
                                            Get.back();
                                            await controller
                                                .getImage(ImageSource.camera);
                                          },
                                          noBtn: () async {
                                            controller
                                                .getImage(ImageSource.gallery);
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
                  height: 15,
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
                        var data =
                            requestListController.suggestionListData[index];
                        return InkWell(
                          onTap: () {
                            requestDetailController.commentTextController!
                                .text = _parseHtmlString(data.bcm_answer!);
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
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 10),
                  child: TransparentTextFormWOIconField(
                    hintText: '',
                    controller: requestDetailController.commentTextController,
                    maxlines: 10,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                GetBuilder<RequestDetailController>(
                  builder: (controller) => controller.image_arr.length ==
                              null ||
                          controller.image_arr.isEmpty
                      ? Container()
                      : GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          children: List.generate(controller.image_arr.length,
                              (index) {
                            var image = controller.image_arr[index];
                            return Container(
                              margin: EdgeInsets.all(3),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 170,
                                    height: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
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
                                            color:
                                                unselectedBtnColor, // button color
                                            child: InkWell(
                                              splashColor: deActiveIconColor,
                                              // inkwell color
                                              child: SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child: Icon(
                                                      Icons.delete_outlined,
                                                      size: 16,
                                                      color:
                                                          Color(0xFFD32F2F))),
                                              onTap: () {
                                                controller.removeImage(index);
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
                if ('Factory official visit' == reqType)
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
                          '${growerName ?? '-'} Plot have been visited',
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
                            if ('Factory official visit' == reqType)
                              requestDetailController.feedbackValidation(
                                  requestID!,
                                  '4',
                                  responseID!,
                                  requestDetailController.visitCheck.value
                                      .toString());
                            else
                              requestDetailController.feedbackValidation(
                                  requestID!, '4', responseID!, '');
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
                              if ('Factory official visit' == reqType)
                                requestDetailController.feedbackValidation(
                                    requestID!,
                                    '3',
                                    responseID!,
                                    requestDetailController.visitCheck.value
                                        .toString());
                              else
                                requestDetailController.feedbackValidation(
                                    requestID!, '3', responseID!, '');
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
        ],
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
