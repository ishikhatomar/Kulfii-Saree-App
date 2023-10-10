import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kulfii_app/app/auth/controller/signup_controller.dart';
import 'package:kulfii_app/app_resources/app_colors.dart';
import 'package:kulfii_app/app_resources/app_dimension.dart';
import 'package:kulfii_app/app_resources/app_strings.dart';
import 'package:kulfii_app/app_resources/sizes.dart';

class SignupScreen extends StatelessWidget {
   SignupScreen({super.key});
  SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(AppString.personalDetails),
            TextFormField(
              controller: signupController.emailController.value,
              decoration: InputDecoration(
                hintText: AppString.email,
              ),
            ),
            
             SizedBox(height: AppDimension.px20.h),
            TextFormField(
              controller: signupController.usernameController.value,
              decoration: InputDecoration(
                hintText: AppString.name,
              ),
            ),
             SizedBox(height: AppDimension.px20.h),
            TextFormField(
              decoration: InputDecoration(
                hintText: AppString.pleaseEnterPhone,
              ),
            ),
            SizedBox(height: AppDimension.px50.h),
            InkWell(
              onTap: () => signupController.saveUserInfoToFirestore,
              child: Container(
                height: AppDimension.px50.h,
                width: AppDimension.px150.h,
                color: AppColor.blue,
                child: Center(child: Text(AppString.createAccount),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
