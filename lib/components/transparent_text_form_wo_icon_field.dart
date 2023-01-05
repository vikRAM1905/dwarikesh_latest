import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:flutter/material.dart';

class TransparentTextFormWOIconField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool? obscureText;
  final int? maxlines;
  final TextInputType? textInputType;

  const TransparentTextFormWOIconField({
    Key? key,
    this.controller,
    this.validator,
    @required this.hintText,
    this.obscureText,
    this.textInputType,
    this.maxlines,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final kTextStyle = TextStyle(
      color: primaryColor,
      fontSize: TextUtils.commonTextSize,
      fontWeight: TextUtils.titleTextWeight,
      fontStyle: FontStyle.normal,
    );
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: primaryColorDark.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: maxlines ?? 1,
        obscureText: obscureText ?? false,
        keyboardType: textInputType ?? TextInputType.text,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: kTextStyle,
        ),
        style: kTextStyle,
      ),
    );
  }
}
