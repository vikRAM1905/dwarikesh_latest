import 'dart:math';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:flutter/material.dart';

class PlatformTile extends StatelessWidget {
  String? imageUrl, title, id;
  final Color? startColor, endColor, shadowColor;

  PlatformTile(
      {this.imageUrl,
      this.title,
      this.id,
      this.startColor,
      this.endColor,
      this.shadowColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: new Stack(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(top: 55),
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [startColor!, endColor!]),
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(10.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: shadowColor!,
                  blurRadius: 10.0,
                  offset: new Offset(3.0, 10.0),
                ),
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.only(right: 5),
            alignment: FractionalOffset.topRight,
            child: new Image(
              image: new NetworkImage(imageUrl!),
              height: 110.0,
              width: 110.0,
            ),
          ),
          Positioned(
            bottom: 10.0,
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                title!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    fontSize: TextUtils.commonTextSize,
                    fontWeight: TextUtils.titleTextWeight,
                    color: whitetextColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
