import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;

  final ValueChanged<String>? onChanged;
  final String? Function(String)? validator;
  final int? maxLines, maxLength;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final bool? editable;
  final IconData? leftIcon, rightIcon;
  final TextInputAction? moveCurser;

  const InputField(
      {Key? key,
      this.hintText,
      this.editable,
      this.onChanged,
      this.controller,
      this.validator,
      this.maxLines,
      this.keyboardType,
      this.maxLength,
      this.focusNode,
      this.leftIcon,
      this.rightIcon,
      this.moveCurser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: keyboardType,
      enabled: editable,
      cursorColor: primaryColor,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
        fillColor: primaryColorDark.withOpacity(0.08),
        counterText: "",
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: TextUtils.hintTextSize,
            fontWeight: FontWeight.w400,
            color: Colors.grey),
      ),
      style:
          Theme.of(context).textTheme.bodyText1!.copyWith(color: primaryColor),
      textInputAction: moveCurser,

      // validator: (value) => value.trim().isEmpty ? 'Email required' : null,
    );
  }
}
