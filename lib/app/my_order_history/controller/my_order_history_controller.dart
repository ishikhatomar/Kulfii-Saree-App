import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:kulfii_app/app/order_place/model/order_model.dart';
import 'package:kulfii_app/app/product/model/product_model.dart';

class MyOrderHistoryController extends GetxController{
  
 Future<List<OrderModel>> get fetchMyOrderHistory async{
 String myUid = FirebaseAuth.instance.currentUser!.uid;
 log("$myUid -----myuid");
 QuerySnapshot<Map<String, dynamic>> myOrders = await FirebaseFirestore.instance.collection("orders").where("customer_uid", isEqualTo: myUid).get();
 return List.generate(myOrders.docs.length, (index) => OrderModel.fromJson(myOrders.docs[index].data(), myOrders.docs[index].id));
 } 

 Future<ProductModel> getProductDetailsFromOrderModel(String productId)async{
  DocumentSnapshot<Map<String, dynamic>> productDocument = await FirebaseFirestore.instance.collection("products").doc(productId).get();
  return ProductModel.fromJson(productDocument.data() as Map<String,dynamic>, productDocument.id);
  }
}