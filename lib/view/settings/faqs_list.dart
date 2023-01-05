import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/controller/faq_controller.dart';
import 'package:dwarikesh/model/faq_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FAQsList extends StatelessWidget {
  final _controller = Get.put(FAQsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: Toolbar(
          title: 'faq'.tr,
          leftsideIcon: backIcon,
          leftsideBtnPress: () {
            Get.back();
          },
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            GetBuilder<FAQsController>(builder: (controller) {
              if (_controller.responseCode == '200')
                return _controller.resListData.length > 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: _controller.resListData.length,
                        itemBuilder: (context, index) {
                          // ignore: missing_return
                          var data = _controller.resListData[index];
                          var pos = ++index;
                          return FaqTile(context, data, pos.toString());
                        })
                    : ErrorMessage(
                        errorCode: '403',
                      );
              else if (_controller.responseCode == '404')
                return ErrorMessage(
                  errorCode: '404',
                );
              else if (_controller.responseCode == '500')
                return ErrorMessage(
                  errorCode: '500',
                );
              else
                return ErrorMessage(
                  errorCode: '403',
                );
            })
          ]),
        ),
      ),
    );
  }

  Widget FaqTile(BuildContext context, Data model, String pos) {
    return GestureDetector(
        onTap: () {
          Get.toNamed(ROUTE_FAQ_DETAIL, arguments: model);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 20.r, right: 10.r, left: 15.r),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      child: Text(
                        '${pos}.',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: grey,
                            fontSize: TextUtils.hintTextSize,
                            fontWeight: TextUtils.headerTextWeight),
                      ),
                      padding: const EdgeInsets.only(right: 15),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.question!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.black,
                                    fontSize: TextUtils.commonTextSize,
                                    fontWeight: TextUtils.mediumtTextWeight),
                          ),
                        ],
                      ),
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
              Container(
                margin: EdgeInsets.only(left: 25.r, right: 25.r, top: 25.r),
                child: Divider(),
              )
            ],
          ),
        ));
  }
}
