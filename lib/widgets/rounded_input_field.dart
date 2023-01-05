import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/textUtils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final String Function(String)? validator;
  final int? maxLines, maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? moveCurser;

  const RoundedInputField(
      {Key? key,
      this.hintText,
      this.icon,
      this.onChanged,
      this.controller,
      this.validator,
      this.maxLines,
      this.keyboardType,
      this.maxLength,
      this.moveCurser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      keyboardType: keyboardType,
      cursorColor: primaryColor,
      decoration: InputDecoration(
        fillColor: Colors.white,
        counterText: "",
        prefixIcon: Icon(
          icon,
          color: primaryColor,
        ),
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: getLanguage() == "1" ? TextUtils.commonTextSize : 13.sp,
          color: Colors.grey[400],
          fontWeight: getLanguage() == "1"
              ? TextUtils.titleTextWeight
              : TextUtils.titleTextWeight,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.r)),
          borderSide: BorderSide(width: 1.r, color: primaryColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(
            color: primaryColor,
            width: 1.r,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(width: 1.r, color: Colors.grey[100]!),
        ),
      ),
      style: TextStyle(
        fontSize: TextUtils.commonTextSize,
        color: textColor,
        fontWeight: TextUtils.normalTextWeight,
      ),
      textInputAction: moveCurser,

      // validator: (value) => value.trim().isEmpty ? 'Email required' : null,
    );
  }
}
