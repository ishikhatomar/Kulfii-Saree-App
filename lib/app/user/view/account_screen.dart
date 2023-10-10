

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kulfii_app/app/my_order_history/view/my_order_history_screen.dart';
import 'package:kulfii_app/app/user/view/edit_account_info_screen.dart';
import 'package:kulfii_app/app_resources/app_colors.dart';
import 'package:kulfii_app/app_resources/app_dimension.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        backgroundColor: AppColor.blue,
      
        title: Text("Account"),
      ),
      body: Container(
        margin: EdgeInsets.all(AppDimension.px20),
        child: ListView(
          children: [
           Row(
             children: [
               Container(
                height: AppDimension.px45,
                width: AppDimension.px45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.black
                ),
                
               ),
               SizedBox(width: AppDimension.px20,),
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Shikha Tomar", style: TextStyle(fontWeight: FontWeight.w600, fontSize: AppDimension.px22),),
                  Text("shikha03tomar@gmail.com"),
                ],
               ),
                Spacer(),
                 IconButton(onPressed: (){
                  Get.to(()=>EditAccountInfoScreen());
                 }, icon: Icon(Icons.edit),)
             ],
           ),
          Divider(thickness: AppDimension.px0_1, color: AppColor.grey,),
            InkWell(
              onTap: () {
                Get.to(()=>MyOrderHistoryScreen());
              },
              child: Text("My order history")),
           
            
          ],
        ),
      ),
    );
  }
}