import 'dart:developer';

import 'package:kulfii_app/app_resources/app_strings.dart';


class VariantModel{
   String variantName;
   String variantId;
   List<String> variantImages;
   int variantStock;
   String colorName;
  
  VariantModel( {
   required this.variantName,
   required  this.variantId, 
   required  this.variantImages, 
   required  this.variantStock, 
   required  this.colorName});

   Map<String, dynamic> toJson()=>{
    AppConstant.VARIANT_NAME: variantName,
    AppConstant.VARIANT_ID: variantId,
    AppConstant.VARIANT_IMAGES: variantImages,
    AppConstant.VARIANT_STOCK: variantStock,
    AppConstant.COLOR_NAME: colorName,
   };

   static VariantModel fromSnap( Map<String, dynamic> variantDetail){
    print("${variantDetail} print-----");
    return VariantModel(
      variantName: variantDetail[ AppConstant.VARIANT_NAME]??"", 
      variantId: variantDetail[ AppConstant.VARIANT_ID]??"", 
      variantImages:  ((variantDetail[ AppConstant.VARIANT_IMAGES] ?? []) as List).cast<String>(),
      variantStock: variantDetail[AppConstant.VARIANT_STOCK] ?? 0, 
      colorName: variantDetail[AppConstant.COLOR_NAME]??"",
      );
   }
}