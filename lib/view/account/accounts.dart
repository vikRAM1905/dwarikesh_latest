import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/components/photos_widget.dart';
import 'package:dwarikesh/controller/account_controller.dart';
import 'package:dwarikesh/model/account_list_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/view/login/login_form.dart';
import 'package:dwarikesh/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: GetBuilder<AccountController>(
            builder: (controller) => Container(
                margin: EdgeInsets.all(15.r),
                height: 48.h,
                child: ButtonField(
                  text: "switch_account".tr,
                  // ignore: unrelated_type_equality_checks
                  color: controller.submitEnable == true
                      ? primaryColor
                      : Colors.grey,
                  press: () {
                    // ignore: unrelated_type_equality_checks
                    if (controller.submitEnable == true) {
                      Prefs.setString(AUTH_CODE, "1");
                      Get.offAllNamed(ROUTE_HOME);
                    }
                  },
                )),
          ),
          elevation: 0,
        ),
        body: GetBuilder<AccountController>(
          init: AccountController(),
          builder: (controller) => Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                logoimage(context, size),
                SizedBox(
                  height: 25.r,
                ),
                phoneTitle(context),
                SizedBox(
                  height: 15.r,
                ),
                if (controller.responseCode.value == '200')
                  controller.menuListData.length > 0
                      ? Flexible(
                          child: Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.menuListData.length,
                              itemBuilder: (context, index) {
                                var data = controller.menuListData[index];
                                var count = index + 1;
                                return listTile(data, size);
                              }),
                        ))
                      : ErrorMessage(
                          errorCode: '403',
                        )
                else if (controller.responseCode == '404')
                  ErrorMessage(
                    errorCode: '404',
                  )
                else if (controller.responseCode == '500')
                  ErrorMessage(
                    errorCode: '500',
                  )
                else
                  ErrorMessage(
                    errorCode: '403',
                  ),
              ],
            ),
          ),
        ));
  }

  Widget listTile(Data model, Size size) {
    return GetBuilder<AccountController>(
        builder: (controller) => InkWell(
              onTap: () {
                controller.selectedAccountID(model);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[
                    CirclePhotoTile(
                      imageUrl: model.image,
                      available: true,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${model.name ?? '-'}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: kTextStyleSubtitle1.copyWith(
                                color: textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    ' ${'farmer_code'.tr} : ${model.code ?? '-'}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: kTextStyleSubtitle1.copyWith(
                                      color: textColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(
                        model.getPosition == true
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off_rounded,
                        color: primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  Widget logoimage(BuildContext context, Size size) {
    return Container(
      color: primaryColor,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(55.r),
          child: Image.asset(
            logoName,
            width: double.infinity,
            height: 75.h,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget phoneTitle(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        "account_list".tr,
        style: Theme.of(context).textTheme.headline6!.copyWith(
              color: primaryColor,
              fontSize: TextUtils.mediumTextSize,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
