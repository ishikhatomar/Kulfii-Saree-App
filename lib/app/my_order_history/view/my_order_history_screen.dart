import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kulfii_app/app/my_order_history/controller/my_order_history_controller.dart';
import 'package:kulfii_app/app/order_place/model/order_model.dart';
import 'package:kulfii_app/app/product/model/product_model.dart';
import 'package:kulfii_app/app_resources/app_colors.dart';
import 'package:kulfii_app/app_resources/app_dimension.dart';

class MyOrderHistoryScreen extends StatelessWidget {
  MyOrderHistoryScreen({super.key});
  MyOrderHistoryController myOrderHistoryController =
      Get.put(MyOrderHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Order History"),
      ),
      body: FutureBuilder<List<OrderModel>>(
          future: myOrderHistoryController.fetchMyOrderHistory,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            log("${snapshot.data!.length}--length of order history,");
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<ProductModel>(
                      future: myOrderHistoryController
                          .getProductDetailsFromOrderModel(
                              snapshot.data![index].productId),
                      builder: (context, productSnapshot) {
                        if (productSnapshot.data == null) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
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
                                productSnapshot
                                    .data!.getImageFromVariantModel.first,
                                height: AppDimension.px150,
                                width: AppDimension.px100,
                              ),
                              SizedBox(width: AppDimension.px10,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //SizedBox(height: AppDimension.px10,),
                                  Text(productSnapshot.data!.productName),
                                  Text(
                                      "Price: ${productSnapshot.data!.productShownPrice}"),
                                  Text(
                                      "Quantity: ${snapshot.data![index].productQuantity}"),
                                  Text(
                                      "order placed: ${DateFormat('yyyy-MM-dd hh:mm a').format(snapshot.data![index].orderTime.toDate())}"),
                                ],
                              ),
                            ],
                          ),
                        );
                      });
                });
          }),
    );
  }
}
