import 'package:dwarikesh/controller/activity_list_grower_controller.dart';
import 'package:dwarikesh/model/activity_list_grower_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'photos_widget.dart';

class GrowerActivityItemWidget extends StatelessWidget {
  final Function? onPressed;
  Data? model;
  ActivityListGrowerController _controller =
      Get.put(ActivityListGrowerController());

  GrowerActivityItemWidget({this.onPressed, this.model});

  @override
  Widget build(BuildContext context) {
    /*  return GestureDetector(
      onTap: () {
        this.onPressed();
      },
      child: Container(
        width: 250,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(0x1f000000),
              offset: Offset(0, 3),
              blurRadius: 14,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: model.overduestatus == 'Overdue'
                    ? Banner(
                        message:
                            '${model.overduedays} - ${model.overduestatus}',
                        textStyle: TextStyle(
                          fontSize: 10,
                        ),
                        location: BannerLocation.topEnd,
                        color: Colors.red,
                        child: PhotoTile(
                          imageUrl: model.activityImage,
                          width: double.infinity,
                          height: 100,
                          leftTopRadius: 8,
                          rightTopRadius: 8,
                          leftBottomRadius: 0,
                          rightBottomRadius: 0,
                        ),
                      )
                    : PhotoTile(
                        imageUrl: model.activityImage,
                        width: double.infinity,
                        height: 100,
                        leftTopRadius: 8,
                        rightTopRadius: 8,
                        leftBottomRadius: 0,
                        rightBottomRadius: 0,
                      ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 6,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${model.activityName}',
                      style: TextStyle(
                        color: primaryColorDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.normal,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                  left: 10,
                ),
                child: Row(
                  children: [
                    Flexible(

                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.only(top: 3,bottom: 3),
                          child: Text(
                            '${model.activityEndMonth}',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    _controller.tabPosition.value == 2
                        ? Align(
                      alignment: Alignment.topRight,
                      child: Wrap(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: model.activityStatus == 2
                                    ? Colors.redAccent
                                    : model.activityStatus == 1
                                    ? Colors.green
                                    : Colors.orangeAccent,
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0x20000000),
                                      blurRadius: 1,
                                      offset: Offset(0, 3))
                                ]),
                            child: Wrap(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  model.activityStatus == 2
                                      ? Icons.cancel
                                      : model.activityStatus == 1
                                      ? Icons.check_circle
                                      : Icons.timer,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  model.activityStatus == 2
                                      ? 'rejected'.tr
                                      : model.activityStatus == 1
                                      ? 'approved'.tr
                                      : 'waiting'.tr,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),

                    )
                        : Container(),
                    _controller.tabPosition.value == 0 &&
                            model.activityStatus == 3

                        ? Container(
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0x20000000),
                                blurRadius: 1,
                                offset: Offset(0, 3))
                          ]),
                      child: Wrap(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.refresh,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'reassigned'.tr,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    )
                        */ /* Flexible(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Wrap(
                                children: [
                                  Container(
                                    width: 100,
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Colors.orangeAccent,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0x20000000),
                                              blurRadius: 1,
                                              offset: Offset(0, 3))
                                        ]),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.refresh,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Flexible(
                                          child: Text(
                                            'reassigned'.tr,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),

                            ),
                          )*/ /*
                        : Container()
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(
                left: 10,
                top: 6,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  (_controller.tabPosition.value == 2 &&
                      model.activityEarnedPoints == 0)
                      ?
                    Container(): FittedBox(child:  Container(
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.only(right: 3),

                    decoration: BoxDecoration(
                      color: kColorPrimaryGradient1,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Wrap(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 18,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(_controller.tabPosition.value == 2
                            ? model.activityEarnedPoints
                            .toString()
                            .trim()
                            : model.activityRewardPoints.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: primaryColor)),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),),



                 FittedBox(child:  Container(
                   padding: EdgeInsets.all(4),

                   decoration: BoxDecoration(
                       color: kColorPrimaryGradient1,
                       borderRadius: BorderRadius.all(Radius.circular(12)),
                     ),
                   child: Wrap(
                     children: [
                       SizedBox(
                         width: 5,
                       ),
                       Icon(
                         Icons.map,
                         color: primaryColor,
                         size: 18,
                       ),
                       SizedBox(
                         width: 3,
                       ),
                       Text('${'plot'.tr} ${model.plotId.toString()} - ${model.villageName.toString().toLowerCase()}  (${model.caneAreaHa} ${'ha'.tr})',
                           style: Theme.of(context)
                               .textTheme
                               .caption
                               .copyWith(color: primaryColor)),
                       SizedBox(
                         width: 5,
                       ),
                     ],
                   ),
                 ),)
                ],
              ),
            ),
            SizedBox(height: 8,)
          ],
        ),
      ),
    );*/

    return Text('Durai');
  }
}
