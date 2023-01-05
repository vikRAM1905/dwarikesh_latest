import 'package:dwarikesh/model/dash_card.dart';
import 'package:dwarikesh/model/dashboard_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardCard extends StatelessWidget {
  final Menu? dashCard;
  final Function? onPress;

  const DashboardCard({Key? key, @required this.dashCard, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClickEVent(dashCard!.id!, url: dashCard!.link);
      },
      child: IntrinsicHeight(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 5),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Color(0xFFDADADA)),
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: double.infinity,
                child: Row(
                  children: [
                    Container(
                        width: 40,
                        height: 40,
                        // alignment: Alignment.center,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: FadeInImage.assetNetwork(
                            placeholder:
                                'assets/images/circle_image_loading.png',
                            image: dashCard!.icon!,
                          ),
                        )),
                    Spacer(),
                    dashCard!.count != ''
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Text(
                              dashCard!.id == 3 ||
                                      dashCard!.id == 13 ||
                                      dashCard!.id == 9
                                  ? '${dashCard!.count.toString()}°C'
                                  : dashCard!.count.toString() ??
                                      DATA_NULL_HANDLER,
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w800),
                            ),
                          )
                        : SizedBox(
                            height: 5,
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: Text(
                  dashCard!.id == 3 || dashCard!.id == 13 || dashCard!.id == 9
                      ? dashCard!.title.toString() ?? 'dwarikesh'
                      : dashCard!.title.toString() ?? DATA_NULL_HANDLER,
                  // textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
                // padding: EdgeInsets.only(left: 10, right: 10),
              ),
              // dashCard!.count != ''
              //     ? Text(
              //         dashCard!.id == 3 ||
              //                 dashCard!.id == 13 ||
              //                 dashCard!.id == 9
              //             ? '${dashCard!.count.toString()}°C'
              //             : dashCard!.count.toString() ?? DATA_NULL_HANDLER,
              //         // textAlign: TextAlign.center,
              //         style: TextStyle(
              //             color: primaryColorDark,
              //             fontSize: 18.0,
              //             fontWeight: FontWeight.w800),
              //       )
              //     : SizedBox(
              //         height: 5,
              //       ),
            ],
          ),
        ),
      ),
    );
  }

  void onClickEVent(String id, {String? url}) {
    switch (id) {
      case "1":
        {
          Get.toNamed(ROUTE_REQUEST_LIST);
          break;
        }
      case "2":
        {
          Get.toNamed(ROUTE_ACTIVITY_LIST_GROWER);
          break;
        }
      case "3":
        {
          Get.toNamed(ROUTE_WEATHER);
          break;
        }
      case "4":
        {
          Get.toNamed(ROUTE_ANNOUNCEMENTS_LIST);
          break;
        }
      case "5":
        {
          //instance Diagnois
          break;
        }
      case "6":
        {
          // weather info
          break;
        }
      case "7":
        {
          Get.toNamed(ROUTE_REQUEST_LIST);
          break;
        }
      case "8":
        {
          Get.toNamed(ROUTE_ACTIVITY_CFA_GROWER);
          break;
        }
      case "9":
        {
          Get.toNamed(ROUTE_WEATHER);
          break;
        }
      case "10":
        {
          Get.toNamed(ROUTE_ANNOUNCEMENTS_LIST);
          break;
        }
      case "11":
        {
          Get.toNamed(ROUTE_REQUEST_LIST);
          break;
        }
      case "12":
        {
          Get.toNamed(ROUTE_ACTIVITY_CFA_GRAPH);
          break;
        }
      case "13":
        {
          Get.toNamed(ROUTE_WEATHER);
          break;
        }
      case "14":
        {
          Get.toNamed(ROUTE_ANNOUNCEMENTS_LIST);
          break;
        }
      case "18":
        {
          if (url != null && url.isNotEmpty) {
            launch(
              url,
              forceSafariVC: false,
              universalLinksOnly: false,
            );
          }
          break;
        }
      case "19":
        {
          launch("tel://" + url!);
          break;
        }
      case "20":
        {
          Get.toNamed(ROUTE_YARD_ACTIVIY);
          break;
        }
      case "21":
        {
          Get.toNamed(ROUTE_FAQ);
          break;
        }
    }
  }
}
