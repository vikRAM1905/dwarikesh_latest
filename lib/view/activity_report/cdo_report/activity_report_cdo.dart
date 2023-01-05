import 'dart:math';

import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/components/graph_progress.dart';
import 'package:dwarikesh/components/graph_progressDetail.dart';
import 'package:dwarikesh/controller/activity_report_cdo_list_controller.dart';
import 'package:dwarikesh/model/activity_cdo_report_list.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/progressPainter.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityReportCdoList extends StatelessWidget {
  final _controller = Get.put(ActivityReportCdoListController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
    final double itemWidth = size.width / 3;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: Toolbar(
        title: 'activity_report'.tr,
        leftsideIcon: backIcon,
        leftsideBtnPress: () {
          Get.back();
        },
      ),
      body: Obx(
        () => SingleChildScrollView(
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
                      width: 10,
                    ),
                    Expanded(
                      child: CupertinoSlidingSegmentedControl(
                          padding: EdgeInsets.all(6),
                          children: <int, Widget>{
                            0: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "${'cfa'.tr}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Colors.black,
                                        fontSize: TextUtils.commonTextSize,
                                        fontWeight:
                                            _controller.tabPosition.value == 0
                                                ? TextUtils.titleTextWeight
                                                : TextUtils.normalTextWeight),
                              ),
                            ),
                            1: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                'village'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Colors.black,
                                        fontSize: TextUtils.commonTextSize,
                                        fontWeight:
                                            _controller.tabPosition.value == 1
                                                ? TextUtils.titleTextWeight
                                                : TextUtils.normalTextWeight),
                              ),
                            ),
                            2: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                'activities'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Colors.black,
                                        fontSize: TextUtils.commonTextSize,
                                        fontWeight:
                                            _controller.tabPosition.value == 2
                                                ? TextUtils.titleTextWeight
                                                : TextUtils.normalTextWeight),
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
                height: 15,
              ),
              if (_controller.responseCode == '200')
                if (_controller.resListData.length > 0)
                  _controller.tabPosition == 0
                      ? Padding(
                          padding: EdgeInsets.only(top: 24, bottom: 24),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: _controller.cfaListData.length,
                              itemBuilder: (context, index) {
                                // ignore: missing_return
                                var data = _controller.cfaListData[index];
                                return CfaTile(
                                  model: data,
                                );
                              }),
                        )
                      : Padding(
                          padding: EdgeInsets.all(16),
                          child: GridView.count(
                            shrinkWrap: true,
                            childAspectRatio: (itemWidth / itemHeight),
                            controller:
                                new ScrollController(keepScrollOffset: false),
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            children: List.generate(
                                _controller.tabPosition == 1
                                    ? _controller.activityListData.length
                                    : _controller.villageListData.length,
                                (index) {
                              var data = _controller.tabPosition == 1
                                  ? _controller.activityListData[index]
                                  : _controller.villageListData[index];
                              return _controller.tabPosition == 1
                                  ? MenuTile(
                                      model: data,
                                    )
                                  : _controller.tabPosition == 2
                                      ? MenuTile(
                                          model: data,
                                        )
                                      : Container();
                            }),
                          ),
                        )
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
    ));
  }
}

class MenuTile extends StatefulWidget {
  Activities? model;
  final _controller = Get.put(ActivityReportCdoListController());

  MenuTile({this.model});

  @override
  _MenuTileState createState() => _MenuTileState();
}

class _MenuTileState extends State<MenuTile> {
  bool? _showFrontSide;
  bool? _flipXAxis;

  @override
  void initState() {
    super.initState();
    _showFrontSide = true;
    _flipXAxis = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget._controller.tabPosition != 1) {
          Prefs.setString(VILLAGE_ID, '');
          Prefs.setString(ACTIVITY_ID, widget.model!.id.toString());
          Prefs.setString(TITLE, 'villagewise_list'.tr);
        } else {
          Prefs.setString(VILLAGE_ID, widget.model!.id.toString());
          Prefs.setString(ACTIVITY_ID, '');
          Prefs.setString(TITLE, 'activitywise_list'.tr);
        }

        Get.toNamed(ROUTE_ACTIVITY_OR_VILLAGE_CDO_REPORT);
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        child: _showFrontSide!
            ? GraphProgress(
                percentage: widget.model!.percentage.toString(),
                title: widget.model!.name,
                onpress: () => _switchCard(),
              )
            : GraphProgressDetail(
                approve: widget.model!.approved.toString(),
                pending: widget.model!.pending.toString(),
                plot: widget.model!.actcompleted.toString(),
                activity: widget.model!.totalactivity,
                onPress: () => _switchCard(),
              ),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
      ),
    );
  }

  void _switchCard() {
    setState(() {
      _showFrontSide = !_showFrontSide!;
    });
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis!
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }
}

class CfaTile extends StatefulWidget {
  Activities? model;
  final _controller = Get.put(ActivityReportCdoListController());

  CfaTile({this.model});

  @override
  _CfaTileState createState() => _CfaTileState();
}

class _CfaTileState extends State<CfaTile> {
  bool? _showFrontSide;
  bool? _flipXAxis;

  @override
  void initState() {
    super.initState();
    _showFrontSide = true;
    _flipXAxis = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Prefs.setString(CFA_ID, widget.model!.id.toString());
        Prefs.setString(VILLAGE_ID, "");
        Prefs.setString(ACTIVITY_ID, "");
        Prefs.setString(TITLE_GOWER_OR_NAME,
            ' ${widget.model!.name} - [${widget.model!.id}]');

        Get.toNamed(ROUTE_ACTIVITY_CFA_REPORT_GROWER_LIST);
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        child: _showFrontSide!
            ? _graph()
            : _detail(
                widget.model!.approved.toString(),
                widget.model!.pending.toString(),
                widget.model!.actcompleted.toString(),
                widget.model!.totalactivity.toString()),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
      ),
    );
  }

  void _switchCard() {
    setState(() {
      _showFrontSide = !_showFrontSide!;
    });
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis!
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget _graph() {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Colors.grey[100]!,
            width: 1,
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          progressView(context, size, widget.model!.progress.toString()),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.only(left: 10, top: 30),
                    child: Text.rich(
                      TextSpan(
                        text: widget.model!.name,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                              text: '- [',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)),

                          TextSpan(
                              text: widget.model!.code.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)),
                          TextSpan(
                              text: ']',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16))

                          // can add more TextSpans here...
                        ],
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () {
                      launch("tel://" + widget.model!.phonenumber!);
                    },
                    child: Container(
                      height: 36,
                      width: 90,
                      margin: EdgeInsets.only(left: 10, bottom: 10),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0x20000000),
                                blurRadius: 1,
                                offset: Offset(0, 3))
                          ]),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.call,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '${'call'.tr}',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          Container(
              child: Align(
            alignment: Alignment.bottomLeft,
            child: GestureDetector(
                onTap: _switchCard,
                child: Container(
                  width: 35,
                  height: 35,
                  child: Icon(
                    Icons.error,
                    color: primaryColor,
                  ),
                )),
          ))
        ],
      ),
    );
  }

  progressView(BuildContext context, Size size, String value) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      padding: EdgeInsets.all(5),
      height: 76,
      width: 76,
      child: CustomPaint(
        child: Center(
            child: Text.rich(
          TextSpan(
            text: value,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.bold, fontSize: 24, color: primaryColor),
            children: <TextSpan>[
              TextSpan(
                  text: ' %',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.bold)),
// can add more TextSpans here...
            ],
          ),
        )),
        foregroundPainter: ProgressPainter(
            defaultCircleColor: primaryLightColor,
            percentageCompletedCircleColor: primaryColor,
            completedPercentage: double.parse(value),
            circleWidth: 6.0),
      ),
    );
  }

  Widget _detail(
      String approve, String pending, String plot, String completed) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 4,
                  child: Text.rich(
                    TextSpan(
                      text: '${"activity_completed".tr} : ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: plot,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold)),
                        // can add more TextSpans here...
                      ],
                    ),
                  )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 4,
                  child: Text.rich(
                    TextSpan(
                      text: "${'total_activities'.tr} : ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: completed,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold)),
                        // can add more TextSpans here...
                      ],
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                        onTap: _switchCard,
                        child: Container(
                          width: 35,
                          height: 35,
                          child: Icon(
                            Icons.cancel_outlined,
                            color: primaryColor,
                          ),
                        )),
                  ))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Text.rich(
                    TextSpan(
                      text: '${'approved'.tr} :  ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: approve,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold)),
                        // can add more TextSpans here...
                      ],
                    ),
                  )),
              Expanded(
                  flex: 4,
                  child: Text.rich(
                    TextSpan(
                      text: '${'pending'.tr} : ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: pending,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold)),
                        // can add more TextSpans here...
                      ],
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';

  String get allInCaps => this.toUpperCase();

  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => str.capitalize).join(" ");
}
