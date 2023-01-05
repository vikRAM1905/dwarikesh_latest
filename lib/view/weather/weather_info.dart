import 'package:dwarikesh/controller/weather_controller.dart';
import 'package:dwarikesh/model/weather_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class WeatherInfo extends StatelessWidget {
  final _controller = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: Toolbar(
              title: 'weather_forecast'.tr,
              leftsideIcon: backIcon,
              leftsideBtnPress: () {
                Get.back();
              },
            ),
            body: SingleChildScrollView(
              child: Obx(() => _controller.responseCode.value == '200'
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                          cityRefresh(),
                          CurrentConditions(),
                          otherCondition(),
                          Container(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: TabBar(
                              isScrollable: true,
                              labelPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              unselectedLabelColor: Colors.grey,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [primaryColor, primaryColorDark]),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              unselectedLabelStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              controller: _controller.tabController,
                              tabs: _controller.resListData.value
                                  .map((e) => Tab(text: e.title))
                                  .toList(),
                            ),
                          ),
                          Container(
                              height: 190,
                              child: TabBarView(
                                controller: _controller.tabController,
                                children:
                                    _controller.resListData.value.map((Data e) {
                                  return ListTile(model: e.report!);
                                }).toList(),
                              ))
                        ])
                  : Container()),
            )));
  }

  Widget cityRefresh() {
    return Container(
      margin: EdgeInsets.only(top: 25, bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.location_on_rounded, color: textColor),
          Text(
            _controller.city.value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.w600, color: textColor, fontSize: 20),
          ),
          SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () {
              _controller.getWeatherApi();
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.refresh, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }

  Widget otherCondition() {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ValueTile(
            "Min Temp",
            '${_controller.min.value}°',
            iconData: 'assets/svg_images/temp.svg',
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            child: Center(
                child:
                    Container(width: 1, height: 30, color: Colors.grey[300])),
          ),
          ValueTile(
            "Max Temp",
            '${_controller.max.value}°',
            iconData: 'assets/svg_images/temp.svg',
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            child: Center(
                child:
                    Container(width: 1, height: 30, color: Colors.grey[300])),
          ),
          ValueTile(
            "Wind Speed",
            '${_controller.windSpeed.value} ${_controller.windUnit.value}',
            iconData: 'assets/svg_images/wind.svg',
          ),
        ],
      ),
    );
  }
}

class CurrentConditions extends StatelessWidget {
  final _controller = Get.put(WeatherController());

  CurrentConditions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.width / 3,
          child: SvgPicture.asset(
              WeatherModel.getIconcode(_controller.icon.value)),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          _controller.currentDetail.value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: textColor,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${_controller.currentWeather.value}°',
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w700,
                    color: textColor),
              ),
              Text(
                '${_controller.weatherType.value}',
                style: TextStyle(
                    fontSize: 31,
                    fontWeight: FontWeight.w600,
                    color: textColor),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class ValueTile extends StatelessWidget {
  final String? label;
  final String? value, iconData;

  ValueTile(this.label, this.value, {this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        this.iconData != null
            ? Container(
                width: 30,
                height: 30,
                child: SvgPicture.asset(iconData!),
              )
            : Container(
                width: 30,
                height: 30,
              ),
        SizedBox(
          height: 10,
        ),
        Text(
          this.label!,
          style: TextStyle(
              color: textColor, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          this.value!,
          style: TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class ListTile extends StatelessWidget {
  List<Report>? model;
  ListTile({this.model});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: model!.length,
          itemBuilder: (context, index) {
            var data = model![index];
            return ChildTile(
              model: data,
            );
          }),
    );
  }
}

class ChildTile extends StatelessWidget {
  Report? model;

  ChildTile({this.model});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: MediaQuery.of(context).size.width / 3,
      margin: EdgeInsets.only(top: 15, left: 5, right: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5)),
          color: Colors.grey[100]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(model!.zone.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: TextUtils.commonTextSize,
                  fontWeight: TextUtils.mediumtTextWeight,
                  color: textColor)),
          SizedBox(
            height: 10,
          ),
          model!.icon != null
              ? Container(
                  width: 58,
                  height: 58,
                  child:
                      SvgPicture.asset(WeatherModel.getIconcode(model!.icon!)),
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${model!.temp.toString()}° ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: textColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
