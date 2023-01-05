import 'dart:math';

import 'package:dwarikesh/components/app_bar_widget.dart';
import 'package:dwarikesh/model/agri_implements_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AgriImplementsDetail extends StatelessWidget {
  Data model = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    AppBarWidget(
                      imageUrl: model.productImage,
                    ),
                  ];
                },
                body: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${model.productName ?? ''}',
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: '${'total_vendors'.tr} : ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            '${model.vendordata!.length ?? ''}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold)),
                                    // can add more TextSpans here...
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 50),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: model.vendordata!.length,
                            itemBuilder: (context, index) {
                              // ignore: missing_return
                              var data = model.vendordata![index];
                              var count = index + 1;

                              return detailTile(
                                  context,
                                  count,
                                  data.vendorName!,
                                  data.vendorPhoneNumber!,
                                  data.vendorAddress!,
                                  data.productServiceCost ?? "0");
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailTile(BuildContext context, int index, String vendorName,
      String vendorPhoneNumber, String vendorAddress, String cost) {
    TextStyle headerStyle = kTextStyleSubtitle1.copyWith(
      color: textColor,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    );
    TextStyle valueStyle = kTextStyleSubtitle1.copyWith(
      color: textColor,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    Size size = MediaQuery.of(context).size;
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
                color: Color(0x20000000), blurRadius: 1, offset: Offset(0, 3))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
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
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        'https://img.icons8.com/bubbles/2x/user-male.png'),
                    //NetworkImage
                    radius: 24,
                  ), //CircleAvatar
                  //CircleAvatar
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    '${'vendor'.tr} - ${index ?? ''}',
                    style: TextStyle(
                      color: primaryColorDark,
                      fontSize: 14,
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
          SizedBox(
            height: 25,
          ),
          if (vendorName != '' && vendorName != null)
            dataTile('name'.tr, vendorName ?? ''),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'phone'.tr,
                      overflow: TextOverflow.ellipsis,
                      style: headerStyle,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      vendorPhoneNumber ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: valueStyle,
                    ),
                  ],
                ),
                vendorPhoneNumber != '' &&
                        vendorPhoneNumber != null &&
                        vendorPhoneNumber.length >= 10
                    ? Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              onTap: () {
                                launch("tel://" + vendorPhoneNumber);
                              },
                              child: Container(
                                width: 56,
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
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
                                      Icons.call,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      'call'.tr,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          SizedBox(
            height: 18,
          ),
          if (vendorAddress != '' && vendorAddress != null)
            dataTile('village'.tr, vendorAddress ?? ''),
          if (cost != '' && cost != null)
            dataTile('service_cost'.tr, cost ?? ''),
        ],
      ),
    );
  }

  Widget dataTile(String title, String message) {
    TextStyle headerStyle = kTextStyleSubtitle1.copyWith(
      color: textColor,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    );
    TextStyle valueStyle = kTextStyleSubtitle1.copyWith(
      color: textColor,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: headerStyle,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            message ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: valueStyle,
          ),
          SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }
}
