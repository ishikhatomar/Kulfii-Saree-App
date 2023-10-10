import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:kulfii_app/app/auth/model/user_model.dart';


class UserController extends GetxController {
  Rx<UserModel> _user =  UserModel.fromSnap({}).obs;
 //create getter
 UserModel get  user => _user.value;

 set setUserData(value){
_user.value = value;
 }
  addToCart(String productId,int quantity){
    String uid=FirebaseAuth.instance.currentUser!.uid;
  for(int i=0;i<user.cart.length;i++){

    if(user.cart[i]["product_id"]==productId){
      FirebaseFirestore.instance.collection("users").doc(uid).update({"cart":FieldValue.arrayRemove([
        user.cart[i]
      ])});
      return;
    }
  }


    FirebaseFirestore.instance.collection("users").doc(uid).update({"cart":FieldValue.arrayUnion([{
        "product_id":productId,
        "quantity":quantity,
        "time_stamp":Timestamp.now()
      }])});
  return;
 }


 addToWishList(String productId)
 {
 String uid=FirebaseAuth.instance.currentUser!.uid;
  for(int i=0;i<user.wishList.length;i++){

    if(user.wishList[i]["product_id"]==productId){
      FirebaseFirestore.instance.collection("users").doc(uid).update({"wish_list":FieldValue.arrayRemove([
        user.wishList[i]
      ])});
      return;
    }
    
  }
  FirebaseFirestore.instance.collection("users").doc(uid).update({"wish_list":FieldValue.arrayUnion([{
        "product_id":productId,
        "time_stamp":Timestamp.now()
      }])});
  return;
 }
}