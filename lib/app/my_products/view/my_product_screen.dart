import 'package:flutter/material.dart';
import 'package:kulfii_app/app/my_products/view/my_cart_screen.dart';
import 'package:kulfii_app/app/my_products/view/my_wish_list_screen.dart';
import 'package:kulfii_app/app_resources/app_colors.dart';
import 'package:kulfii_app/app_resources/app_dimension.dart';
import 'package:kulfii_app/app_resources/app_strings.dart';

class MyProductScreen extends StatelessWidget {
  const MyProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return DefaultTabController(

      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.black,
         toolbarHeight: AppDimension.px30,
          elevation: 1,
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.search)),
           

          ],
          
          bottom:   TabBar(
            
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            indicatorWeight: 4,
            indicator: BoxDecoration(
              border: Border.all(color: Colors.white)
            ),
            unselectedLabelColor: Colors.white,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            splashFactory: NoSplash.splashFactory,
            tabs: [
            Tab(text: AppString.myCart),
            Tab(text: AppString.saved,),
            
          ]),
          
        ),
        body: TabBarView(
          children: [
           MyCartScreen(),
           MyWishListScreen(),

        ]),
      ),
    );
  }
}