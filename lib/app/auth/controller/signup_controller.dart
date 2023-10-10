import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kulfii_app/app/auth/model/user_model.dart';
import 'package:kulfii_app/app/home/home_screen.dart';

class SignupController extends GetxController {
  Rx<TextEditingController> usernameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
    Rx<TextEditingController> ageController = TextEditingController().obs;
  
  get saveUserInfoToFirestore async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      String phoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber!;

      await FirebaseFirestore.instance.collection("users").doc(uid).set(
          UserModel(
                  username: usernameController.value.text,
                  uid: uid,
                  phoneNumber: phoneNumber,
                  email: emailController.value.text, 
                  address:[],
                  age:ageController.value.text,
                  profileImageUrl: '',
                  cart: [],
                  wishList: [])
              .toJson());
      Get.offAll(HomeScreen());
    } catch (e) {
      Get.dialog(Text(e.toString()));
    }
  }
}
