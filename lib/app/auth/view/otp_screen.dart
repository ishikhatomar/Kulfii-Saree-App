import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kulfii_app/app/auth/controller/otp_controller.dart';
import 'package:kulfii_app/app_resources/app_dimension.dart';
import 'package:kulfii_app/app_resources/app_strings.dart';
import 'package:kulfii_app/app_resources/sizes.dart';

class OTPScreen extends StatelessWidget {
   OTPScreen({super.key});
  OTPController otpController = Get.put(OTPController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:  Column(
          children: [
            Text("Enter OTP"),
            SizedBox(height: 20,),
            TextFormField(
              controller: otpController.inputOtpController.value,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
               
              ),
            ),
             SizedBox(height: AppDimension.px30.h,),
            ElevatedButton(
              
              onPressed: ()=>
               otpController.verifyOTP,
               child: Center(child:Text(AppString.continueText) ,))
          ],
        ),), 
    );
  }
}