import 'package:dwarikesh/controller/fertiliser_result_controller.dart';
import 'package:dwarikesh/model/fertiliser_calculator_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/button.dart';
import 'package:dwarikesh/widgets/profileTile.dart';
import 'package:dwarikesh/widgets/rounded_button.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FertiliserResult extends StatelessWidget {
  final _controller = Get.put(FertiliserResultController());

  @override
  Widget build(BuildContext context) {
    String unit = Prefs.getString(USERUNIT);
    String combination = Prefs.getString(COMBINATION);
    String croptype = Prefs.getString(CROP_TYPE);
    String useoffertilizer = Prefs.getString(USE_OF_FERTILIZER);

    TextStyle textStyle = TextStyle(
      color: primaryColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    );

    return SafeArea(
        child: Scaffold(
      appBar: Toolbar(
        title: "recommended_dosage".tr,
        leftsideIcon: backIcon,
        leftsideBtnPress: () {
          Get.back();
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          margin: EdgeInsets.all(15.r),
          height: 48.h,
          child: ButtonField(
            text: "back".tr,
            color: primaryColor,
            press: () {
              Get.back();
            },
          ),
        ),
        elevation: 0,
      ),
      body: Obx(() => SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(top: 45, bottom: 25, left: 15, right: 15),
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
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x1f000000),
                        offset: Offset(0, 3),
                        blurRadius: 33,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DosageTile(
                          title: "cropType".tr,
                          message:
                              '${croptype ?? DATA_NULL_HANDLER} - ( ${unit ?? DATA_NULL_HANDLER} )'),
                      DosageTile(
                        title: "combination".tr,
                        message: combination.toString() ?? DATA_NULL_HANDLER,
                      ),
                      DosageTile(
                          title: "use_of_fertilizer".tr,
                          message:
                              useoffertilizer.toString() ?? DATA_NULL_HANDLER),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "result".tr,
                    style: textStyle,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _controller.resListData.length,
                      itemBuilder: (contexts, index) {
                        var data = _controller.resListData[index];

                        return ContentTile(
                          title: data.sourceOfNutrients!,
                          weight: data.quantityOfFertilizerPerAcre!,
                          unit: data.unit!,
                        );
                      }),
                )
              ]))),
    ));
  }
}

class ContentTile extends StatelessWidget {
  String? title, bag, weight, unit;
  Function()? position;

  ContentTile({
    this.title,
    this.bag,
    this.weight,
    this.unit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: position,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset('assets/images/fertilizer.png'),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title!.replaceAll(RegExp(r"\s+"), ""),
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                '${weight}',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                " ${unit} ",
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
