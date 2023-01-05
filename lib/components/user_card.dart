
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



Widget UserCard(String name,String phone){

  return GestureDetector(
    onTap: () {
      Get.toNamed(ROUTE_PROFILE);
    },
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            kColorPrimaryGradient2,
            kColorPrimaryGradient1,
          ],
          stops: [0.0, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // angle: 0,
          // scale: undefined,
        ),
        borderRadius: BorderRadius.circular(12),
        // boxShadow: [
        //   BoxShadow(
        //     color: Color(0x1f000000),
        //     offset: Offset(0, 3),
        //     blurRadius: 8,
        //     spreadRadius: 0,
        //   ),
        // ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Text(
                name,
                style: TextStyle(
                    color: primaryColorDark,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Center(
              child: Text(
                phone,
                style: TextStyle(
                  color: primaryColorDark,
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),

    ),
  );
}