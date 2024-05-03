import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travo_app/constant/utils/image_constant.dart';
import 'package:travo_app/routes/route_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool isOnboarding;
  // late StreamSubscription<bool> _streamSubscription;
  // late StreamController<bool> _streamController;

  @override
  void initState() {
    super.initState();
    // _streamController = StreamController<bool>();
    fetchDataAndNavigate();
  }

  Future<void> fetchDataAndNavigate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isOnboarding = prefs.getBool('isOnboarding') ?? false;
    Future.delayed(const Duration(seconds: 1), () {
      context.pushReplacement(
        isOnboarding ? RoutName.homeRouteName : RoutName.onBoardingRouteName,
      );
    });

    // _streamController.add(isOnboarding);

    // _streamSubscription = _streamController.stream.listen((bool value) {
    //   context.pushReplacement(
    //     isOnboarding ? RoutName.homeRouteName : RoutName.onBoardingRouteName,
    //   );
    // });
  }

  // @override
  // void dispose() {
  //   _streamSubscription.cancel();
  //   _streamController.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        ImageConstant.splashImg,
        fit: BoxFit.fill,
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
