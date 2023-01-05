import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/controller/fertiliser_calculator_controller.dart';
import 'package:dwarikesh/model/fertiliser_menu_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/button.dart';
import 'package:dwarikesh/widgets/rounded_button.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'dart:math' as math;

class FertiliserCalculator extends StatelessWidget {
  final FertiliserCalculatorController _controller =
      Get.put(FertiliserCalculatorController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<String> _landType = ['hectare'.tr, 'acre'.tr];

    TextStyle textStyle = TextStyle(
      color: textColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    );
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      appBar: Toolbar(
        title: "fertilizer_dosage".tr,
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
            text: "calculate".tr,
            color: primaryColor,
            press: () {
              FocusScope.of(context).requestFocus(FocusNode());
              _controller.validation();
            },
          ),
        ),
        elevation: 0,
      ),
      body: Obx(() => SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'type_your_land_area'.tr,
                    style: textStyle,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _controller.radioSelected.value,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          _controller.radioSelected.value =
                              int.parse(value.toString());
                          _controller.areaType.value = 'hectare'.tr;
                        },
                      ),
                      Text(
                        'hectare'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: textColor),
                      ),
                      Radio(
                        value: 2,
                        groupValue: _controller.radioSelected.value,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          _controller.radioSelected.value =
                              int.parse(value.toString());
                          _controller.areaType.value = 'acre'.tr;
                        },
                      ),
                      Text(
                        'acre'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: textColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 56,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: primaryColorDark.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GetBuilder<FertiliserCalculatorController>(
                    builder: (controller) {
                      return TextFormField(
                        controller: controller.areaTextController,
                        onChanged: controller.onTextChanged,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: TextUtils.commonTextSize,
                          fontWeight: TextUtils.titleTextWeight,
                          fontStyle: FontStyle.normal,
                        ),
                        cursorColor: primaryColorDark,
                        inputFormatters: [
                          DecimalTextInputFormatter(decimalRange: 2)
                        ],
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        maxLines: 1,
                        maxLength: 10,
                        decoration: new InputDecoration(
                          counterText: "",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "choose_your_crop_type".tr,
                    style: textStyle,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (_controller.responseCode.value == '200')
                  _controller.menuListData.length > 0
                      ? Container(
                          height: 56,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: _controller.menuListData.length,
                              itemBuilder: (context, index) {
                                var data = _controller.menuListData[index];
                                var count = index + 1;
                                return cropTile(data, size);
                              }),
                        )
                      : ErrorMessage(
                          errorCode: '403',
                        )
                else if (_controller.responseCode == '404')
                  ErrorMessage(
                    errorCode: '404',
                  )
                else if (_controller.responseCode == '500')
                  ErrorMessage(
                    errorCode: '500',
                  )
                else
                  ErrorMessage(
                    errorCode: '403',
                  ),
                SizedBox(
                  height: 20,
                ),
                _controller.combinationTypeList.length > 0
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "combination".tr,
                          style: textStyle,
                        ),
                      )
                    : Container(),
                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: _controller.combinationTypeList.length,
                      itemBuilder: (contexts, index) {
                        var data = _controller.combinationTypeList[index];
                        var count = index + 1;

                        return combinationTile(data, count, size, context);
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                _controller.fertilizerTypeList.length > 0
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "use_of_fertilizer".tr,
                          style: textStyle,
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio:
                        (size.width / 2 / (kToolbarHeight - 20) / 2),
                    scrollDirection: Axis.vertical,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    crossAxisCount: 2,
                    children: List.generate(
                        _controller.fertilizerTypeList.length, (index) {
                      var data = _controller.fertilizerTypeList[index];
                      return fertilizerTile(data);
                    }),
                  ),
                )
              ]))),
    ));
  }

  Widget cropTile(Data model, Size size) {
    return InkWell(
      onTap: () {
        _controller.menuListData
            .forEach((element) => element.TypeclickPos = false);
        if (model.getCropTypePosition == false)
          model.setCropTypePosition = true;
        else
          model.setCropTypePosition = false;

        _controller.croptype.value = model.croptype!;
        _controller.combination.value = '';
        _controller.useoffertilizer.value = '';

        _controller.combinationTypeList.refresh();
        _controller.fertilizerTypeList.refresh();

        _controller.combinationTypeList.value = model.type!;
        _controller.fertilizerTypeList.value = [];
      },
      child: Container(
        width: size.width / 3.5,
        margin: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(
                width: 1,
                color: primaryColor //                   <--- border width here
                ),
            color: model.getCropTypePosition == true
                ? primaryColor
                : Colors.transparent),
        child: Center(
          child: Text(
            '${model.croptype.toString()}',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: model.getCropTypePosition == true
                    ? Colors.white
                    : primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  Widget combinationTile(Type model, int pos, Size size, BuildContext context) {
    return InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());

          _controller.combinationTypeList.refresh();
          _controller.fertilizerTypeList.refresh();

          _controller.combinationTypeList
              .forEach((element) => element.DataclickPos = false);
          if (model.getDataPosition == false)
            model.setDataPosition = true;
          else
            model.setDataPosition = false;

          _controller.combination.value = '';
          _controller.combination.value = model.combination!;
          _controller.useoffertilizer.value = '';

          _controller.fertilizerTypeList.value = model.fertilizer!;

          print(
              'COMINAITION SELECTION ${_controller.fertilizerTypeList.value.length}');
        },
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(10),
              child: Icon(
                model.getDataPosition == true
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                color: model.getDataPosition == true
                    ? primaryColor
                    : Colors.grey[400],
              ),
            ),
            Container(
              child: Text(
                '${model.combination.toString()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: model.getDataPosition == true
                        ? primaryColor
                        : textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ));
  }

  Widget fertilizerTile(Fertilizer model) {
    print('DATA OF USE OF FETILIZER ${model.useoffertilizer}');
    return InkWell(
        onTap: () {
          _controller.fertilizerTypeList
              .forEach((element) => element.fertilizerclickPos = false);
          if (model.getFertilizerTypePosition == false)
            model.setFertilizerTypePosition = true;
          else
            model.setFertilizerTypePosition = false;

          _controller.useoffertilizer.value = model.useoffertilizer!;
          _controller.fertilizerTypeList.refresh();
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(width: 1, color: primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: model.getFertilizerTypePosition == true
                  ? primaryColor.withOpacity(0.6)
                  : Colors.grey[100]),
          child: Center(
            child: Text(
              '${model.useoffertilizer.toString()}',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: model.getFertilizerTypePosition == true
                      ? textColor
                      : primaryColor.withOpacity(0.6),
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ));
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int? decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange!) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
