import 'package:emartapp/consts/consts.dart';
import 'package:emartapp/consts/lists.dart';
import 'package:emartapp/consts/strings.dart';
import 'package:emartapp/controller/auth_controller.dart';
import 'package:emartapp/view/auth/login_screen.dart';
import 'package:emartapp/view/navigator_screen.dart';
import 'package:emartapp/widgets/app_logo_widget.dart';
import 'package:emartapp/widgets/bg_widget.dart';
import 'package:emartapp/widgets/custom_button.dart';
import 'package:emartapp/widgets/custom_textfield.dart';
import 'package:emartapp/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  bool? isCheck = false;

  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,

                //App Logo
                appLogoWidget(),
                10.heightBox,
                "$signUp to $appName".text
                    .fontFamily(bold)
                    .white
                    .size(18)
                    .make(),
                20.heightBox,


                Obx(
                  () =>Column(
                    children: [

                      //Name
                      customTextfield(
                        title: name,
                        titleHint: nameHint,
                        controller: nameController,
                      ),

                      //Email
                      customTextfield(
                        title: email,
                        titleHint: emailHint,
                        controller: emailController,
                      ),

                      //Password
                      customTextfield(
                        title: password,
                        titleHint: passwordHint,
                        controller: passwordController,
                        isObscure: true,
                      ),

                      //Retype Password
                      customTextfield(
                        title: rePassword,
                        titleHint: passwordHint,
                        controller: rePasswordController,
                        isObscure: true,
                      ),

                      5.heightBox,

                      //Terms & Conditions
                      Row(
                        children: [
                          Checkbox(
                            value: isCheck,
                            activeColor: redColor,
                            checkColor: whiteColor,
                            onChanged: (newValue) {
                              setState(() {
                                isCheck = newValue;
                              });
                            },
                          ),
                          10.widthBox,
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "I agree to the ",
                                        style: TextStyle(
                                          fontFamily: regular,
                                          color: fontGrey,
                                        )
                                    ),
                                    TextSpan(
                                        text: termsAndCondition,
                                        style: TextStyle(
                                          fontFamily: regular,
                                          color: redColor,
                                        )
                                    ),
                                    TextSpan(
                                        text: " & ",
                                        style: TextStyle(
                                          fontFamily: regular,
                                          color: fontGrey,
                                        )
                                    ),
                                    TextSpan(
                                        text: privacyPolicy,
                                        style: TextStyle(
                                          fontFamily: regular,
                                          color: redColor,
                                        )
                                    )
                                  ]
                              ),
                            ),
                          )
                        ],
                      ),

                      5.heightBox,

                      //Sign Up Button


                      controller.isLoading.value
                          ? loadingIndicator()
                          : customButton(
                        color: isCheck == true ? redColor : lightGrey,
                        title: signUp,
                        textColor: whiteColor,
                        onPress: () async {

                          controller.isLoading(true);
                          if (isCheck != false) {
                            try {
                              await controller.signupMethod(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text,
                              ).then((value) {
                                return controller.storeUserData(
                                  email: emailController.text,
                                  name: nameController.text,
                                  password: passwordController.text,
                                );
                              }).then((value) {
                                controller.isLoading(false);
                                VxToast.show(context, msg: loginSuccessful);
                                Get.offAll(const NavigatorScreen());
                              });
                            }
                            catch (e) {
                              controller.isLoading(false);
                              auth.signOut();
                              VxToast.show(context, msg: e.toString());
                            }
                          }
                        },
                      ).box.width(context.screenWidth - 50).make(),
                      10.heightBox,


                      RichText(
                        text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: alreadyHaveAccount,
                                  style: TextStyle(
                                    fontFamily: bold,
                                    color: fontGrey,
                                  )
                              ),

                              //LogIn
                              TextSpan(
                                  text: logIn,
                                  style: TextStyle(
                                    fontFamily: bold,
                                    color: redColor,
                                  )
                              ),
                            ]
                        ),
                      ).onTap(() {
                        Get.back();
                      }),
                      10.heightBox,

                    ],
                  )
                ).box.white.rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadowSm
                    .make(),
              ],
            ),
          ),
        )
    );
  }
}
