import 'package:emartapp/consts/consts.dart';
import 'package:emartapp/controller/home_controller.dart';
import 'package:emartapp/view/cart/cart_screen.dart';
import 'package:emartapp/view/category/category_screen.dart';
import 'package:emartapp/view/home/home_screen.dart';
import 'package:emartapp/view/profile/profile_screen.dart';
import 'package:emartapp/widgets/exit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {


  @override
  Widget build(BuildContext context) {

    var controller = Get.put(HomeController());

    var navBarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home
      ),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: categories
      ),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: cart
      ),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account
      ),
    ];

    var navBody =[
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: ()async{
        showDialog(
          barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context)
        );
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(()=>
                Expanded(
                  child: navBody.elementAt(controller.currentNavIndex.value)
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(()=>
           BottomNavigationBar(
             currentIndex: controller.currentNavIndex.value,
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            items: navBarItem,
             onTap: (value){
              controller.currentNavIndex.value = value;
             },
          ),
        ),
      ),
    );
  }
}
