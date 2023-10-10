import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kulfii_app/app/auth/model/user_model.dart';
import 'package:kulfii_app/app/product/model/product_model.dart';
import 'package:kulfii_app/app/order_place/model/order_model.dart';

class OrderPlaceController extends GetxController{
  saveOrderDetailsToFirebase(OrderModel orderDetails){
FirebaseFirestore.instance.collection("orders").add(orderDetails.toJson());

 }
}