import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:flutter/material.dart';

class NormalButton extends StatelessWidget {
  final String? text;
  final Function()? press;
  final IconData? icons;
  final Color? color, textColor;
  const NormalButton({
    Key? key,
    this.text,
    this.press,
    this.color,
    this.icons,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      width: size.width * 0.2,
      height: 45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(color!)),
          onPressed: press,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icons,
                color: textColor,
                size: 18,
              ),
              SizedBox(width: 5),
              Flexible(
                child: Text(text!,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w800)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
