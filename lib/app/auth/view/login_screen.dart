import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kulfii_app/app/auth/controller/login_controller.dart';

import 'package:kulfii_app/app_resources/app_dimension.dart';
import 'package:kulfii_app/app_resources/app_strings.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: loginController.phoneNumberController.value,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText:AppString.enterphonenumber, 
              ),
            ),
            const SizedBox(height: AppDimension.px30,),
            ElevatedButton(
              
              onPressed: (){
               loginController.verifyPhoneNumber;
              }, child: Center(child:Text(AppString.continueText) ,))
          ],
        ),
      ),
    );
  }
}