import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kulfii_app/app/auth/controller/user_controller.dart';
import 'package:kulfii_app/app/product/model/variant_model.dart';
import 'package:kulfii_app/app_resources/app_strings.dart';


class ProductModel {
  final String productName;
  final Timestamp timeStamp;
  final List<String> productVideo;
  final List<VariantModel> variant;
  final String productDescription;
  final String productFabric;
  final List<String> productOccasion;
  final int productShownPrice;
  final int productActualPrice;
  final List<Map<String, int>> productByAge;
  final String docId;
  final List<String> userCart;

  ProductModel({
    required this.productName,
    required this.timeStamp,
    required this.productVideo,
    required this.productDescription,
    required this.productFabric,
    required this.variant,
    required this.productOccasion,
    required this.productByAge,
    required this.productShownPrice,
    required this.productActualPrice,
    required this.docId,
    required this.userCart,
  });

  //to write in firebase
  Map<String, dynamic> toJson() => {
        AppConstant.PRODUCT_NAME: productName,
       
        AppConstant.PRODUCT_VIDEO: productVideo,
        AppConstant.PRODUCT_DESCRIPTION: productDescription,
        AppConstant.PRODUCT_FABRIC: setFabric,
        AppConstant.VARIANT:convertVariantModelToListOfMap(variant),
        AppConstant.PRODUCT_OCCASION: setOccasion,
        AppConstant.PRODUCT_BY_AGE: productByAge,
        AppConstant.PRODUCT_SHOWN_PRICE: productShownPrice,
        AppConstant.PRODUCT_ACTUAL_PRICE: productActualPrice,
        "time_stamp": timeStamp,
        "user_cart":userCart,

      };

  //to retreive from firebase
  static ProductModel fromJson(Map<String, dynamic> detail, String docId) {
    return ProductModel(
      productName: detail[AppConstant.PRODUCT_NAME] ?? '',
     
       
      productVideo: 
          ((detail[AppConstant.PRODUCT_VIDEO] ?? []) as List).cast<String>(),
      productDescription: detail[AppConstant.PRODUCT_DESCRIPTION] ?? '',
       productFabric:  getFabric(
        detail[AppConstant.PRODUCT_FABRIC] ?? '',
      ),
      variant: convertToListOfVariantModel(detail[AppConstant.VARIANT]),
       productOccasion: getOccasion(
        ((detail[AppConstant.PRODUCT_OCCASION] ?? []) as List).cast<String>(),
      ),
      timeStamp: detail["time_stamp"]?? Timestamp.now(),
      productByAge: [], //detail[AppConstant.PRODUCT_BY_AGE] ?? 0,
      productShownPrice: detail[AppConstant.PRODUCT_SHOWN_PRICE] ?? 0,
      productActualPrice: detail[AppConstant.PRODUCT_ACTUAL_PRICE] ?? 0,
       docId: docId,
       userCart:  ((detail[AppConstant.PRODUCT_OCCASION] ?? []) as List).cast<String>(), 
    );
  }



  List<Map<String, dynamic>> get _convertToListOfMap {
    List<Map<String, dynamic>> _tempList = [];
    for (int i = 0; i < variant.length; i++) {
      _tempList.add(variant[i].toJson());
    }
    return _tempList;
  }

//to show user
  static String getFabric(String fab) =>
      {
        AppConstant.SILK: AppString.silkFabric,
        AppConstant.GEORGETTE: AppString.georgettefabric,
        AppConstant.NET: AppString.netFabric,
        AppConstant.KHADI: AppString.khadiFabric,
        AppConstant.LINEN: AppString.linenFabric,
        AppConstant.SATIN: AppString.satinFabric,
        AppConstant.COTTON: AppString.cottonFabric,
        AppConstant.JAMDANI: AppString.jamdaniFabric,
        AppConstant.KANJEEVARAM: AppString.kanjeevaramFabric,
        AppConstant.BANARASI: AppString.banarasiSilkFabric,
      }[fab] ??
      "";
//for firebase
   String get setFabric =>
      {
        AppString.silkFabric: AppConstant.SILK,
        AppString.georgettefabric: AppConstant.GEORGETTE,
        AppString.netFabric: AppConstant.NET,
        AppString.khadiFabric: AppConstant.KHADI,
        AppString.linenFabric: AppConstant.LINEN,
        AppString.satinFabric: AppConstant.SATIN,
        AppString.cottonFabric: AppConstant.COTTON,
        AppString.jamdaniFabric: AppConstant.JAMDANI,
        AppString.kanjeevaramFabric: AppConstant.KANJEEVARAM,
        AppString.banarasiSilkFabric: AppConstant.BANARASI,
      }[productFabric] ??
      "";

//to show user
  static List<String> getOccasion(List<String> occasion) {
    List<String> _temp = [];

    for (int i = 0; i < occasion.length; i++) {
      _temp.add(
          {AppConstant.OFFICIAL: AppString.officialOccasion,
           AppConstant.COCKTAIL: AppString.cocktailOccasion,
          AppConstant.FESTIVE:AppString.festiveOccasion,
          }[occasion[i]] ?? "");
    }
    return _temp;
  }
  //for firebase
 List<String> get setOccasion {
  List<String> _temp = [];
    for (int i = 0; i < productOccasion.length; i++) {
      _temp.add( {
      AppString.officialOccasion: AppConstant.OFFICIAL, 
      AppString.cocktailOccasion: AppConstant.COCKTAIL,
      AppString.festiveOccasion: AppConstant.FESTIVE
      }[productOccasion[i]] ??
      "");
    }
    return _temp;
 }
 //convert variantModel to List<map>
 List<Map<String,dynamic>> convertVariantModelToListOfMap(List<VariantModel> myList){
  return List.generate(myList.length, (index) => myList[index].toJson());
 }

 //convert list<map> to variantModel
 static List<VariantModel> convertToListOfVariantModel(List<dynamic> myList) {
log("${myList}--------------------");
  return List.generate(myList.length, (index) => VariantModel.fromSnap(myList[index]));
 }

List<String> get getImageFromVariantModel {
  List<String> imgList = [];
  print("${variant.first.variantImages}-----xyz");
  for(int i =0; i<variant.length; i++){
    for(int j=0;j<variant[i].variantImages.length;j++){
imgList.add(variant[i].variantImages[j]);
    }
    
  }
 
return imgList;
}

bool get isAddedInCart{
  UserController userController = Get.put(UserController());
  for(int i =0; i<userController.user.cart.length; i++){
    if(userController.user.cart[i]["product_id"]==docId){
      return true;
    }
  }
  return false;
 
}
 bool get isSavedInWishList{
  UserController userController = Get.put(UserController());
  for(int i =0; i<userController.user.wishList.length; i++){
    if(userController.user.wishList[i]["product_id"]==docId){
      return true;
    }
  }
  return false;
 
}
     
}
