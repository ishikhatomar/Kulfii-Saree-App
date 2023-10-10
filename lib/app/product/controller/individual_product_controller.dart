import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kulfii_app/app/product/model/product_model.dart';

class IndividualProductController extends GetxController{
 Rx<int> count =1.obs;
 void increment(int stock){
  if(count.value<stock)
      count.value++
; }
void decrement(){
  if(count.value>1)
  count.value--;
}

} 