import 'dart:math';

import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/components/section_title_only_widget.dart';
import 'package:dwarikesh/controller/info_center_controller.dart';
import 'package:dwarikesh/model/info_center_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:dwarikesh/widgets/search_toolbar.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'info_center_detail.dart';

class InfoCenterList extends StatelessWidget {
  final infoController = Get.put(InfoCenterController());

  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InfoCenterController>(
      builder: (controller) => new Scaffold(
        key: scaffoldKey,
        appBar: SearchToolbar(
          toolbarType: controller.isSearching.value
              ? _buildSearchField(controller, context)
              : _buildTitle(context, 'hand_book'.tr),
          leftsideIcon: backIcon,
          leftsideBtnPress: () {
            Get.back();
          },
          rightsideBtnAvil: 1,
          rightsideIcon: controller.isSearching.value ? cancelIcon : searchIcon,
          rightsideBtnPress: () {
            if (controller.isSearching.value) {
              if (controller.searchTextController == null ||
                  controller.searchTextController!.text.isEmpty) {
                Navigator.pop(context);
                return;
              }
              controller.clearSearchQuery();
            } else {
              controller.startSearch(context);
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            questionOutLineIcon,
            color: Colors.white,
            size: 36,
          ),
          backgroundColor: primaryColor,
          onPressed: () {
            Get.toNamed(ROUTE_FAQ);
          },
        ),
        body: ListView(children: [
          SizedBox(
            width: 20,
          ),
          if (!controller.userComeNewly.value)
            if (controller.responseCode.value == '200')
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: controller.resListData.length,
                  itemBuilder: (context, index) {
                    var data = controller.resListData[index];

                    return Column(
                      children: [
                        DataTile(
                          count: data.topicNumber!,
                          title: data.topic!,
                          data: data,
                        ),
                        subTopicTile(
                          data: data,
                        )
                      ],
                    );
                  })
            else
              ErrorMessage(
                errorCode: controller.responseCode.value,
              )
          else
            Container(
              alignment: Alignment.center,
              height: double.infinity,
              width: kToolbarHeight,
              child: Progressbar(),
            )
        ]),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return new InkWell(
      onTap: () => scaffoldKey.currentState!.openDrawer(),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: Colors.white),
      ),
    );
  }

  Widget _buildSearchField(
      InfoCenterController controller, BuildContext context) {
    return new GetBuilder<InfoCenterController>(
        init: controller,
        builder: (controller) => TextField(
            controller: controller.searchTextController,
            textDirection: TextDirection.ltr,
            cursorColor: Colors.red,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: red, width: 0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              filled: true,
              fillColor: Colors.white,
              counterText: "",
              hintText: 'search_topics'.tr,
              hintStyle: TextStyle(
                  fontSize: TextUtils.hintTextSize,
                  fontWeight: TextUtils.mediumtTextWeight,
                  color: primaryColor),
            ),
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: primaryColor),
            onChanged: controller.onSearchTextChanged));
  }
}

class DataTile extends StatelessWidget {
  String? count, title;
  Data? data;

  final controller = Get.put(InfoCenterController());
  DataTile({this.count, this.title, this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          primaryColorDark,
                          primaryColorDark,
                        ],
                        stops: [0.0, 1.0],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        // angle: 0,
                        // scale: undefined,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Color(0x1f000000),
                      //     offset: Offset(0, 3),
                      //     blurRadius: 8,
                      //     spreadRadius: 0,
                      //   ),
                      // ],
                    ),
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 15, bottom: 15),
                    child: Text(
                      count!,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        title!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: primaryColorDark,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class subTopicTile extends StatelessWidget {
  Data? data;
  subTopicTile({this.data});
  final _controller = Get.put(InfoCenterController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InfoCenterController>(builder: (controller) {
      return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: data!.subtopic!.length,
          itemBuilder: (context, index) {
            var datad = data!.subtopic![index];

            return Container(
              color: Colors.grey[250],
              padding: EdgeInsets.all(5.0),
              child: ExpansionTile(
                title: Container(
                    width: double.infinity,

                    //  child: Text(data.question,style: TextStyle(color:Colors.black,fontSize: (isExpand!=true)?18:22),)),

                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5, right: 10),
                          child: Text(
                            datad.questionNum!,
                            style: TextStyle(
                                color: primaryColorDark,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              datad.question!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  color: datad.color == '0'
                                      ? textColor
                                      : Colors.red,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    )),
                trailing:
                    Icon(Icons.arrow_drop_down, size: 32, color: textColor),
                onExpansionChanged: (value) {
                  controller.isExpand.value = value;
                },
                children: [
                  Container(
                      color: white,
                      child: SectionTitleOnlyWidget(
                        title: datad.answer,
                      )),
                  Container(
                    color: Colors.white,
                    child: GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(datad.picture!.length, (index) {
                        var fileData = datad.picture![index];

                        return ProductTile(
                          model: fileData,
                          picture_arr: datad.picture,
                          position: index,
                        );
                      }),
                    ),
                  ),
                  Container(
                    height: 50,
                  ),
                ],
              ),
            );
          });
    });
  }
}
