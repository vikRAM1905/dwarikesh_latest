import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class Toolbar extends StatelessWidget implements PreferredSizeWidget {
  String? title;
  final IconData? leftsideIcon, rightsideIcon, rightsideIcon1;
  VoidCallback? leftsideBtnPress, rightsideBtnPress, rightsideBtnPress1;
  int? rightsideBtnAvil, rightsideBtnAvil1;
  final AppBar? appBar;
  Color? rightIconColor, rightIconColor1;

  Toolbar(
      {this.title,
      this.leftsideIcon,
      this.rightsideIcon,
      this.leftsideBtnPress,
      this.rightsideBtnPress,
      this.rightsideBtnPress1,
      this.rightsideBtnAvil1,
      this.rightIconColor1,
      this.rightsideBtnAvil,
      this.rightIconColor,
      this.appBar,
      this.rightsideIcon1});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      centerTitle: true,
      elevation: 0.0,
      iconTheme: new IconThemeData(
        color: Colors.white,
      ),
      title: Text(
        title!,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: Colors.white),
      ),
      leading: IconButton(
        onPressed: leftsideBtnPress,
        icon: Icon(
          leftsideIcon,
        ),
      ),
      actions: <Widget>[
        rightsideBtnAvil1 == 1
            ? GestureDetector(
                onTap: rightsideBtnPress1,
                child: Container(
                    margin: EdgeInsets.only(top: 1, right: 15),
                    child:
                        Icon(rightsideIcon1, size: 30, color: rightIconColor1)),
              )
            : Container(),
        rightsideBtnAvil == 1
            ? GestureDetector(
                onTap: rightsideBtnPress,
                child: Container(
                    margin: EdgeInsets.only(top: 1, right: 15),
                    child:
                        Icon(rightsideIcon, size: 30, color: rightIconColor)),
              )
            : Container(),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(56);
}
