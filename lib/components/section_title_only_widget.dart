import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class SectionTitleOnlyWidget extends StatelessWidget {
  final String? title;
  final EdgeInsetsGeometry? padding;

  const SectionTitleOnlyWidget({
    Key? key,
    @required this.title,
    this.padding,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Center(
        child: SingleChildScrollView(
            child: Html(
          data: title,
          style: {
            "body": Style(
                color: textColor,
                fontSize: FontSize(16.0),
                fontFamily: "assets/fonts/Inter-Regular.ttf"),
            "p": Style(
                color: textColor,
                fontSize: FontSize(16.0),
                fontFamily: "assets/fonts/Inter-Regular.ttf"),
            "h1": Style(
                color: textColor,
                fontSize: FontSize(17.0),
                fontFamily: "assets/fonts/Inter-Regular.ttf"),
            "h2": Style(
                color: textColor,
                fontSize: FontSize(18.0),
                fontFamily: "assets/fonts/Inter-Regular.ttf"),
            "h3": Style(
                color: textColor,
                fontSize: FontSize(19.0),
                fontFamily: "assets/fonts/Inter-Regular.ttf"),
            "h4": Style(
                color: textColor,
                fontSize: FontSize(20.0),
                fontFamily: "assets/fonts/Inter-Regular.ttf"),
            "h5": Style(
                color: textColor,
                fontSize: FontSize(21.0),
                fontFamily: "assets/fonts/Inter-Regular.ttf"),
            "h6": Style(
                color: textColor,
                fontSize: FontSize(22.0),
                fontFamily: "assets/fonts/Inter-Regular.ttf"),
          },
        )),
      ),
    );
  }
}
