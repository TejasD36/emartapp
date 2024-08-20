import 'package:emartapp/consts/consts.dart';
import 'package:emartapp/view/auth/login_screen.dart';
import 'package:emartapp/widgets/app_logo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'navigator_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}




class _SplashScreenState extends State<SplashScreen> {



//Directing to Login Screen

  changeScreen(){
    Future.delayed(
        const Duration(seconds: 3),
            (){
          // Get.to(() => const LoginScreen());
              auth.authStateChanges().listen((User? user){
                if(user == null && mounted){
                  Get.to(() => const LoginScreen());
                }
                else{
                  Get.to(() => const NavigatorScreen());
                }
              });
        }
    );
  }

  @override
  void initState() {

    changeScreen();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(icSplashBg,width: 300,),
            ),
            20.heightBox,
            appLogoWidget(),
            10.heightBox,
            appName.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appVersion.text.white.make(),
            const Spacer(),
            credits.text.fontFamily(semibold).white.make(),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}
