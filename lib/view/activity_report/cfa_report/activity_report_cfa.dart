import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'dart:ui';

import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/components/graph_progress.dart';
import 'package:dwarikesh/components/graph_progressDetail.dart';
import 'package:dwarikesh/controller/activity_report_cfa_controller.dart';
import 'package:dwarikesh/model/activity_graph_cfa.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/utils/textUtils.dart';

import 'package:dwarikesh/widgets/progressPainter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart';

class ActivityReportCfa extends StatelessWidget {
  final ActivityReportCfaController _controller =
      Get.put(ActivityReportCfaController());

  @override
  Widget build(BuildContext context) {
    String userRole = Prefs.getString(ROLE_ID);
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
    final double itemWidth = size.width / 3;

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: new AppBar(
        title: Text(
          'activity_report'.tr,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() => Stack(
            children: [
              SingleChildScrollView(
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
                                children: <int, Widget>{
                                  0: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15.0,
                                        right: 10,
                                        top: 15,
                                        bottom: 15),
                                    child: Text(
                                      'village'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: _controller
                                                          .tabPosition.value ==
                                                      0
                                                  ? Colors.black
                                                  : grey,
                                              fontSize:
                                                  TextUtils.commonTextSize,
                                              fontWeight: _controller
                                                          .tabPosition.value ==
                                                      0
                                                  ? TextUtils.titleTextWeight
                                                  : TextUtils.normalTextWeight),
                                    ),
                                  ),
                                  1: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15.0,
                                        right: 10,
                                        top: 15,
                                        bottom: 15),
                                    child: Text(
                                      'activity'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: _controller
                                                          .tabPosition.value ==
                                                      1
                                                  ? Colors.black
                                                  : grey,
                                              fontSize:
                                                  TextUtils.commonTextSize,
                                              fontWeight: _controller
                                                          .tabPosition.value ==
                                                      1
                                                  ? TextUtils.titleTextWeight
                                                  : TextUtils.normalTextWeight),
                                    ),
                                  ),
                                  2: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15.0,
                                        right: 10,
                                        top: 15,
                                        bottom: 15),
                                    child: Text(
                                      'day'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: _controller
                                                          .tabPosition.value ==
                                                      2
                                                  ? Colors.black
                                                  : grey,
                                              fontSize:
                                                  TextUtils.commonTextSize,
                                              fontWeight: _controller
                                                          .tabPosition.value ==
                                                      2
                                                  ? TextUtils.titleTextWeight
                                                  : TextUtils.normalTextWeight),
                                    ),
                                  ),
                                },
                                groupValue: _controller.tabPosition.toInt(),
                                onValueChanged: (val) {
                                  _controller.updatetabPosition(
                                      int.parse(val.toString()));
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
                        (_controller.tabPosition == 0 ||
                                _controller.tabPosition == 1)
                            ? Padding(
                                padding: EdgeInsets.all(16),
                                child: GridView.count(
                                  shrinkWrap: true,
                                  childAspectRatio: (itemWidth / itemHeight),
                                  controller: new ScrollController(
                                      keepScrollOffset: false),
                                  physics: NeverScrollableScrollPhysics(),
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 2,
                                  children: List.generate(
                                      _controller.tabPosition == 0
                                          ? _controller.villageListData.length
                                          : _controller.activityListData.length,
                                      (index) {
                                    var data = _controller.tabPosition == 0
                                        ? _controller.villageListData[index]
                                        : _controller.activityListData[index];
                                    return _controller.tabPosition == 0
                                        ? MenuTile(
                                            model: data,
                                          )
                                        : MenuTile(
                                            model: data,
                                          );
                                  }),
                                ),
                              )
                            : DayWiseData()
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
              _controller.tabPosition == 2 &&
                      _controller.dateWiseActivity.length > 0
                  ? SizedBox.expand(
                      child: DraggableScrollableSheet(
                        initialChildSize: 0.5,
                        minChildSize: 0.5,
                        maxChildSize: 0.8,
                        builder: (BuildContext context, myscrollController) {
                          return Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 20, bottom: 20),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'activity_details'.tr,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: primaryColorDark,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            top: 0.0,
                                            right: 0.0,
                                            child: InkWell(
                                              onTap: () {
                                                _controller.dateWiseActivity
                                                    .value = [];
                                                _controller.update();
                                              },
                                              child: Container(
                                                child: Icon(Icons.clear),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 5,
                                    width: 100,
                                    color: Colors.grey[400],
                                    margin:
                                        EdgeInsets.only(top: 10, bottom: 20),
                                  ),
                                  Center(
                                    child: Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                                      // border:TableBorder.all(width: 2.0,color: Colors.red),
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            child: Text(
                                              'activity_type'.tr,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: textColor,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            padding: EdgeInsets.all(5),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              child: Text(
                                                'no_of_plots'.tr,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: textColor,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              padding: EdgeInsets.all(5),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              child: Text(
                                                'total_area'.tr,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: textColor,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              padding: EdgeInsets.all(5),
                                            ),
                                          )
                                        ]),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [],
                                    ),
                                  ),
                                  Flexible(
                                      child: ListView.builder(
                                    controller: myscrollController,
                                    itemCount:
                                        _controller.dateWiseActivity.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var data =
                                          _controller.dateWiseActivity[index];

                                      return Center(
                                        child: Table(
                                          defaultVerticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                                          // border:TableBorder.all(width: 2.0,color: Colors.red),
                                          children: [
                                            TableRow(children: [
                                              Container(
                                                child: Text(
                                                  data.name!,
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                                padding: EdgeInsets.all(5),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  child: Text(
                                                    data.approvedplots
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: textColor,
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.all(5),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  child: Text(
                                                    data.canearea!,
                                                    style: TextStyle(
                                                      color: textColor,
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.all(5),
                                                ),
                                              )
                                            ]),
                                          ],
                                        ),
                                      );
                                    },
                                  ))
                                ],
                              ));
                        },
                      ),
                    )
                  : Container()
            ],
          )),
    ));
  }
}

class MenuTile extends StatefulWidget {
  Activities? model;
  final _controller = Get.put(ActivityReportCfaController());

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
        if (widget._controller.tabPosition != 0) {
          Prefs.setString(CFA_ID, Prefs.getString(USER_ID));
          Prefs.setString(VILLAGE_ID, '');
          Prefs.setString(ACTIVITY_ID, widget.model!.id.toString());
          Prefs.setString(TITLE, 'villagewise_list'.tr);
        } else {
          Prefs.setString(CFA_ID, Prefs.getString(USER_ID));
          Prefs.setString(VILLAGE_ID, widget.model!.id.toString());
          Prefs.setString(ACTIVITY_ID, '');
          Prefs.setString(TITLE, 'activitywise_list'.tr);
        }

        Get.toNamed(ROUTE_ACTIVITY_OR_VILLAGE_CFA_REPORT);
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
                activity: widget.model!.totalactivity.toString(),
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

class DayWiseData extends StatefulWidget {
  @override
  _DayWiseDataState createState() => _DayWiseDataState();
}

class _DayWiseDataState extends State<DayWiseData> {
  DateTime _currentDate = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();

//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  final controller = Get.put(ActivityReportCfaController());
  List<DateTime> presentDates = [];

  @override
  void initState() {
    for (int i = 0; i < controller.dateListData.value.length; i++) {
      presentDates.add(DateTime(
          int.parse(controller.dateListData.value[i].year!),
          int.parse(controller.dateListData.value[i].month!),
          int.parse(controller.dateListData.value[i].date!)));
    }

    super.initState();
  }

  _presentIcon(String day) => CircleAvatar(
        backgroundColor: primaryColor,
        child: Text(
          day,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  @override
  Widget build(BuildContext context) {
    /// Example Calendar Carousel without header and custom prev & next button
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      onDayPressed: (date, events) {
        setState(() {
          _currentDate = date;
        });
        controller.dayWiseActivity(date);

        events.forEach((event) => print(event.title));
      },
      weekdayTextStyle: TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.black87,
        fontSize: 16,
      ),
      weekendTextStyle: TextStyle(
          fontWeight: FontWeight.w600, color: Colors.redAccent, fontSize: 14),
      daysTextStyle: TextStyle(
          fontWeight: FontWeight.w600, color: textColor, fontSize: 14),
      thisMonthDayBorderColor: Colors.red,
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),

      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle:
          TextStyle(color: primaryColor, fontWeight: FontWeight.w700),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      // markedDateMoreShowTotal:
      //     true,
      todayButtonColor: Colors.transparent,

      minSelectedDate: _currentDate.subtract(Duration(days: 60)),
      maxSelectedDate: _currentDate.add(Duration(days: 1)),
      showOnlyCurrentMonthDate: true,
      inactiveDaysTextStyle: TextStyle(
        color: Colors.grey,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
    );

    if (presentDates.length > 0) {
      for (int i = 0; i < presentDates.length; i++) {
        _markedDateMap.add(
          presentDates[i],
          new Event(
            date: presentDates[i],
            title: presentDates[i].toString(),
            icon: _presentIcon(
              presentDates[i].day.toString(),
            ),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        //custom icon

        Container(
          margin: EdgeInsets.only(
            top: 30.0,
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          child: new Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                _currentMonth,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontSize: 18.0,
                ),
              )),
              InkWell(
                onTap: () {
                  setState(() {
                    _targetDateTime = DateTime(
                        _targetDateTime.year, _targetDateTime.month - 1);
                    _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                  });
                },
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: 50,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _targetDateTime = DateTime(
                        _targetDateTime.year, _targetDateTime.month + 1);
                    _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                  });
                },
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: _calendarCarouselNoHeader,
        ),
      ],
    );
  }
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';

  String get allInCaps => this.toUpperCase();

  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => str.capitalize).join(" ");
}
