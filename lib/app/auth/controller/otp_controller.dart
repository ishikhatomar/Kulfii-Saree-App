
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kulfii_app/app/auth/controller/login_controller.dart';

import 'package:kulfii_app/app/splash/view/splash_screen.dart';

class OTPController extends GetxController{
  Rx<TextEditingController> inputOtpController = TextEditingController().obs;
  
  get verifyOTP async {
    LoginController loginController = Get.find<LoginController>();
    if (inputOtpController.value.text.length > 5) {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: loginController.verId.value, smsCode: inputOtpController.value.text),
      );
      if (FirebaseAuth.instance.currentUser != null) {
        Get.offAll(SplashScreen());
      }
    }
    
  }
}