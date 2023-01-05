import 'dart:convert';

import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/components/photos_widget.dart';
import 'package:dwarikesh/controller/agri_implements_controller.dart';
import 'package:dwarikesh/model/agri_implements_model.dart';

import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'package:dwarikesh/widgets/search_toolbar.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AgriImplementsList extends StatelessWidget {
  AgriImplementsList({Key? key}) : super(key: key);

  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AgriImplementsController>(
        builder: (controller) => new Scaffold(
            key: scaffoldKey,
            appBar: SearchToolbar(
              toolbarType: controller.isSearching.value
                  ? _buildSearchField(controller, context)
                  : _buildTitle(context, 'krishi_yantra'.tr),
              leftsideIcon: backIcon,
              leftsideBtnPress: () {
                Get.back();
              },
              rightsideBtnAvil: 1,
              rightsideIcon:
                  controller.isSearching.value ? cancelIcon : searchIcon,
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
            body: GetBuilder<AgriImplementsController>(builder: (_controller) {
              if (_controller.searchTextController!.value.text.length > 1) {
                return Padding(
                  padding: EdgeInsets.all(24),
                  child: GridView.count(
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    crossAxisCount: 2,
                    children: List.generate(_controller.searchListData.length,
                        (index) {
                      var data = _controller.searchListData[index];
                      return ProductTile(
                        model: data,
                      );
                    }),
                  ),
                );
              } else {
                return _controller.listData.length > 0
                    ? Padding(
                        padding: EdgeInsets.all(10),
                        child: GridView.count(
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          crossAxisCount: 2,
                          children: List.generate(_controller.listData.length,
                              (index) {
                            var data = _controller.listData[index];
                            return ProductTile(
                              model: data,
                            );
                          }),
                        ),
                      )
                    : ErrorMessage(
                        errorCode: '403',
                      );
              }
            })));
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
      AgriImplementsController controller, BuildContext context) {
    return new GetBuilder<AgriImplementsController>(
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
              hintText: 'search_product'.tr,
              hintStyle: TextStyle(
                  fontSize: TextUtils.hintTextSize,
                  fontWeight: TextUtils.mediumtTextWeight,
                  color: primaryColor),
            ),
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: primaryColor),
            onChanged: controller.updateSearchQuery));
  }
}

class ProductTile extends StatelessWidget {
  Data? model;
  ProductTile({this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.toNamed(ROUTE_AGRI_IMPLEMENTS_DETAIL, arguments: model);
        },
        child: Container(
          margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: PhotoTile(
                    imageUrl: model!.productImage,
                    width: double.infinity,
                    height: 130,
                    leftTopRadius: 8,
                    rightTopRadius: 8,
                    leftBottomRadius: 8,
                    rightBottomRadius: 8,
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      color: primary2ColorDark.withOpacity(0.7),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 6,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  model!.productName!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
