import 'dart:ui';

import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  String? imageUrl;

  AppBarWidget({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
//brightness: Brightness.light,
        ),
      ),
      child: SliverAppBar(
        expandedHeight: 303,
        floating: false,
        pinned: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: primaryColor,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            height: 303,
            child: Stack(
              children: <Widget>[
                Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
