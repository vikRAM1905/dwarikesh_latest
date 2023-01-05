import 'package:dwarikesh/components/normal_button.dart';
import 'package:dwarikesh/controller/dashboard_controller.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SuccessPage extends StatelessWidget {

  String msg = Prefs.getString(SUCCUSS_MSG);
  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height*0.15,),
          Container(

            child: Image.asset(
              "assets/images/completed.png",
              height: size.width*0.6,
              width: size.width*0.6,
            ),

          ),
          SizedBox(height: size.height*0.05,),
       Container(
         alignment: Alignment.center,
         margin: EdgeInsets.all(20),
         child:Text(msg??'SUCCESS !',style:kTextStyleHeadline6,),
       ),
          SizedBox(height: size.height*0.10,),

          Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            width: size.width * 0.9,
            height: 55,
            child: NormalButton(
              textColor: Colors.white,
              icons: Icons.arrow_back,
              text:'${'back_to_home'.tr}',
              color: primaryColor,
              press: () {
             controller.apiGetMenuList();
                Get.back();

              },
            ),
          )
        ],

      ),
    );
  }
}
