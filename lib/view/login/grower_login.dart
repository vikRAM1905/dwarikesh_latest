import 'package:dwarikesh/components/section_title_only_widget.dart';
import 'package:dwarikesh/controller/grower_login_controller.dart';
import 'package:dwarikesh/controller/login_controller.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:dwarikesh/widgets/button.dart';
import 'package:dwarikesh/widgets/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dwarikesh/widgets/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GrowerLogin extends StatelessWidget {
  GrowerLogin({Key? key}) : super(key: key);

  GrowerLoginController growerLoginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GrowerLoginController>(
        init: growerLoginController,
        builder: (growerController) => Padding(
              padding: EdgeInsets.only(left: 15.r, right: 15.r),
              child: ListView(
                children: [
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey[100]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 12.0),
                            child: Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.precision_manufacturing,
                                  size: 24,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              child: DropdownButton(
                                hint: Text(
                                  growerController.currentFactoryName.value,
                                  style: TextStyle(
                                    fontSize: TextUtils.commonTextSize,
                                    color: growerController
                                                .currentFactoryName.value ==
                                            "${"factory_select".tr}"
                                        ? Colors.grey[400]
                                        : textColor,
                                    fontWeight: growerController
                                                .currentFactoryName.value ==
                                            "${"factory_select".tr}"
                                        ? TextUtils.headerTextWeight
                                        : TextUtils.normalTextWeight,
                                  ),
                                ),
                                isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 25,
                                underline: SizedBox(),
                                style: TextStyle(color: textColor),
                                items: growerController.factoryList.map(
                                  (val) {
                                    return DropdownMenuItem(
                                      value: val.name.toString(),
                                      child: Text(
                                        '${val.name.toString()}',
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: TextUtils.commonTextSize,
                                          fontWeight: TextUtils.titleTextWeight,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                  growerController.updateFactoryValue(
                                      val.toString(), context);
                                },
                              ),
                            ),
                          ))
                        ],
                      )),
                  SizedBox(
                    height: 15.h,
                  ),

                  RoundedInputField(
                    hintText: "mobile".tr,
                    icon: Icons.phone_android_sharp,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    maxLength: 10,
                    onChanged: (value) {},
                    moveCurser: TextInputAction.done,
                    controller: growerController.mobileTextController,
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  /*   RoundedInputField(
                    hintText: '${"village".tr} ${"code".tr}',
                    icon: Icons.pie_chart,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    onChanged: (value) {},
                    controller: growerController.villageCodeTextController,
                    moveCurser: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  RoundedInputField(
                    hintText: '${"grower".tr} ${"code".tr}',
                    icon: Icons.assignment_ind,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    onChanged: (value) {},
                    controller: growerController.gowerCodeTextController,
                    moveCurser: TextInputAction.done,

                  ),*/

                  SizedBox(
                    height: 46.h,
                  ),

                  Row(children: [
                    InkWell(
                      onTap: () {
                        if (growerLoginController.acceptPrivacy.value == 1)
                          growerLoginController.acceptPrivacy.value = 0;
                        else
                          growerLoginController.acceptPrivacy.value = 1;
                        growerLoginController.update();
                      },
                      child: Icon(
                        growerLoginController.acceptPrivacy.value == 1
                            ? checkBoxIcon
                            : checkBoxBlankIcon,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                        child: GestureDetector(
                      onTap: () {
                        Get.toNamed(ROUTE_TERMS_AND_CONDITION);
                      },
                      child: Text.rich(
                        TextSpan(
                          text: 'by_checking_you_agree_to_our'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(height: 1.5),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'terms_conditions_splash'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: textColor,
                                      fontWeight: TextUtils.titleTextWeight,
                                      decoration: TextDecoration.underline,
                                    )),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    )),
                  ]),
                  SizedBox(
                    height: 24.h,
                  ),
                  (growerLoginController.isLoading == true)
                      ? Container(
                          height: 48.h,
                          width: 48.h,
                          child: Progressbar(),
                        )
                      : SizedBox(
                          width: double.infinity,
                          child: ButtonField(
                            text: 'login'.tr,
                            color:
                                growerLoginController.acceptPrivacy.value == 1
                                    ? primaryColor
                                    : Colors.grey,
                            press: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (growerLoginController.acceptPrivacy.value ==
                                  1) growerLoginController.gowerApiLogin();
                            },
                          ),
                        ),
                  SizedBox(
                    height: 24.h,
                  ),
                  // changeLanguage(context),

                  //  submitButton(context)
                ],
              ),
            ));
  }
}

Widget changeLanguage(BuildContext contex) {
  GrowerLoginController growerLoginController = Get.find();
  return GetBuilder<GrowerLoginController>(
    builder: (value) => Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        InkWell(
          onTap: () {
            print('On Tap CLICK CHANGE LANGUAGE ENGLISH');
            value.updateLanguage('en');
            value.update();
          },
          child: Text(
            'English',
            style: TextStyle(
              color: value.languageMode == '1' ? primaryColor : unselectedColor,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: () {
            print('On Tap CLICK CHANGE LANGUAGE HINDI');
            value.updateLanguage('hi');
            value.update();
          },
          child: Text(
            'हिंदी',
            style: TextStyle(
              color: value.languageMode == "2" ? primaryColor : unselectedColor,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ],
    ),
  );
}
