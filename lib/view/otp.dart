import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';
import 'package:dwarikesh/controller/dashboard_controller.dart';
import 'package:dwarikesh/controller/login_controller.dart';
import 'package:dwarikesh/controller/otp_controller.dart';
import 'package:dwarikesh/model/login_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/local_storgae.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:dwarikesh/widgets/button.dart';
import 'package:dwarikesh/widgets/rounded_button.dart';
import 'package:dwarikesh/widgets/rounded_input_field.dart';
import 'package:dwarikesh/widgets/snackbar_message.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: [
          logoimage(context, size),
          SizedBox(
            height: 25.r,
          ),
          phoneTitle(context),
          SizedBox(
            height: 15.r,
          ),
          subTitle(context),
          SizedBox(
            height: 35.r,
          ),
          GetBuilder<OtpController>(
            builder: (controller) => Container(
              padding: EdgeInsets.only(
                  top: 35.r, right: 25.r, left: 25.r, bottom: 10.r),
              child: RoundedInputField(
                hintText: '${"input_OTP".tr}',
                icon: Icons.password,
                keyboardType: TextInputType.number,
                maxLines: 1,
                maxLength: 6,
                onChanged: (value) {},
                controller: controller.firstTextController,
                moveCurser: TextInputAction.done,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 25.r),
            child: resendText(context),
          ),
          SizedBox(
            height: 25.r,
          ),
          GetBuilder<OtpController>(
            builder: (controller) => Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  top: 15.r, right: 25.r, left: 25.r, bottom: 10.r),
              child: ButtonField(
                text: 'verify'.tr,
                color: primaryColor,
                press: () {
                  controller.verifyCode();
                },
              ),
            ),
          ),
        ],
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
        "${Prefs.getString(ROUTE_OTP_TITLE)}",
        style: Theme.of(context).textTheme.headline6!.copyWith(
              color: primaryColor,
              fontSize: TextUtils.mediumTextSize,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget subTitle(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        "${Prefs.getString(ROUTE_OTP_MSG)}",
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.grey,
              fontSize: TextUtils.commonTextSize,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget resendText(BuildContext context) {
    return GetBuilder<OtpController>(
        builder: (otpController) => GestureDetector(
              onTap: () {
                if (otpController.timerText == "00: 00") {
                  otpController.timerMaxSeconds = 120;
                  otpController.startTimeout();
                }
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  child: Text(
                    otpController.timerText != "00: 00"
                        ? otpController.timerText
                        : "Resend OTP",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: primaryColor,
                        fontWeight: TextUtils.normalTextWeight,
                        fontSize: 16.sp),
                  ),
                ),
              ),
            ));
  }
}

class OtpEditText extends StatelessWidget {
  TextEditingController? textcontroller;
  final ValueChanged<String>? onChanged;
  final bool? editable;
  OtpEditText({this.textcontroller, this.onChanged, this.editable});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(
      builder: (controller) => TextFormField(
        controller: textcontroller,
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        cursorColor: Colors.transparent,
        autofocus: true,
        onChanged: onChanged,
        showCursor: false,
        readOnly: false,
        enabled: editable,
        enableInteractiveSelection: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: textField,
          hintText: '*',
          counterText: "",
          isDense: true,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(4.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textField),
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(color: primaryColor, fontWeight: FontWeight.bold),

        // validator: (value) => value.trim().isEmpty ? 'Email required' : null,
      ),
    );
  }
}
