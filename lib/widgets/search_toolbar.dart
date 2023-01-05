import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SearchToolbar extends StatelessWidget implements PreferredSizeWidget {
  String? title;
  final IconData? leftsideIcon, rightsideIcon;
  VoidCallback? leftsideBtnPress, rightsideBtnPress;
  int? rightsideBtnAvil;
  final AppBar? appBar;
  Color? rightIconColor;
  Widget? toolbarType;

  SearchToolbar(
      {this.title,
      this.leftsideIcon,
      this.rightsideIcon,
      this.leftsideBtnPress,
      this.rightsideBtnPress,
      this.rightsideBtnAvil,
      this.rightIconColor,
      this.appBar,
      this.toolbarType});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      centerTitle: true,
      elevation: 0.0,
      iconTheme: new IconThemeData(
        color: Colors.white,
      ),
      title: toolbarType,
      leading: IconButton(
        onPressed: leftsideBtnPress,
        icon: Icon(
          leftsideIcon,
        ),
      ),
      actions: <Widget>[
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
