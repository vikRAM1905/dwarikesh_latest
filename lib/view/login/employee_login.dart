import 'package:dwarikesh/controller/emp_login_controller.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:dwarikesh/widgets/button.dart';
import 'package:dwarikesh/widgets/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmployeeLogin extends StatelessWidget {
  EmployeeLogin({Key? key}) : super(key: key);

  EmployeeLoginController employeeLoginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmployeeLoginController>(
        init: employeeLoginController,
        builder: (empController) => Padding(
              padding: EdgeInsets.only(left: 15.r, right: 15.r),
              child: ListView(
                children: [
                  RoundedInputField(
                    hintText: "mobile".tr,
                    icon: Icons.phone_android_sharp,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    maxLength: 10,
                    onChanged: (value) {},
                    moveCurser: TextInputAction.next,
                    controller: empController.empmobileTextController,
                  ),
                  SizedBox(
                    height: 18,
                  ),

                  RoundedInputField(
                    hintText: '${"employee".tr} ${"code".tr}',
                    icon: Icons.assignment_ind,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    onChanged: (value) {},
                    controller: empController.empCodeTextController,
                    moveCurser: TextInputAction.done,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),

                  SizedBox(
                    height: 24.h,
                  ),

                  Row(children: [
                    InkWell(
                      onTap: () {
                        if (employeeLoginController.acceptPrivacy.value == 1)
                          employeeLoginController.acceptPrivacy.value = 0;
                        else
                          employeeLoginController.acceptPrivacy.value = 1;
                        employeeLoginController.update();
                      },
                      child: Icon(
                        employeeLoginController.acceptPrivacy.value == 1
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

                  (employeeLoginController.isLoading == true)
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
                                employeeLoginController.acceptPrivacy.value == 1
                                    ? primaryColor
                                    : Colors.grey,
                            press: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (empController.acceptPrivacy.value == 1)
                                empController.employeeApiLogin();
                            },
                          ),
                        ),
                  SizedBox(
                    height: 24.h,
                  ),
                  //  language(context),

                  //  submitButton(context)
                ],
              ),
            ));
  }
}
