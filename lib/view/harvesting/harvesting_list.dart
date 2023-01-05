import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/controller/harvesting_controller.dart';
import 'package:dwarikesh/model/harvesting_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/view/fertiliser/fertiliser_calculator.dart';
import 'package:dwarikesh/widgets/button.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Harvesting extends StatelessWidget {
  final HarvestingController _controller = Get.put(HarvestingController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HarvestingController>(
        builder: (_controller) => SafeArea(
              child: Scaffold(
                appBar: Toolbar(
                  title: "harvesting".tr,
                  leftsideIcon: backIcon,
                  leftsideBtnPress: () {
                    Get.back();
                  },
                ),
                body: SingleChildScrollView(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 0,
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 24,
                          ),
                          Expanded(
                            child: CupertinoSlidingSegmentedControl(
                                children: <int, Widget>{
                                  0: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'new'.tr,
                                    ),
                                  ),
                                  1: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'completed'.tr,
                                    ),
                                  ),
                                },
                                groupValue: _controller.tabPosition.toInt(),
                                onValueChanged: (val) {
                                  _controller.updatetabPosition(
                                      int.parse(val.toString()));
                                }),
                          ),
                          SizedBox(
                            width: 24,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    if (_controller.responseCode == '200')
                      _controller.tabPosition.value == 0
                          ? formHarvesting(context)
                          : listHarvesting(context, _controller.resListData)
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
                      )
                  ],
                )),
              ),
            ));
  }

  Widget formHarvesting(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: textColor,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    );
    return GetBuilder<HarvestingController>(
        builder: (controller) => Padding(
            padding: EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "choose_your_plot".tr,
                style: textStyle,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: primaryColorDark.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: GetBuilder<HarvestingController>(
                  builder: (controller) => DropdownButton(
                    hint: controller.currentPlot == 'select_plot'.tr
                        ? Text(
                            'select_plot'.tr,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: TextUtils.commonTextSize,
                              fontWeight: TextUtils.normalTextWeight,
                              fontStyle: FontStyle.normal,
                            ),
                          )
                        : Text(
                            controller.currentPlot.isEmpty
                                ? ""
                                : controller.currentPlot,
                            style: TextStyle(
                              color: textColor,
                              fontSize: TextUtils.commonTextSize,
                              fontWeight: TextUtils.normalTextWeight,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                    iconSize: 24,
                    underline: SizedBox(),
                    style: TextStyle(color: textColor),
                    items: controller.plotListData.map(
                      (val) {
                        return DropdownMenuItem(
                          value: val.plotName.toString(),
                          child: Text(
                            val.plotName.toString(),
                            style: TextStyle(
                              color: textColor,
                              fontSize: TextUtils.commonTextSize,
                              fontWeight: TextUtils.titleTextWeight,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      controller.updatePlotValue(val.toString());
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (controller.currentPlot != 'select_plot'.tr)
                Container(
                  height: 0.5,
                  width: double.infinity,
                  color: Colors.grey[300],
                  margin: EdgeInsets.only(left: 56, right: 56),
                ),
              SizedBox(
                height: 10,
              ),
              if (controller.currentPlot != 'select_plot'.tr)
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.3),
                    borderRadius: BorderRadius.all(Radius.circular(
                            5.0) //                 <--- border radius here
                        ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'plot_details'.tr,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: TextUtils.commonTextSize,
                            fontWeight: TextUtils.mediumtTextWeight),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      childRowData(context, plotIcon, 'village'.tr,
                          controller.selctedVillage.value),
                      SizedBox(
                        height: 8.h,
                      ),
                      childRowData(context, orderIcon, 'season'.tr,
                          controller.selctedSeasonShow.value),
                      SizedBox(
                        height: 8.h,
                      ),
                      childRowData(
                          context,
                          CupertinoIcons.leaf_arrow_circlepath,
                          'plant_type'.tr,
                          controller.selctedPlantTypeShow.value),
                      SizedBox(
                        height: 10.h,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10.h,
                      ),
                      detailData(context, 'plantationStartDate'.tr,
                          controller.selctedstartDate.value),
                      if (controller.selctedPartialYieldQuantity.value != '' &&
                          controller.selctedPartialYieldQuantity.value != null)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (controller.selctedPartialYieldQuantity.value != '' &&
                          controller.selctedPartialYieldQuantity.value != null)
                        detailData(context, 'partial_yield_quantity'.tr,
                            controller.selctedPartialYieldQuantity.value),
                    ],
                  ),
                ),
              SizedBox(
                height: 10,
              ),
              if (controller.currentPlot != 'select_plot'.tr &&
                  controller.harvestingTypeData.length > 0)
                Text(
                  "what_is_your_harvesting_type".tr,
                  style: textStyle,
                ),
              if (controller.currentPlot != 'select_plot'.tr &&
                  controller.harvestingTypeData.length > 0)
                SizedBox(
                  height: 20,
                ),
              if (controller.currentPlot != 'select_plot'.tr &&
                  controller.harvestingTypeData.length > 0)
                Container(
                  height: 56,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.harvestingTypeData.length,
                      itemBuilder: (context, index) {
                        var data = controller.harvestingTypeData[index];
                        var count = index + 1;
                        Size size = MediaQuery.of(context).size;
                        return cropTile(data, size);
                      }),
                ),
              if (controller.currentPlot != 'select_plot'.tr &&
                  controller.harvestingTypeData.length > 0)
                SizedBox(
                  height: 30,
                ),
              Text(
                "enter_the_yield_quantity".tr,
                style: textStyle,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: primaryColorDark.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: GetBuilder<HarvestingController>(
                          builder: (controller) {
                            return TextFormField(
                              controller: controller.areaTextController,
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
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
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
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              if (controller.ratoonAvailable == true)
                Text(
                  "do_you_wish_to_continue_with_ratoon?".tr,
                  style: textStyle,
                ),
              if (controller.ratoonAvailable == true)
                SizedBox(
                  height: 10,
                ),
              if (controller.ratoonAvailable == true)
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Radio(
                        value: 1,
                        groupValue: controller.enableId.value,
                        activeColor: primaryColor,
                        onChanged: (val) {
                          controller.radioButtonItem.value = 'yes'.tr;
                          controller.enableId.value = 1;
                          controller.update();
                        },
                      ),
                      Text(
                        'yes'.tr,
                        style: new TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: controller.enableId.value == 1
                                ? primaryColor
                                : textColor),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Radio(
                        value: 2,
                        groupValue: controller.enableId.value,
                        activeColor: primaryColor,
                        onChanged: (val) {
                          controller.radioButtonItem.value = 'no'.tr;
                          controller.enableId.value = 2;
                          controller.update();
                        },
                      ),
                      Text(
                        'no'.tr,
                        style: new TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: controller.enableId.value == 2
                                ? primaryColor
                                : textColor),
                      ),
                    ]),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 48.h,
                child: ButtonField(
                  text: "done".tr,
                  color: primaryColor,
                  press: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    controller.validation();
                  },
                ),
              )
            ])));
  }

  Widget cropTile(Harvestingtype model, Size size) {
    return InkWell(
      onTap: () {
        _controller.harvestingTypeData
            .forEach((element) => element.TypeclickPos = false);
        if (model.getCropTypePosition == false)
          model.setCropTypePosition = true;
        else
          model.setCropTypePosition = false;

        _controller.selctedharvestingType.value = model.type!;
        _controller.selctedharvestingId.value = model.type_id!;
        _controller.ratoonAvailable.value = model.ratoon!;

        _controller.update();
      },
      child: Container(
        height: 75,
        width: size.width / 2.5,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(width: 0.5, color: primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: model.getCropTypePosition == true
                ? primaryColor
                : Colors.grey[100]),
        child: Center(
          child: Text(
            '${model.type.toString()}',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: model.getCropTypePosition == true
                    ? Colors.white
                    : primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    return textColor;
  }

  Widget listHarvesting(BuildContext context, List<Completed> resListData) {
    if (resListData.length > 0)
      return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: kToolbarHeight + 10),
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: resListData.length,
          itemBuilder: (context, index) {
            var data = resListData[index];
            return DataTile(context, data);
          });
    else
      return ErrorMessage(
        errorCode: '403',
      );
  }

  Widget DataTile(BuildContext context, Completed model) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(width: 0.3),
        borderRadius: BorderRadius.all(
            Radius.circular(5.0) //                 <--- border radius here
            ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'plot_details'.tr,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: TextUtils.commonTextSize,
                fontWeight: TextUtils.mediumtTextWeight),
          ),
          SizedBox(
            height: 8.h,
          ),
          childRowData(context, plotIcon, 'village'.tr, model.village!),
          SizedBox(
            height: 8.h,
          ),
          childRowData(context, orderIcon, 'season'.tr, model.season!),
          SizedBox(
            height: 8.h,
          ),
          childRowData(context, CupertinoIcons.leaf_arrow_circlepath,
              'plant_type'.tr, model.plantType!),
          SizedBox(
            height: 10.h,
          ),
          Divider(),
          SizedBox(
            height: 10.h,
          ),
          detailData(
              context, 'plantationStartDate'.tr, model.plantationStartDate!),
          SizedBox(
            height: 8.h,
          ),
          detailData(context, 'harvesting_type'.tr, model.harvestingType!),
          SizedBox(
            height: 8.h,
          ),
          detailData(context, 'yield_quantity'.tr, model.yieldQuantity!),
          SizedBox(
            height: 15.h,
          ),
          Row(
            children: [
              Image.network(
                model.image!,
                width: 24.h,
                height: 24.h,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                model.content!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: TextUtils.hintTextSize,
                    color: textColor,
                    fontWeight: TextUtils.mediumtTextWeight),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }

  Widget childRowData(
      BuildContext context, IconData icons, String title, String message) {
    return Row(
      children: [
        Icon(
          icons,
          size: 25,
          color: primaryColor,
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          '${title} : ',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: TextUtils.hintTextSize,
              color: primaryColor,
              fontWeight: TextUtils.mediumtTextWeight),
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: TextUtils.hintTextSize,
              color: textColor,
              fontWeight: TextUtils.mediumtTextWeight),
        ),
      ],
    );
  }

  Widget detailData(BuildContext context, String title, String message) {
    return Row(
      children: [
        Text(
          '${title} : ',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: TextUtils.hintTextSize,
              color: textColor,
              fontWeight: TextUtils.mediumtTextWeight),
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: TextUtils.hintTextSize,
              color: primaryColor,
              fontWeight: TextUtils.mediumtTextWeight),
        ),
      ],
    );
  }
}
