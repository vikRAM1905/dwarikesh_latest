import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/components/photos_widget.dart';
import 'package:dwarikesh/components/section_title_only_widget.dart';
import 'package:dwarikesh/controller/info_center_controller.dart';
import 'package:dwarikesh/model/info_center_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../preview_image.dart';

class InfoCenterDetail extends StatefulWidget {
  @override
  _InfoCenterDetailState createState() => _InfoCenterDetailState();
}

class _InfoCenterDetailState extends State<InfoCenterDetail> {
  final _controller = Get.put(InfoCenterController());

  bool isExpand = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isExpand = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Toolbar(
          title: "hand_book".tr,
          leftsideIcon: backIcon,
          leftsideBtnPress: () {
            Get.back();
          },
        ),
        body: Obx(() => SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  if (_controller.responseCode.value == '200')
                    if (_controller
                            .searchsubTopicTextController!.value.text.length >
                        1)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _controller.searchsubtopicListData.length,
                        itemBuilder: (context, index) {
                          var data = _controller.searchsubtopicListData[index];
                          return Padding(
                            padding: (isExpand == true)
                                ? const EdgeInsets.all(8.0)
                                : const EdgeInsets.all(12.0),
                            child: Container(
                              child: ExpansionTile(
                                title: Container(
                                    width: double.infinity,

                                    //  child: Text(data.question,style: TextStyle(color:Colors.black,fontSize: (isExpand!=true)?18:22),)),

                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                primaryColor,
                                                primaryColor,
                                              ],
                                              stops: [0.0, 1.0],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 10,
                                              bottom: 10),
                                          child: Text(
                                            data.questionNum!,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              data.question!,
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
                                    )),
                                trailing: Icon(Icons.arrow_drop_down,
                                    size: 32, color: primaryColorDark),
                                onExpansionChanged: (value) {
                                  setState(() {
                                    isExpand = value;
                                  });
                                },
                                children: [
                                  Container(
                                      color: (isExpand == true)
                                          ? primaryLightColor
                                          : Colors.white,
                                      child: SectionTitleOnlyWidget(
                                        title: data.answer,
                                      )),
                                  Container(
                                      color: (isExpand == true)
                                          ? primaryLightColor
                                          : Colors.white,
                                      child: SectionTitleOnlyWidget(
                                        title: data.answer,
                                      )),
                                  Container(
                                    color: (isExpand == true)
                                        ? primaryLightColor
                                        : Colors.white,
                                    child: GridView.count(
                                      crossAxisCount: 3,
                                      shrinkWrap: true,
                                      children: List.generate(
                                          data.picture!.length, (index) {
                                        var fileData = data.picture![index];

                                        return ProductTile(
                                          model: fileData,
                                          picture_arr: data.picture,
                                          position: index,
                                        );
                                      }),
                                    ),
                                  ),
                                  Container(
                                    color: (isExpand == true)
                                        ? primaryLightColor
                                        : Colors.white,
                                    height: 50,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    else if (_controller.responseCode.value == '200')
                      _controller.subtopicListData.length > 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _controller.subtopicListData.length,
                              itemBuilder: (context, index) {
                                var data = _controller.subtopicListData[index];
                                return Padding(
                                  padding: (isExpand == true)
                                      ? const EdgeInsets.all(8.0)
                                      : const EdgeInsets.all(12.0),
                                  child: Container(
                                    child: ExpansionTile(
                                      title: Container(
                                          width: double.infinity,

                                          //  child: Text(data.question,style: TextStyle(color:Colors.black,fontSize: (isExpand!=true)?18:22),)),

                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      primaryColor,
                                                      primaryColor,
                                                    ],
                                                    stops: [0.0, 1.0],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                padding: EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 10,
                                                    bottom: 10),
                                                child: Text(
                                                  data.questionNum!,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Text(
                                                    data.question!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        color: primaryColorDark,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                      trailing: Icon(Icons.arrow_drop_down,
                                          size: 32, color: primaryColorDark),
                                      onExpansionChanged: (value) {
                                        setState(() {
                                          isExpand = value;
                                        });
                                      },
                                      children: [
                                        Container(
                                            color: (isExpand == true)
                                                ? primaryLightColor
                                                : Colors.white,
                                            child: SectionTitleOnlyWidget(
                                              title: data.answer,
                                            )),
                                        Container(
                                          color: (isExpand == true)
                                              ? primaryLightColor
                                              : Colors.white,
                                          child: GridView.count(
                                            crossAxisCount: 3,
                                            shrinkWrap: true,
                                            children: List.generate(
                                                data.picture!.length, (index) {
                                              var fileData =
                                                  data.picture![index];
                                              print(
                                                  'FILE DATA ${fileData.image}');
                                              return ProductTile(
                                                model: fileData,
                                                picture_arr: data.picture,
                                                position: index,
                                              );
                                            }),
                                          ),
                                        ),
                                        Container(
                                          color: (isExpand == true)
                                              ? primaryLightColor
                                              : Colors.white,
                                          height: 50,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
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
                      )
                ],
              ),
            )));
  }
}

class ProductTile extends StatelessWidget {
  Picture? model;
  var picture_arr;
  int? position;

  ProductTile({this.model, this.picture_arr, this.position});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /*   print("IMAGE ARRG  ${picture_arr.length}");
        Get.toNamed(ROUTE_IMAGE_VIEW,arguments: picture_arr);*/

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PreviewImage(
              galleryItems: picture_arr,
              initialIndex: position!,
            ),
          ),
        );
      },
      child: Container(
        height: 130,
        width: 200,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Container(
                  child: PhotoTile(
                imageUrl: model!.image,
                width: double.infinity,
                height: 130,
                leftTopRadius: 8,
                rightTopRadius: 8,
                leftBottomRadius: 0,
                rightBottomRadius: 0,
              )),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  model!.title!,
                  style: TextStyle(
                    color: primaryColorDark,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
