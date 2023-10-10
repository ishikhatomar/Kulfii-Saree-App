import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kulfii_app/app/product/model/product_model.dart';

class CartModel{
  String productId;
  int quantity;
  Timestamp timeStamp;
  ProductModel? product;

   CartModel(
    {
      required this.productId,
      required this.quantity,
      required this.timeStamp,
      this.product,
    }
   );

   Map<String, dynamic> toMap() =>{
    "product_id": productId,
    "quantity": quantity,
    "time_stamp": timeStamp,
    
   };

   static CartModel fromMap(Map<String, dynamic> cart, ProductModel? product){
    return CartModel(
      productId: cart["product_id"]??"", 
      quantity: cart["quantity"]?? 1, 
      timeStamp: cart["time_stamp"]?? Timestamp.now(),
      product: product
      );
   }
}