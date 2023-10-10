import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kulfii_app/app/my_products/controller/wish_list_controller.dart';
import 'package:kulfii_app/app/my_products/model/wish_list_model.dart';
import 'package:kulfii_app/app/product/model/product_model.dart';
import 'package:kulfii_app/app_resources/app_colors.dart';
import 'package:kulfii_app/app_resources/app_dimension.dart';

class MyWishListScreen extends StatelessWidget {
  MyWishListScreen({super.key});
  WishListController wishListController = Get.put(WishListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<WishListModel>>(
          future: wishListController.fetchMyWishList,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return GridView.builder(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                childAspectRatio: 150 / 250,
              ),
              itemBuilder: ((context, index) {
                return  Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              snapshot.data![index].product!.getImageFromVariantModel.first,
                              // height: 55,
                              // width: 55,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Rs ${snapshot.data![index].product!.productShownPrice}", 
                            ),
                          ],
                        ));
              }),
            );
          }),
    );
  }
}
