import 'package:dwarikesh/components/photos_widget.dart';
import 'package:dwarikesh/model/request_list_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import '../utils/constant.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class RequestListTile extends StatelessWidget {
  var model = Data();
  Function()? onPress;

  RequestListTile({required this.model, this.onPress});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String userRole = Prefs.getString(ROLE_ID);

    return GestureDetector(
      onTap: onPress,
      child: model.overallstatus != 0
          ? Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x20000000),
                        blurRadius: 10,
                        offset: Offset(0, 7))
                  ]),
              child: Container(
                width: MediaQuery.of(context).size.width,
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
                      children: <Widget>[
                        (model.reqimage!.length > 0)
                            ? CirclePhotoTile(
                                imageUrl: model.reqimage!.last.image,
                                available: true,
                              )
                            : CirclePhotoTile(
                                imageUrl: 'assets/images/no_image_circle.png',
                                available: false,
                              ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            width: size.width * .85,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (userRole == GROWER)
                                      ? '${model.requesttype ?? '-'}'
                                      : '${model.growername ?? '-'}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: kTextStyleSubtitle1.copyWith(
                                    color: textColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Sub : ${model.subrequesttype ?? '-'}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: kTextStyleSubtitle1.copyWith(
                                    color: textColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 5),
                        child: Divider()),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: RichText(
                                    text: TextSpan(
                                      text: '${"village".tr} : ',
                                      style: kTextStyleSubtitle1.copyWith(
                                        color: textColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '${model.village}',
                                          style: kTextStyleSubtitle1.copyWith(
                                            color: textColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '${model.readstatus == 1 ? 'resolved'.tr : 'open'.tr ?? '-'}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: kTextStyleSubtitle1.copyWith(
                                        color: primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            (userRole == GROWER)
                                ? '${model.startdate}'
                                : '${model.date ?? '-'}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: kTextStyleSubtitle1.copyWith(
                              color: textColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Q : ',
                              style: kTextStyleSubtitle1.copyWith(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${model.query ?? '-'}',
                                  style: kTextStyleSubtitle1.copyWith(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
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
                    children: <Widget>[
                      (model.reqimage!.length > 0)
                          ? CirclePhotoTile(
                              imageUrl: model.reqimage!.last.image,
                              available: true,
                            )
                          : CirclePhotoTile(
                              imageUrl: 'assets/images/no_image_circle.png',
                              available: false,
                            ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          width: size.width * .85,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (userRole == GROWER)
                                    ? '${model.requesttype ?? '-'}'
                                    : '${model.growername ?? '-'}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: kTextStyleSubtitle1.copyWith(
                                  color: textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Sub : ${model.subrequesttype ?? '-'}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: kTextStyleSubtitle1.copyWith(
                                  color: textColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 5),
                      child: Divider()),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: RichText(
                                  text: TextSpan(
                                    text: '${"village".tr} : ',
                                    style: kTextStyleSubtitle1.copyWith(
                                      color: textColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '${model.village}',
                                        style: kTextStyleSubtitle1.copyWith(
                                          color: textColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '${model.readstatus == 1 ? 'resolved'.tr : 'open'.tr ?? '-'}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: kTextStyleSubtitle1.copyWith(
                                      color: primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          (userRole == GROWER)
                              ? '${model.startdate}'
                              : '${model.date ?? '-'}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: kTextStyleSubtitle1.copyWith(
                            color: textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Q : ',
                            style: kTextStyleSubtitle1.copyWith(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${model.query ?? '-'}',
                                style: kTextStyleSubtitle1.copyWith(
                                  color: textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
