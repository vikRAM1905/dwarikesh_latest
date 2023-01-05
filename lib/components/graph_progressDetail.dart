import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GraphProgressDetail extends StatelessWidget {
  String? approve, pending, plot, activity;
  Function()? onPress;

  GraphProgressDetail(
      {this.approve, this.pending, this.plot, this.onPress, this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey[100]!,
            width: 1,
          )),
      child: Stack(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            '${'total_activities'.tr} - ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: textColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '${activity}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            '${'activity_completed'.tr} - ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: textColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '${plot}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            '${'pending'.tr} - ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: textColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '${pending}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            '${'approved'.tr} - ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: textColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '${approve}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),

// can add more TextSpans here...
                  ],
                ),
              )),
          Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: onPress,
                child: Container(
                  width: 35,
                  height: 35,
                  child: Icon(Icons.cancel_outlined, color: textColor),
                ),
              )),
        ],
      ),
    );
  }
}
