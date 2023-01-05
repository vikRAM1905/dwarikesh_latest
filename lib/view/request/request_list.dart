import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/components/request_list_tile.dart';
import 'package:dwarikesh/controller/reqest_list_controller.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestList extends StatelessWidget {
  final RequestListController _controller = Get.put(RequestListController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String userRole = Prefs.getString(ROLE_ID);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            userRole == ZONAL_INCHARGE ? "escalations".tr : "farmers_query".tr,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.white),
          ),
          actions: [
            Container(
              width: 56,
              child: GetBuilder<RequestListController>(
                  builder: (controller) => PopupMenuButton(
                        color: Colors.white,
                        itemBuilder: (context) => controller.menuListData.map(
                          (val) {
                            return PopupMenuItem(
                              value: val.type,
                              child: Text(
                                val.type.toString() ?? '',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            );
                          },
                        ).toList(),
                        onSelected: (value) async {
                          print(value);

                          controller.onSearchTextChanged(value.toString());

                          // Note You must create respective pages for navigation
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          child:
                              Icon(Icons.tune, size: 24, color: Colors.white),
                        ),
                      )),
            )
          ],
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => {Get.back()} /* controller.toggle()*/,
          ),
        ),
        floatingActionButton: userRole == GROWER
            ? FloatingActionButton.extended(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                label: Text("newRequest".tr),
                onPressed: () async {
                  await Get.toNamed(ROUTE_REQUEST_ADD);
                },
                icon: Icon(Icons.add),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 0,
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CupertinoSlidingSegmentedControl(
                            padding: EdgeInsets.all(6),
                            children: <int, Widget>{
                              0: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  'open'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color:
                                              _controller.tabPosition.value == 0
                                                  ? Colors.black
                                                  : grey,
                                          fontSize: TextUtils.commonTextSize,
                                          fontWeight:
                                              TextUtils.titleTextWeight),
                                ),
                              ),
                              1: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'resolved'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color:
                                              _controller.tabPosition.value == 1
                                                  ? Colors.black
                                                  : grey,
                                          fontSize: TextUtils.commonTextSize,
                                          fontWeight:
                                              TextUtils.titleTextWeight),
                                ),
                              ),
                            },
                            groupValue: _controller.tabPosition.toInt(),
                            onValueChanged: (val) {
                              _controller
                                  .updatetabPosition(int.parse(val.toString()));
                            }),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                if (_controller.responseCode == '200')
                  if (_controller.reqListData.length > 0)
                    if (_controller.searchListData.length > 0)
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: _controller.searchListData.length,
                          itemBuilder: (context, index) {
                            // ignore: missing_return
                            var data = _controller.searchListData[index];

                            return _controller.tabPosition.value == 1 &&
                                    data.readstatus == 1
                                ? RequestListTile(
                                    model: data,
                                    onPress: () {
                                      _controller.suggestionListData.value =
                                          data.suggestion!.length > 0
                                              ? data.suggestion!
                                              : [];
                                      Get.toNamed(ROUTE_REQUEST_DETAIL,
                                          arguments: data);
                                    },
                                  )
                                : _controller.tabPosition.value == 0 &&
                                        data.readstatus == 0
                                    ? RequestListTile(
                                        model: data,
                                        onPress: () {
                                          _controller.suggestionListData.value =
                                              data.suggestion!.length > 0
                                                  ? data.suggestion!
                                                  : [];
                                          Get.toNamed(ROUTE_REQUEST_DETAIL,
                                              arguments: data);
                                        })
                                    : Container();
                          })
                    else if (_controller.searchListData.length == 0 &&
                        _controller.filterAvailable.value == false)
                      ErrorMessage(
                        errorCode: '403',
                      )
                    else
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: _controller.reqListData.length,
                          itemBuilder: (context, index) {
                            // ignore: missing_return
                            var data = _controller.reqListData[index];

                            return _controller.tabPosition.value == 1 &&
                                    data.readstatus == 1
                                ? RequestListTile(
                                    model: data,
                                    onPress: () {
                                      _controller.suggestionListData.value =
                                          data.suggestion!.length > 0
                                              ? data.suggestion!
                                              : [];
                                      Get.toNamed(ROUTE_REQUEST_DETAIL,
                                          arguments: data);
                                    },
                                  )
                                : _controller.tabPosition.value == 0 &&
                                        data.readstatus == 0
                                    ? RequestListTile(
                                        model: data,
                                        onPress: () {
                                          _controller.suggestionListData.value =
                                              data.suggestion!.length > 0
                                                  ? data.suggestion!
                                                  : [];
                                          Get.toNamed(ROUTE_REQUEST_DETAIL,
                                              arguments: data);
                                        })
                                    : Container();
                          })
                  else
                    ErrorMessage(
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
          ),
        ),
      ),
    );
  }
}
