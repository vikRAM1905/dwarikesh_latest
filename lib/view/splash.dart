import 'dart:async';

import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:dwarikesh/utils/textUtils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  Animation? _logoAnimation;
  AnimationController? _logoAnimationController;

  bool _initialized = false;
  bool _error = false;
  String? errorMsg;

  @override
  void initState() {
    super.initState();

    _logoAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _logoAnimation = Tween(begin: 0.0, end: 200.0).animate(CurvedAnimation(
        curve: Curves.bounceOut, parent: _logoAnimationController!));

    _logoAnimationController!.addStatusListener((AnimationStatus status) {});
    _logoAnimationController!.forward();

    initializeFlutterFire();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        print(' FIRE BASE INIT = ENABLE');
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        print('ERROR $e');
        //errorMsg = e;
        _error = true;
      });
    }
  }

  void navigationPage() {
    setState(() {
      if (_initialized) if (Prefs.getString(AUTH_CODE) != null &&
          Prefs.getString(AUTH_CODE) != '')
        Get.offAllNamed(ROUTE_HOME);
      else
        Get.offAllNamed(ROUTE_LOGIN);
      else if (_error) print('ERROR FIRE BASE INIT = $_error');
    });
  }

  @override
  void dispose() {
    super.dispose();
    //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    _logoAnimationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: primaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            secondChild(size),

            // companyName(size)
          ],
        ),
      ),
    );
  }

  Widget secondChild(Size size) {
    Size size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _logoAnimationController!,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.only(left: 30, right: 20, bottom: 5),
          width: double.infinity,
          height: 130.h,
          child: Center(
            child: Image.asset(
              splashBg,
              width: double.infinity,
              height: 130.h,
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }

  Widget companyName(Size size) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.fromLTRB(70, 0, 0, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'समृद्ध किसान सुदृढ़ उद्योग खुशहाल देश',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: TextUtils.titleTextWeight,
                  fontSize: TextUtils.hintTextSize,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
