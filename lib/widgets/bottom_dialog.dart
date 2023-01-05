import 'package:dwarikesh/components/normal_button.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:flutter/material.dart';

class BottomDialog extends StatefulWidget {
  Function()? yesBtn, noBtn;
  String? title, message;
  final IconData? rightSideIcons, leftSideIcons;
  String? rightSideBtn, leftSideBtn;

  BottomDialog({
    this.title,
    this.message,
    this.yesBtn,
    this.noBtn,
    this.rightSideIcons,
    this.leftSideIcons,
    this.rightSideBtn,
    this.leftSideBtn,
  });

  @override
  _BottomDialogState createState() => _BottomDialogState();
}

class _BottomDialogState extends State<BottomDialog> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Wrap(
      children: [
        Container(
          margin: EdgeInsets.only(top: 25, left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.title!,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.message!,
                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      width: size.width * 0.40,
                      child: NormalButton(
                          text: widget.leftSideBtn!,
                          icons: widget.leftSideIcons!,
                          textColor: Colors.white,
                          color: primaryColor,
                          press: widget.yesBtn!),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: size.height * 0.05,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      width: size.width * 0.40,
                      child: NormalButton(
                          text: widget.rightSideBtn!,
                          icons: widget.rightSideIcons!,
                          color: unselectedColor,
                          textColor: textColor,
                          press: widget.noBtn!),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
            ],
          ),
        )
      ],
    );
  }
}
