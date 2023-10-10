import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kulfii_app/app/auth/controller/user_controller.dart';
import 'package:kulfii_app/app/my_products/model/wish_list_model.dart';
import 'package:kulfii_app/app/product/model/product_model.dart';

class WishListController extends GetxController {
  String myUid = FirebaseAuth.instance.currentUser!.uid;
  storeSaveItemsonFirebase(String productId) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(myUid)
        .collection("wish_list")
        .add({"product_id": productId, "time_stamp": Timestamp.now()});
  }

  Future<List<WishListModel>> get fetchMyWishList async {
    UserController userController = Get.put(UserController());
    List<WishListModel> myWishList = [];
    for (int i = 0; i < userController.user.wishList.length; i++) {
      DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection("products")
          .doc(userController.user.wishList[i]["product_id"])
          .get();
      myWishList.add(WishListModel.fromMap(userController.user.cart[i],
          ProductModel.fromJson(data.data() as Map<String, dynamic>, data.id)));
    }
    return myWishList;
  }
}
