
import 'package:dwarikesh/components/section_title_only_widget.dart';
import 'package:dwarikesh/model/faq_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FAQsDetails extends StatelessWidget {

  Data model = Get.arguments;
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: Toolbar(
          title: 'faq'.tr,
          leftsideIcon: backIcon,
          leftsideBtnPress: () {
            Get.back();
          },
        ),

        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

            Container(
              width: double.infinity,

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    kColorPrimaryGradient2.withOpacity(0.7),
                    kColorPrimaryGradient1.withOpacity(0.7),
                  ],
                  stops: [0.0, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  // angle: 0,
                  // scale: undefined,
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child:  Text(
                    '${model.question ?? ''}',

                    style: TextStyle(color: primaryColorDark,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,),
                  ),


            ),),

            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.all(15),
              child:  Text(
                '${'answer'.tr} :',

                style: TextStyle(color: primaryColorDark,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,),
              ),


            ),



            SectionTitleOnlyWidget(
              title: model.answer,
            ),

          ]),
        ),
      ),
    );
  }
}
