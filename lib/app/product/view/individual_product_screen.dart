import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kulfii_app/app/product/controller/individual_product_controller.dart';
import 'package:kulfii_app/app/product/controller/product_controller.dart';
import 'package:kulfii_app/app/product/model/product_model.dart';
import 'package:kulfii_app/app/order_place/view/product_ordering_screen.dart';
import 'package:kulfii_app/app_resources/app_colors.dart';
import 'package:kulfii_app/app_resources/app_dimension.dart';
import 'package:transparent_image/transparent_image.dart';

class IndividualProductScreen extends StatelessWidget {
  IndividualProductScreen({super.key, required this.productDetails});
  final ProductModel productDetails;
  IndividualProductController individualProductController =
      Get.put(IndividualProductController());
  ProductController productController = Get.put(ProductController());
  RxInt selectedProduct = 0.obs;
  RxInt imageNumber = 0.obs;
  @override
  Widget build(BuildContext context) {
    RxBool saved = productDetails.isAddedInCart.obs;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: BackButton(),
        ),
        body: ListView(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
               
                Container(
                   width: double.infinity,

  child: Hero(
    tag: "location-img-${productDetails.variant[selectedProduct.value].variantImages[imageNumber.value]}",
    child: FadeInImage.memoryNetwork(
      placeholder: kTransparentImage, // You can use a placeholder image
      image: productDetails.variant[selectedProduct.value].variantImages[imageNumber.value],
      fit: BoxFit.fitWidth, // You can adjust the fit as needed
    ),
  ),
),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (imageNumber.value > 0) {
                            imageNumber.value--;
                          }
                        },
                        icon: Container(
                           padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,shape: BoxShape .circle),
                          child: Icon(Icons.arrow_back_ios))),
                    IconButton(
                        onPressed: () {
                          if (imageNumber.value <
                              productDetails.variant[selectedProduct.value]
                                  .variantImages.length-1) {
                            imageNumber.value++;
                          }
                        },
                        icon: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,shape: BoxShape.circle),
                          child: Icon(Icons.arrow_forward_ios,size: 18,))),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(productDetails.variant[selectedProduct.value].variantImages.length, (index) => Icon(Icons.circle,size: 18,color:index==imageNumber.value? Colors.red:Colors.black54,)),),
            Container(
              margin: EdgeInsets.only(
                  left: AppDimension.px15, right: AppDimension.px10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.share),
                      SizedBox(
                        width: AppDimension.px15,
                      ),
                      InkWell(
                        child: Icon(
                          Icons.bookmark_outlined,
                          color: AppColor.blue,
                          size: AppDimension.px25,
                        ),
                      ),
                      SizedBox(
                        width: AppDimension.px10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppDimension.px10,
                  ),
                  Text(
                    productDetails.productName,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimension.px18),
                  ),
                  Row(
                    children: List.generate(
                        productDetails.variant.length,
                        (index) => InkWell(
                            onTap: () {
                              selectedProduct.value = index;
                              imageNumber.value=0;
                            },
                            child: Container(
                                color: selectedProduct.value == index
                                    ? Colors.red
                                    : Colors.grey.shade500,
                                padding: EdgeInsets.all(3),
                                margin: EdgeInsets.all(2),
                                child: Image.network(
                                  productDetails.variant[index]
                                      .variantImages.first,
                                  height: 100,
                                )))),
                  ),
                  SizedBox(
                    height: AppDimension.px10,
                  ),
                  Text("Rs. ${productDetails.productShownPrice}"),
                  SizedBox(
                    height: AppDimension.px10,
                  ),
                  Text("Fabric: ${productDetails.productFabric}"),
                  SizedBox(
                    height: AppDimension.px10,
                  ),
                  Text(
                      "Color: ${productDetails.variant[selectedProduct.value].colorName}"),
                  SizedBox(
                    height: AppDimension.px10,
                  ),
                  Text(
                      "Size: Saree length 5.5 mtrs with 0.80 mtrs running blouse"),
                  SizedBox(
                    height: AppDimension.px10,
                  ),
                  Text(
                      "Stock Avaiable: ${productDetails.variant[selectedProduct.value].variantStock}"),
                  SizedBox(
                    height: AppDimension.px10,
                  ),
                  InkWell(
                    onTap: () {
                      saved.value = !saved.value;
                      productController.storeSaveItemsonFirebase(
                          productDetails.docId,
                          individualProductController.count.value);
                    },
                    child: Container(
                      height: AppDimension.px50,
                      color: AppColor.black,
                      child: Center(
                        child: saved.value
                            ? Text(
                                "Added",
                                style: TextStyle(color: AppColor.white),
                              )
                            : Text(
                                "Add to cart",
                                style: TextStyle(color: AppColor.white),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppDimension.px10,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.0, color: AppColor.black),
                        ),
                        height: AppDimension.px50,
                        width: AppDimension.px80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: productDetails.isAddedInCart
                                  ? () {
                                      Get.snackbar("Already added",
                                          "please remove from your cart in order to edit quantity then add again");
                                    }
                                  : () {
                                      individualProductController.decrement();
                                    },
                              child: Text(
                                "-",
                                style: TextStyle(fontSize: AppDimension.px30),
                              ),
                            ),
                            SizedBox(
                              width: AppDimension.px10,
                            ),
                            Text(
                              " ${individualProductController.count.value}",
                              style: TextStyle(fontSize: AppDimension.px18),
                            ),
                            SizedBox(
                              width: AppDimension.px10,
                            ),
                            InkWell(
                                onTap: productDetails.isAddedInCart
                                    ? () {
                                        Get.snackbar("Already added",
                                            "please remove from your cart in order to edit quantity then add again");
                                      }
                                    : () {
                                        individualProductController.increment(
                                            productDetails
                                                .variant[selectedProduct.value]
                                                .variantStock);
                                      },
                                child: Text(
                                  "+",
                                  style: TextStyle(fontSize: AppDimension.px20),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: AppDimension.px20,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => ProductOrderingScreen(
                                productDetails: productDetails,
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 1.0,
                              ),
                              color: AppColor.blue),
                          height: AppDimension.px50,
                          width: AppDimension.px250,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.shopping_bag,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: AppDimension.px90,
                              ),
                              Text(
                                "Buy",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: AppDimension.px22),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppDimension.px25,
                        vertical: AppDimension.px10),
                    height: AppDimension.px120,
                    color: AppColor.textFormFieldColor,
                    margin: EdgeInsets.symmetric(
                        vertical: AppDimension.px20,
                        horizontal: AppDimension.px10),
                    child: Column(
                      children: [
                        Text(
                            "Saree Fall & Pico ss- ₹250 (COD & returns or exchanges are not available for this option)"),
                        SizedBox(
                          height: AppDimension.px15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: AppColor.blue,
                          ),
                          height: AppDimension.px35,
                          width: AppDimension.px80,
                          child: Center(child: Text("ADD")),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Product Description:",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(productDetails.productDescription),
                  SizedBox(
                    height: AppDimension.px10,
                  ),
                  Text('Delivery and Returns'),
                  SizedBox(
                    height: AppDimension.px30,
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
                .instance
                .collection("products")
                .where('cart',
                    arrayContains: {'uid': "1234", "quantity": 4}).get();

            log("${data.docs.length}------data");
          },
          child: Icon(Icons.send),
        ),
      ),
    );
  }
}
