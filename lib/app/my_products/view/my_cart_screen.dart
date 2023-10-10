import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kulfii_app/app/my_products/controller/cart_controller.dart';
import 'package:kulfii_app/app/my_products/model/cart_model.dart';
import 'package:kulfii_app/app/product/model/product_model.dart';
import 'package:kulfii_app/app_resources/app_colors.dart';
import 'package:kulfii_app/app_resources/app_dimension.dart';

class MyCartScreen extends StatelessWidget {
  MyCartScreen({super.key});
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CartModel>>(
          future: cartController.fetchMyCartList,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            log("${snapshot.data!.length}--length");
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: AppColor.textFormFieldColor,
                          margin: EdgeInsets.only(
                              left: AppDimension.px12,
                              right: AppDimension.px12,
                              top: AppDimension.px13),
                          padding: EdgeInsets.symmetric(
                              horizontal: AppDimension.px7,
                              vertical: AppDimension.px8),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                snapshot.data![index].product!.getImageFromVariantModel
                                    .first,
                                height: AppDimension.px150,
                                width: AppDimension.px100,
                              ),
                              SizedBox(
                                width: AppDimension.px10,
                              ),
                              Container(
                                width: AppDimension.px200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //SizedBox(height: AppDimension.px10,),
                                    Text(
                                      snapshot.data![index].product!.productName,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    Text(
                                        "Price: ${snapshot.data![index].product!.productShownPrice}"),
                                    Text(
                                        "Quantity: ${snapshot.data![index].quantity}"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.greyLight,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0.01,
                        offset: Offset(0, -1),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(
                      left: AppDimension.px10, right: AppDimension.px10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: AppDimension.px5,
                      ),
                      Text("Total Items: ${cartController.totalItemCount}"),
                      Text(
                          "Total Price: ${cartController.countPriceofCartItems(snapshot.data!)}"),
                      SizedBox(
                        height: AppDimension.px10,
                      ),
                      Container(
                        height: AppDimension.px50,
                        color: AppColor.black,
                        child: Center(
                          child: Text(
                            "Proceed to purchase",
                            style: TextStyle(color: AppColor.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
