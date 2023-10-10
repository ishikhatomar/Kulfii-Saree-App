import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kulfii_app/app/my_products/view/my_product_screen.dart';
import 'package:kulfii_app/app/product/view/product_screen.dart';
import 'package:kulfii_app/app/user/view/account_screen.dart';
import 'package:kulfii_app/app_resources/app_colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  Rx<int> _selectedIndex = 0.obs;
  List<Widget> _screens = [
    //  HomeScreen(),
    Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
    ),
    ProductScreen(),
    MyProductScreen(),
    AccountScreen(),
  ];
  PageController _pageController = PageController();
  void onPageChanged(int index) {
    _selectedIndex.value = index;
  }

  void _onItemTapped(int i) {
    _pageController.jumpToPage(i);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: PageView(
          controller: _pageController,
          children: _screens,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex.value,
          onTap: _onItemTapped,
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.black54,
         
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.black,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.save_outlined,
              ),
              label: "Products",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star_border_outlined),
              label: "Wish List",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_2_outlined,
              ),
              label: "Account",
            ),
          ],
        ),
      ),
    );
  }
}
