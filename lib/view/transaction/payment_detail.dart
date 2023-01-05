import 'package:dwarikesh/model/transaction_list_model.dart';
import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class PaymentDetails extends StatefulWidget {
  @override
  _PaymentDetailsState createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  PageController? _pageController;
  int initialPage = Prefs.getInt('index') ?? 1;
  String title = Prefs.getString('transationTile') ?? 'my_data_lists'.tr;
  List<Values> model = Get.arguments;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      // so that we can have small portion shown on left and right side
      viewportFraction: 0.9,
      // by default our movie poster
      initialPage: initialPage,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: Toolbar(
        title: title,
        leftsideIcon: backIcon,
        leftsideBtnPress: () {
          Get.back();
        },
      ),
      body: Center(
          child: Container(
        child: PageView.builder(
            onPageChanged: (value) {
              setState(() {
                initialPage = value;
              });
            },
            controller: _pageController,
            physics: ClampingScrollPhysics(),
            itemCount: model.length,
            // we have 3 demo movies
            itemBuilder: (context, index) => Stack(
                  children: [
                    SingleChildScrollView(
                      child: buildMovieSlider(index),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                model.length > 1
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '<- swip left',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      )
                                    : Container(),
                                Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        '${initialPage + 1}',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        ' / ',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        '${model.length}',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                ),
                                model.length > 1
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Text('swip right ->',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700)),
                                      )
                                    : Container()
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        )),
                  ],
                )),
      )),
    ));
  }

  Widget buildMovieSlider(int index) => AnimatedBuilder(
        animation: _pageController!,
        builder: (context, child) {
          double value = 0;
          if (_pageController!.position.haveDimensions) {
            value = index - _pageController!.page!;
            value = (value * 0.050).clamp(-1, 3);
          }
          return AnimatedOpacity(
            duration: Duration(milliseconds: 350),
            opacity: initialPage == index ? 1 : 0.1,
            child: Transform.rotate(
              angle: math.pi * value,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x20000000),
                              blurRadius: 5,
                              offset: Offset(0, 3))
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${model[index].millPurchyNumber}',
                            style: TextStyle(
                                color: textColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w600)),
                        Container(
                          child: Text(
                            '${model[index].paymentdate}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  '\u{20B9}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              FittedBox(
                                child: Text('${model[index].paidAmount}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 46,
                                        fontWeight: FontWeight.w600)),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text('Payment Details',
                            style: TextStyle(
                                color: primaryColorDark,
                                fontSize: 24,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Payment Date : ',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '${model[index].paymentdate}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Mill Purchy No : ',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '${model[index].millPurchyNumber}',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Loan Deducted : ',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '${model[index].loanDeduction}',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Due Amount : ',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '${model[index].dueAmount}',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Paid Amount : ',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '${model[index].paidAmount}',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Center : ',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '${model[index].villageCode}',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    )),
              ),
            ),
          );
        },
      );
}
