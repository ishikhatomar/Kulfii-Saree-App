

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kulfii_app/app/auth/controller/user_controller.dart';
import 'package:kulfii_app/app/auth/model/user_model.dart';
import 'package:kulfii_app/app/product/model/product_model.dart';
import 'package:kulfii_app/app/order_place/controller/order_place_controller.dart';
import 'package:kulfii_app/app/order_place/model/order_model.dart';
import 'package:kulfii_app/app_resources/app_dimension.dart';
import 'package:kulfii_app/app_resources/custom_widgets/custom_textformfield.dart';

class ProductOrderingScreen extends StatelessWidget {
  ProductOrderingScreen({super.key, required this.productDetails});
  final ProductModel productDetails;

  
  OrderPlaceController orderPlaceController = Get.put(OrderPlaceController());
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    OrderModel orderDetails = OrderModel(
        productId: productDetails.docId,
        userId: _userController.user.uid,
        userAdrress: _userController.user.address.first,
        userContact: _userController.user.phoneNumber,
        userEmail: _userController.user.email,
        userName: _userController.user.username, 
        orderId: '', 
        orderTime: Timestamp.now(), 
        productQuantity: 2, 
        variant: productDetails.variant.first,
        
        
        );
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Buy Product"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: AppDimension.px15),
        child: ListView(
          children: [
            SizedBox(
              height: AppDimension.px30,
            ),
            Text(
              "Name",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            CustomTextFormField(
              onChanged: (value) {
                orderDetails.userName = value;
                
              },
              initialValue: orderDetails.userName,
              hintText: "Enter your Name",
              hintTextFontSize: AppDimension.px18,
            ),
            SizedBox(
              height: AppDimension.px15,
            ),
            Text(
              "Contact number",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            CustomTextFormField(
              onChanged: (value) {
                orderDetails.userContact = value;
                
              },
             initialValue: orderDetails.userContact,
              hintText: "Enter contact number",
              hintTextFontSize: AppDimension.px18,
            ),
            SizedBox(
              height: AppDimension.px15,
            ),
            Text(
              "Address",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            CustomTextFormField(
              onChanged: (value) {
                orderDetails.userAdrress = value;
              },
              initialValue: orderDetails.userAdrress,
              hintText: "Address Line 1",
              hintTextFontSize: AppDimension.px18,
            ),
            SizedBox(
              height: AppDimension.px15,
            ),
            // CustomTextFormField(
            //   controller: userAddressController.value,
            //   hintText: "Address line 2 ",
            //   hintTextFontSize: AppDimension.px18,
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          orderPlaceController.saveOrderDetailsToFirebase(
           orderDetails
          );
          //Get.to(()=> );
        },
        child: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
