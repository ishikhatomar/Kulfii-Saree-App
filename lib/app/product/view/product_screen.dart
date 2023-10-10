import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kulfii_app/app/auth/controller/user_controller.dart';
import 'package:kulfii_app/app/product/controller/product_controller.dart';
import 'package:kulfii_app/app/product/model/product_model.dart';
import 'package:kulfii_app/app/product/view/individual_product_screen.dart';
import 'package:kulfii_app/app_resources/app_colors.dart';
import 'package:kulfii_app/app_resources/app_dimension.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});
  ProductController productController = Get.put(ProductController());
  UserController userController =Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    
    return 
    Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.blue,
        title: Text("Kulfii"),
      ),
      body: FutureBuilder<List<ProductModel>>(
          future: productController.fetchProductCollection(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return 
            GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: 150 / 280,
                ),
                itemBuilder: (context, index) {
                  RxBool saved = snapshot.data![index].isSavedInWishList.obs;
                  return
                  Obx(() => InkWell(
                    onTap: () => Get.to(() => IndividualProductScreen(
                        productDetails: snapshot.data![index])),
                    child: Container(
                      color: AppColor.textFormFieldColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Hero(
                                tag: "location-img-${snapshot.data![index].getImageFromVariantModel
                                      .first}",
                                child: Image.network(
                                  snapshot.data![index].getImageFromVariantModel
                                      .first,
                                  height: AppDimension.px280,
                                  width: AppDimension.px250,
                                  //fit: Box,
                                ),
                              ),
                              Positioned(
                                  right: 5,
                                  bottom: 2,
                                  child: InkWell(
                                    onTap: () {
                                      saved.value= !saved.value;
                                  userController.addToWishList(snapshot.data![index].docId);
                                },
                                    child:  Icon(
                                      Icons.bookmark_outlined,
                                      color: saved.value? AppColor.blue: AppColor.white,
                                    ),
                                  )),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: AppDimension.px7, top: AppDimension.px5),
                            width: AppDimension.px120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data![index].productName}",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  "Rs ${snapshot.data![index].productShownPrice}",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
                });
          }),
    );
 
  }
}
