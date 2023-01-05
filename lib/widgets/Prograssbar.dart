import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:flutter/material.dart';

class Progressbar extends StatelessWidget {
  final Widget? child;
  final bool? inAsyncCall;
  final double? opacity;
  final Color? color;
  final Animation<Color>? valueColor;

  Progressbar({
    Key? key,
    @required this.child,
    @required this.inAsyncCall,
    this.opacity = 0.1,
    this.color = Colors.white,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          new Opacity(
            opacity: opacity!,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          new Center(
              child: Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          )),
          new Center(
            child: new CircularProgressIndicator(
              strokeWidth: 3.0,
              valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
