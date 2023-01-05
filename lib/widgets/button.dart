import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonField extends StatelessWidget {
  final String? text;
  final VoidCallback? press;
  final Color? color;
  const ButtonField({
    Key? key,
    this.text,
    this.press,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color setColor = textColor;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: color,
            minimumSize: Size(88.r, 36.r),
            padding: EdgeInsets.symmetric(horizontal: 30.r, vertical: 15.r),
            shadowColor: setColor),
        child: Container(
          width: size.width / 1.6,
          margin: EdgeInsets.symmetric(horizontal: 20.r),
          child: Align(
            alignment: Alignment.center,
            child: FittedBox(
              child: Text(
                text!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ),
        ),
        onPressed: press);
  }
}
