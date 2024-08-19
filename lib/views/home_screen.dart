import 'package:emartapp/consts/consts.dart';
import 'package:emartapp/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


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
      Container(color: Colors.blue),
      Container(color: Colors.amber),
      Container(color: Colors.purple),
      Container(color: Colors.cyan),
    ];

    return Scaffold(
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
    );
  }
}
