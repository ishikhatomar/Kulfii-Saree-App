import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kulfii_app/app/auth/controller/user_controller.dart';
import 'package:kulfii_app/app/auth/model/user_model.dart';
import 'package:kulfii_app/app/auth/view/login_screen.dart';
import 'package:kulfii_app/app/auth/view/signup_screen.dart';
import 'package:kulfii_app/app/home/home_screen.dart';
import 'package:kulfii_app/app/product/view/product_screen.dart';


class SplashController extends GetxController{
  UserController _userController = Get.put(UserController());
onInit(){
  if(FirebaseAuth.instance.currentUser!=null){
     FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots().listen((userdata) {
     if (userdata.exists) {
      _userController.setUserData =
          UserModel.fromSnap(userdata.data() as Map<String, dynamic>);
     
    } 
    
    });

  }
}
 

 get findInitialScreen async {
    if(FirebaseAuth.instance.currentUser!=null){
      String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> userData =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    //data exist on firebase
    if (userData.exists) {
      _userController.setUserData =
          UserModel.fromSnap(userData.data() as Map<String, dynamic>);
      Get.offAll(HomeScreen());
    } 
    else{
      Get.off(SignupScreen());
      
    }
    }
    else{
      Get.offAll(LoginScreen());
    }
  }
}