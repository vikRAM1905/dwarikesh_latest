import 'dart:math';

import 'package:dwarikesh/components/error_message.dart';
import 'package:dwarikesh/components/graph_progress.dart';
import 'package:dwarikesh/components/graph_progressDetail.dart';
import 'package:dwarikesh/controller/activity_or_village_cfa_report_controller.dart';
import 'package:dwarikesh/model/activity_or_village_cfa_report_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/progressPainter.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityorVillagewiseCFAReport extends StatelessWidget {
  final _controller = Get.put(ActivityorVillageCFAReportController());

  final GlobalKey _menuKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
    final double itemWidth = size.width / 3;
    return SafeArea(
      child: Scaffold(
        appBar: Toolbar(
          title: Prefs.getString(TITLE),
          leftsideIcon: backIcon,
          leftsideBtnPress: () {
            Get.back();
          },
        ),
        body: SingleChildScrollView(
          child: Obx(() => Column(
                children: [
                  if (_controller.responseCode == '200')
                    if (_controller.resListData.length > 0)
                      Padding(
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
                              _controller.resListData.length, (index) {
                            var data = _controller.resListData[index];
                            return MenuTile(
                              model: data,
                            );
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
              )),
        ),
      ),
    );
  }
}

class MenuTile extends StatefulWidget {
  Data? model;

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
        if (Prefs.getString(TITLE) == 'villagewise_list'.tr) {
          Prefs.setString(VILLAGE_ID, widget.model!.id.toString());
        } else {
          Prefs.setString(ACTIVITY_ID, widget.model!.id.toString());
        }

        Prefs.setString(TITLE_GOWER_OR_NAME, 'grower_list'.tr);

        Get.toNamed(ROUTE_ACTIVITY_CFA_REPORT_GROWER_LIST);
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
