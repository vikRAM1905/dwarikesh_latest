import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/controller/yard_controller.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/model/yard_status_model.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YardStatus extends StatelessWidget {
  final YardStatusController controller = Get.put(YardStatusController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: Toolbar(
          title: "yard_status".tr,
          leftsideIcon: backIcon,
          leftsideBtnPress: () {
            Get.back();
          },
        ),
        body: GetBuilder<YardStatusController>(
          builder: (controller) => SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.responseCode == '200' &&
                  controller.resListData.length > 0)
                Container(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                  margin: EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'vehicle_type'.tr,
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'standing_vehicles'.tr,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'yard_balance_qty'.tr,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      // Spacer(),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'token'.tr,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Container(
                child: Divider(),
              ),
              if (controller.responseCode == '200')
                if (controller.resListData.length > 0)
                  ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: kToolbarHeight + 10),
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: controller.resListData.length,
                      itemBuilder: (context, index) {
                        var data = controller.resListData[index];
                        return dataTile(context, data);
                      })
                else
                  ErrorMessage(
                    errorCode: '403',
                  )
              else if (controller.responseCode == '404')
                ErrorMessage(
                  errorCode: '404',
                )
              else if (controller.responseCode == '500')
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
      ),
    );
  }

  Widget dataTile(BuildContext context, Data data) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      margin: EdgeInsets.all(8),
      /*decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 0.5, //                   <--- border width here
        ),
      ),*/ //
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              data.data1 ?? '',
              style: TextStyle(
                color: primaryColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: 30,
            margin: EdgeInsets.all(6),
            padding: EdgeInsets.all(4),
            child: Divider(),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                data.data3 ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                data.data4 ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                data.data5 ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
          /*   Text.rich(
                TextSpan(
                  text: '',
                  style: Theme.of(context).textTheme.bodyText1,
                  children: <TextSpan>[
                    TextSpan(
                      text: data.data2 ?? '',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    if (data.data2 != '' && data.data2 != null)
                      TextSpan(
                          text: ' | ',
                          style: Theme.of(context).textTheme.bodyText1),
                    TextSpan(
                        text: data.data3 ?? '',
                        style: Theme.of(context).textTheme.bodyText1),
                    if (data.data3 != '' && data.data3 != null)
                      TextSpan(
                          text: ' | ',
                          style: Theme.of(context).textTheme.bodyText1),
                    TextSpan(
                        text: data.data4 ?? '',
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),*/
        ],
      ),
    );
  }
}
