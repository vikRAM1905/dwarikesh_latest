import 'dart:io';

import 'package:dwarikesh/components/app_bar_widget.dart';
import 'package:dwarikesh/components/photos_widget.dart';
import 'package:dwarikesh/components/section_title_only_widget.dart';
import 'package:dwarikesh/controller/activity_list_grower_controller.dart';
import 'package:dwarikesh/model/activity_list_grower_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/bottom_dialog.dart';
import 'package:dwarikesh/widgets/snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivityDetailGrower extends StatelessWidget {
  ActivityListGrowerController _controller =
      Get.find<ActivityListGrowerController>();
  Data model = Get.arguments;
  String? floatingBtnEnable;

  TextStyle titleStyle = kTextStyleSubtitle1.copyWith(
    color: primaryColor,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    floatingBtnEnable = Prefs.getString(ENABLE_BTN);
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ActivityListGrowerController>(
        builder: (_controller) => Scaffold(
              floatingActionButton: floatingBtnEnable == '1'
                  ? FloatingActionButton.extended(
                      backgroundColor: _controller.image_arr.length > 0
                          ? primaryColor
                          : Colors.grey,
                      foregroundColor: Colors.white,
                      label: Text('markAsComplete'.tr),
                      onPressed: () async {
                        _controller.image_arr.length > 0
                            ? _controller.apiTaskCompletedSubmit(
                                model.activityId.toString(),
                                model.plotId.toString(),
                                model.cfaId.toString(),
                                model.caneAreaHa!,
                                model.bcmVillage!)
                            : snakbarMsg(
                                icon: Icons.camera_alt_outlined,
                                title: 'image_empty'.tr,
                                msg: 'image_empty_substitle'.tr,
                                colors: Colors.white,
                                bgColor: Colors.redAccent);
                        ;
                      },
                      icon: Icon(Icons.check),
                    )
                  : null,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          AppBarWidget(
                            imageUrl: model.activityImage,
                          ),
                        ];
                      },
                      body: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${model.activityName}',
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    '${model.activityEndMonth} ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      // Icon(
                                      //   plotIcon,
                                      //   color: primaryColor,
                                      // ),
                                      // SizedBox(
                                      //   width: 5.w,
                                      // ),
                                      // Text(
                                      //   '${'plot'.tr} - ${model.plotId}',
                                      //   textAlign: TextAlign.center,
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .bodyText1!
                                      //       .copyWith(
                                      //           fontSize:
                                      //               TextUtils.hintTextSize,
                                      //           color: primaryColor,
                                      //           fontWeight: TextUtils
                                      //               .mediumtTextWeight),
                                      // ),
                                      // Container(
                                      //   margin: EdgeInsets.only(
                                      //       left: 5.r, right: 5.r),
                                      //   child: Text(
                                      //     ',',
                                      //     style: TextStyle(
                                      //         fontSize:
                                      //             TextUtils.headerTextSize),
                                      //   ),
                                      // ),
                                      Text(
                                        '${model.villageName} ( ${model.caneAreaHa} )',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize:
                                                    TextUtils.hintTextSize,
                                                color: textColor,
                                                fontWeight: TextUtils
                                                    .mediumtTextWeight),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(height: 10),
                            SectionTitleOnlyWidget(
                              title: model.activitySteps,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            // floatingBtnEnable == '1'
                            //     ? Padding(
                            //         padding: const EdgeInsets.all(8.0),
                            //         child: Text("Plot Name",
                            //             style: TextStyle(
                            //                 color: primaryColor, fontSize: 18)),
                            //       )
                            //     : SizedBox(),
                            // floatingBtnEnable == '1'
                            //     ? GetBuilder<ActivityListGrowerController>(
                            //         builder: (controller) => Padding(
                            //           padding: const EdgeInsets.all(8.0),
                            //           child: DropdownButtonFormField(
                            //             hint: Text(
                            //               controller.selectedPlot.value,
                            //               style: TextStyle(
                            //                   // fontSize: 14,
                            //                   // color:
                            //                   //  growerController.currentFactoryName.value == "Crob Type"
                            //                   //     ?
                            //                   // Colors.grey[400],
                            //                   // : textColor,
                            //                   // fontWeight: growerController.currentFactoryName.value == "${"factory_select".tr}" ?TextUtils.headerTextWeight : TextUtils.normalTextWeight,
                            //                   ),
                            //             ),
                            //             isExpanded: true,
                            //             icon: Icon(Icons.arrow_drop_down),
                            //             iconSize: 25,
                            //             style: TextStyle(color: textColor),
                            //             decoration: const InputDecoration(
                            //               border: OutlineInputBorder(),
                            //             ),
                            //             items: controller.plotList.map(
                            //               (val) {
                            //                 return DropdownMenuItem<String>(
                            //                   value: val.canearea,
                            //                   child: Text(
                            //                     "${val.villagename} ( ${val.canearea!})",
                            //                     style: TextStyle(
                            //                       color: textColor,
                            //                       fontSize:
                            //                           TextUtils.hintTextSize,
                            //                       fontWeight:
                            //                           TextUtils.titleTextWeight,
                            //                       fontStyle: FontStyle.normal,
                            //                     ),
                            //                   ),
                            //                 );
                            //               },
                            //             ).toList(),
                            //             onChanged: (val) {
                            //               controller.updateSelectedPlot(val);
                            //               print(
                            //                   "val:    ${controller.selectedPlot.value}");
                            //             },
                            //           ),
                            //         ),
                            //       )
                            //     : SizedBox(),
                            floatingBtnEnable == '1'
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        child: Text(
                                          '${'upload_image'.tr} *',
                                          style: titleStyle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.height * 0.02,
                                      ),
                                      Container(
                                        width: size.width * 0.45,
                                        child: GetBuilder<
                                            ActivityListGrowerController>(
                                          builder: (controller) => Container(
                                            alignment: Alignment.topRight,
                                            child: ClipOval(
                                              child: Material(
                                                color: unselectedColor,
                                                // button color
                                                child: InkWell(
                                                  splashColor:
                                                      primaryLightColor,
                                                  // inkwell color
                                                  child: SizedBox(
                                                      width: 56,
                                                      height: 56,
                                                      child: Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          size: 24,
                                                          color: primaryColor)),
                                                  onTap: () {
                                                    controller.getImage(
                                                        ImageSource.camera);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            GetBuilder<ActivityListGrowerController>(
                              builder: (controller) => controller
                                              .image_arr.length ==
                                          null ||
                                      controller.image_arr.isEmpty
                                  ? Container()
                                  : GridView.count(
                                      crossAxisCount: 3,
                                      shrinkWrap: true,
                                      children: List.generate(
                                          controller.image_arr.length, (index) {
                                        var image = controller.image_arr[index];
                                        return Container(
                                          margin: EdgeInsets.all(3),
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 170,
                                                height: 100,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.file(
                                                    image,
                                                    height: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                    padding: EdgeInsets.all(4),
                                                    child: ClipOval(
                                                      child: Material(
                                                        color:
                                                            unselectedBtnColor,
                                                        // button color
                                                        child: InkWell(
                                                          splashColor:
                                                              deActiveIconColor,
                                                          // inkwell color
                                                          child: SizedBox(
                                                              width: 24,
                                                              height: 24,
                                                              child: Icon(
                                                                  Icons
                                                                      .delete_outlined,
                                                                  size: 16,
                                                                  color: Color(
                                                                      0xFFD32F2F))),
                                                          onTap: () {
                                                            controller
                                                                .removeImage(
                                                                    index);
                                                          },
                                                        ),
                                                      ),
                                                    )),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                            ),
                            model.groweractivityimage!.length > 0
                                ? Container(
                                    height: 112,
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        width: 15,
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      itemCount:
                                          model.groweractivityimage!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        var models =
                                            model.groweractivityimage![index];
                                        return new GestureDetector(
                                          child: PhotoTile(
                                            imageUrl: models.image,
                                            width: 170,
                                            height: 100,
                                            leftTopRadius: 8,
                                            rightTopRadius: 8,
                                            leftBottomRadius: 0,
                                            rightBottomRadius: 0,
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: 120,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
