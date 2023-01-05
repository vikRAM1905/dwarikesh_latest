import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String? text;
  final Function? press;
  final Color? color, textColor;
  RoundedButton({
    Key? key,
    this.text,
    this.press,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 2,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () {},
        child: Text('Looks like a RaisedButton'),
      ),
    );
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );
}
