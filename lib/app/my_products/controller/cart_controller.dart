import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kulfii_app/app/auth/controller/user_controller.dart';
import 'package:kulfii_app/app/my_products/model/cart_model.dart';
import 'package:kulfii_app/app/product/model/product_model.dart';

class CartController extends GetxController {
  Future<List<CartModel>> get fetchMyCartList async {
    UserController userController = Get.put(UserController());
    List<CartModel> mycart = [];
    for (int i = 0; i < userController.user.cart.length; i++) {
      DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection("products")
          .doc(userController.user.cart[i]["product_id"])
          .get();
      mycart.add(CartModel.fromMap(userController.user.cart[i],
          ProductModel.fromJson(data.data() as Map<String, dynamic>, data.id)));
    }
    return mycart;
  }

  int totalItemCount = 0;
  int countPriceofCartItems(List<CartModel> list) {
    int totalPrice = 0;
totalItemCount=0;
    for (int i = 0; i < list.length; i++) {
      totalItemCount = totalItemCount + list[i].quantity;
      totalPrice =
          totalPrice + (list[i].product!.productShownPrice) * list[i].quantity;
    }
    return totalPrice;
  }
}

