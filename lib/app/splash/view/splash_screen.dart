import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'package:kulfii_app/app/splash/controller/splash_controller.dart';


class SplashScreen extends StatefulWidget {
   SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<SplashScreen> {
     SplashController splashController = Get.put(SplashController());
   @override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     splashController.findInitialScreen;
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold();
  }
}