import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kulfii_app/app/product/model/product_model.dart';
import 'package:kulfii_app/app_resources/app_strings.dart';

class WishListModel {
  final String productId;
  final Timestamp timeStamp;
  ProductModel? product;
  WishListModel({
    required this.productId, 
    required this.timeStamp,
    this.product,
    });

  Map<String, dynamic> toMap() => {
        AppConstant.PRODUCT_ID: productId,
        "time_stamp": timeStamp,
      };

  static WishListModel fromMap(Map<String, dynamic> wishList, ProductModel? product) {
    return WishListModel(
      productId: wishList[AppConstant.PRODUCT_ID] ?? "",
      timeStamp: wishList["time_stamp"] ?? Timestamp.now(),
      product: product
    );
  }
}
