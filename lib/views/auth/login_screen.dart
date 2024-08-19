import 'package:emartapp/consts/consts.dart';
import 'package:emartapp/consts/social_icons_list.dart';
import 'package:emartapp/views/auth/signup_screen.dart';
import 'package:emartapp/views/home_screen.dart';
import 'package:emartapp/widgets/app_logo_widget.dart';
import 'package:emartapp/widgets/bg_widget.dart';
import 'package:emartapp/widgets/custom_button.dart';
import 'package:emartapp/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight*0.1).heightBox,
              appLogoWidget(),
              10.heightBox,
              "$logIn to $appName".text.fontFamily(bold).white.size(18).make(),
              20.heightBox,
              Column(
                children: [
                  customTextfield(
                    title: email,
                    titleHint: emailHint,
                    controller: emailController,
                  ),
                  customTextfield(
                    title: password,
                    titleHint: passwordHint,
                    controller: passwordController,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: (){},
                        child: forgetPassword.text.color(Colors.indigoAccent).make()
                    ),
                  ),
                  5.heightBox,
                  customButton(
                    color: redColor,
                    title: logIn,
                    textColor: whiteColor,
                    onPress: (){
                      Get.to(()=> const HomeScreen());
                    },
                  ).box.width(context.screenWidth-50).make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  customButton(
                    color: lightGolden,
                    title: signUp,
                    textColor: redColor,
                    onPress: (){
                      Get.to(() => const SignupScreen());
                    },
                  ).box.width(context.screenWidth-50).make(),
                  10.heightBox,
                  logInWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                      List.generate(
                        3,
                          (index)=> Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              backgroundColor: lightGrey,
                              radius: 25,
                              child: Image.asset(
                                socialIconsList[index],
                                width: 30,
                              ),
                            ),
                          )
                      )
                  )

                ],
              ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth-70).shadowSm.make(),
            ],
          ),
        ),
      )
    );
  }
}
