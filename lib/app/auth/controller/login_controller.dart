import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kulfii_app/app/auth/view/otp_screen.dart';

class LoginController extends GetxController {
  RxString verId = "".obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  get verifyPhoneNumber async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumberController.value.text,
        verificationCompleted: (AuthCredential authCred) {},
        verificationFailed: (FirebaseAuthException authException) {},
        codeSent: (String? verificationId, [int? forcecodersent]) async {
          verId.value = verificationId!;
          Get.to(OTPScreen());
        },
        codeAutoRetrievalTimeout: (String? verificationId) {});
  }
}
