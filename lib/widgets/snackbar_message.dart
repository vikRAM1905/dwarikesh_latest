import 'package:dwarikesh/utils/textUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackBar? snakbarMsg(
    {IconData? icon, var title, var msg, Color? bgColor, Color? colors}) {
  Get.snackbar(
    title, // title
    msg, // message
    icon: Icon(
      icon,
      color: colors,
      size: 28,
    ),
    shouldIconPulse: false,
    barBlur: 50,
    isDismissible: true,
    duration: Duration(seconds: 3),
    padding: EdgeInsets.all(10),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: bgColor,
    borderRadius: 10,
    titleText: Text(
      title,
      style: TextStyle(
          color: colors,
          fontSize: TextUtils.commonTextSize,
          fontWeight: TextUtils.headerTextWeight),
    ),
    messageText: Text(
      msg,
      style: TextStyle(color: colors),
    ),
  );
}

SnackBar? snakbarNotificationMsg(
    {var title,
    var msg,
    Color? bgColor,
    Color? titleColors,
    Color? messageColor}) {
  Get.snackbar(
    title, // title
    msg, // message
    icon: Image.asset(
      'assets/images/logo_only.png',
    ),
    shouldIconPulse: false,
    barBlur: 50,
    isDismissible: true,
    duration: Duration(seconds: 3),
    padding: EdgeInsets.all(20),
    snackPosition: SnackPosition.TOP,
    backgroundColor: bgColor,
    borderRadius: 10,
    titleText: Text(
      title,
      style: TextStyle(
          color: titleColors,
          fontSize: TextUtils.commonTextSize,
          fontWeight: TextUtils.headerTextWeight),
    ),
    messageText: Text(
      msg,
      style: TextStyle(color: messageColor),
    ),
  );
}
