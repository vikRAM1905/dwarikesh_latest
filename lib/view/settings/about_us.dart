
import 'package:dwarikesh/controller/terms_controller.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dwarikesh/controller/dashboard_controller.dart';
import 'package:dwarikesh/components/section_title_only_widget.dart';


class AboutsUs extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,

        appBar: Toolbar(
          title: "about_us".tr,
          leftsideIcon: backIcon,
          leftsideBtnPress: () {
            Get.back();
          },

        ),


        body: SingleChildScrollView(
          child: Column(children: [
           Padding(padding: EdgeInsets.all(8),child:  GetBuilder<TermsController>(builder: (controller)=>SectionTitleOnlyWidget(
             title: controller.aboutUs.value,
           ),),)
          ]),
        ),
      ),
    );
  }
}
