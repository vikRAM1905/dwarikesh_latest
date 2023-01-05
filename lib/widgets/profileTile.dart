import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTile extends StatelessWidget {
  String? title, message, phoneNumAvailable;
  Function()? onclickFunction;

  ProfileTile(
      {this.title, this.message, this.onclickFunction, this.phoneNumAvailable});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: titleMessage(context, title!, message!),
        ),
        Spacer(),
        if (phoneNumAvailable == '1')
          Expanded(
              flex: 4,
              child: GestureDetector(
                  onTap: onclickFunction,
                  child: Container(
                    height: 46,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(56)),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x20000000),
                              blurRadius: 1,
                              offset: Offset(0, 3))
                        ]),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Icon(
                          Icons.call,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          '${'call'.tr}',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                      ],
                    ),
                  ))),
      ],
    );
  }

  Widget titleMessage(BuildContext context, String title, String message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: textColor,
                fontSize: TextUtils.commonTextSize,
                fontWeight: TextUtils.headerTextWeight)),
        SizedBox(
          height: 10.h,
        ),
        Text(message,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: TextUtils.hintTextSize,
                color: primaryColor,
                fontWeight: TextUtils.headerTextWeight)),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}

class CdoProfileTile extends StatelessWidget {
  String? title, message, phoneNumAvailable;
  Function()? onclickFunction;

  CdoProfileTile(
      {this.title, this.message, this.onclickFunction, this.phoneNumAvailable});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: titleMessage(context, title!, message!),
        ),
        Spacer(),
        if (phoneNumAvailable == '1')
          Expanded(
              flex: 4,
              child: GestureDetector(
                  onTap: onclickFunction,
                  child: Container(
                    height: 46,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(56)),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x20000000),
                              blurRadius: 1,
                              offset: Offset(0, 3))
                        ]),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Icon(
                          Icons.call,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          '${'call'.tr}',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                      ],
                    ),
                  ))),
      ],
    );
  }

  Widget titleMessage(BuildContext context, String title, String message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: textColor,
                fontSize: TextUtils.smallTextSize,
                fontWeight: TextUtils.titleTextWeight)),
        SizedBox(
          height: 10.h,
        ),
        Text(message,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: TextUtils.mediumTextSize,
                color: primaryColor,
                fontWeight: TextUtils.titleTextWeight)),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}

class MainProfileTile extends StatelessWidget {
  String? title, message, phoneNumAvailable;
  Function()? onclickFunction;

  MainProfileTile(
      {this.title, this.message, this.onclickFunction, this.phoneNumAvailable});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: white,
                  fontSize: TextUtils.smallTextSize,
                  fontWeight: TextUtils.normalTextWeight,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                message!,
                style: TextStyle(
                  color: white,
                  fontSize: TextUtils.mediumTextSize,
                  fontWeight: TextUtils.titleTextWeight,
                ),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
        if (phoneNumAvailable == '1')
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: onclickFunction,
                  child: Container(
                    width: 56,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
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
                          '${'call'.tr}',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        )
                      ],
                    ),
                  )),
            ),
          )
      ],
    );
  }
}

class centerProfileTile extends StatelessWidget {
  String? title, message, phoneNumAvailable;
  Function()? onclickFunction;

  centerProfileTile(
      {this.title, this.message, this.onclickFunction, this.phoneNumAvailable});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textColor,
                  fontSize: TextUtils.smallTextSize,
                  fontWeight: TextUtils.titleTextWeight,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                message!,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: TextUtils.mediumTextSize,
                  fontWeight: TextUtils.titleTextWeight,
                ),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
        if (phoneNumAvailable == '1')
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: onclickFunction,
                  child: Container(
                    width: 56,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
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
                          '${'call'.tr}',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        )
                      ],
                    ),
                  )),
            ),
          )
      ],
    );
  }
}

class DosageTile extends StatelessWidget {
  String? title, message, phoneNumAvailable;
  Function()? onclickFunction;

  DosageTile(
      {this.title, this.message, this.onclickFunction, this.phoneNumAvailable});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textColor,
                  fontSize: TextUtils.smallTextSize,
                  fontWeight: TextUtils.normalTextWeight,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                message!,
                style: TextStyle(
                  color: textColor,
                  fontSize: TextUtils.mediumTextSize,
                  fontWeight: TextUtils.titleTextWeight,
                ),
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
        if (phoneNumAvailable == '1')
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: onclickFunction,
                  child: Container(
                    width: 56,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
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
                          '${'call'.tr}',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        )
                      ],
                    ),
                  )),
            ),
          )
      ],
    );
  }
}
