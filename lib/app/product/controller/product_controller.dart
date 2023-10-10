import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:kulfii_app/app/auth/controller/user_controller.dart';
import 'package:kulfii_app/app/product/model/product_model.dart';

class ProductController extends GetxController {
  Future<List<ProductModel>> fetchProductCollection() async {
    QuerySnapshot<Map<String, dynamic>> productCollection =
        await FirebaseFirestore.instance.collection("products").get();
    return List<ProductModel>.generate(
        productCollection.docs.length,
        (index) => ProductModel.fromJson(productCollection.docs[index].data(),
            productCollection.docs[index].id));
  }//tumhara dekhna hai
  
  storeSaveItemsonFirebase(String productId, int quantity ){
    UserController userController=Get.put(UserController());
userController.addToCart(productId, quantity);

  }

  


}
