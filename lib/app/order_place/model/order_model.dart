//Placing order for someone
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kulfii_app/app/product/model/variant_model.dart';
import 'package:kulfii_app/app_resources/app_strings.dart';

class OrderModel{
  String productId;
  String userId;
  String userAdrress;
  String userContact;
  String userEmail;
  String userName;
  Timestamp orderTime;
  int productQuantity;
  VariantModel variant;
  String orderId;
  OrderModel({
   required this.productId,
  required  this.userId,
  required this.userAdrress,
  required this.userContact,
  required this.userEmail,
  required this.userName,
  required this.orderTime,
  required this.productQuantity,
  required this.variant,
  required this.orderId,
  });

  Map<String, dynamic>  toJson() => {
    "product_id":productId,
    "customer_uid": userId,
    "user_address": userAdrress,
    "user_contact": userContact,
    "user_email": userEmail,
    "user_name": userName,
    "order_time": orderTime,
    "product_quantity": productQuantity,
    "variant": variant.toJson(),
    
  };
  //from firebase
  static OrderModel fromJson(Map<String, dynamic> orderData, String orderId) {
    print("${orderData[AppConstant.VARIANT]}--- variant");
    return OrderModel(
      productId: orderData[ AppConstant.PRODUCT_ID] ?? "",
      productQuantity: orderData[ AppConstant.PRODUCT_QUANTITY] ?? 0,
      userId: orderData[ AppConstant.CUSTOMER_UID]?? "", 
      orderTime: orderData[ AppConstant.ORDER_TIME]?? Timestamp.now(),
      orderId: orderId,
      variant: VariantModel.fromSnap(orderData[AppConstant.VARIANT]?? {}), 
      userAdrress: orderData[ AppConstant.USER_ADDRESS] ?? "", 
      userEmail: orderData[ AppConstant.USER_EMAIL] ?? "",
      userContact:orderData[ AppConstant.USER_CONTACT] ?? "",
      userName:orderData[ AppConstant.USER_NAME] ?? "",
      );
      
  }




}