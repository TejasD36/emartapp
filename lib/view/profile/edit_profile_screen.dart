import 'dart:io';

import 'package:emartapp/consts/consts.dart';
import 'package:emartapp/controller/profile_controller.dart';
import 'package:emartapp/widgets/bg_widget.dart';
import 'package:emartapp/widgets/custom_button.dart';
import 'package:emartapp/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/colors.dart';
import '../../consts/strings.dart';

class EditProfileScreen extends StatefulWidget {
  final dynamic data;

  const EditProfileScreen({
    super.key,
    required this.data,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: whiteColor, // Set the desired color here
        ),
        title: editProfile.text.fontFamily(bold).white.make(),
      ),
      body: Obx(
        () => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //Profile Image

              //If data Image and Controller Image empty show default Image
              widget.data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgProfile,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  :
                    //If data Image not empty but Controller Image empty show data Image
                    widget.data['imageUrl'] != '' &&
                          controller.profileImgPath.isEmpty
                      ? Image.network(
                          widget.data['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      :
                      //Else show controller Image (selected from Gallery)
                      Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,

              //Change Image
              customButton(
                title: change,
                color: redColor,
                textColor: whiteColor,
                onPress: () {
                  controller.changeImage(context);
                },
              ),
              const Divider(),
              20.heightBox,

              //Name field
              customTextfield(
                titleHint: nameHint,
                title: name,
                controller: controller.nameController,
              ),

              //Old Password Field
              customTextfield(
                isObscure: true,
                titleHint: passwordHint,
                title: oldPassword,
                controller: controller.oldPasswordController,
              ),

              //New Password Field
              customTextfield(
                isObscure: true,
                titleHint: passwordHint,
                title: newPassword,
                controller: controller.newPasswordController,
              ),
              20.heightBox,

              //Update Profile button
              controller.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 40,
                      child: customButton(
                        title: updateProfile,
                        color: redColor,
                        onPress: () async {
                          controller.isLoading(true);

                          // If image is not selected
                          if(controller.profileImgPath.value.isNotEmpty){
                            await controller.uploadProfileImage();
                          }
                          else{
                            controller.profileImgLink = widget.data['imageUrl'];
                          }


                          //If old password matches Database

                          if(widget.data['password'] == controller.oldPasswordController.text){

                            await controller.changeAuthPassword(
                              email: widget.data['email'],
                              password: controller.oldPasswordController.text,
                              newPassword: controller.newPasswordController.text,
                            );

                            await controller.updateProfile(
                              imgUrl: controller.profileImgLink,
                              name: controller.nameController.text,
                              password: controller.newPasswordController.text,
                            );
                            VxToast.show(context, msg: "Profile Updated");
                          }
                          else{
                            VxToast.show(context, msg: "Wrong Old Password!");
                            controller.isLoading(false);
                          }
                        },
                        textColor : whiteColor,
                      ),
                    ),
              20.heightBox,
            ],
          )
              .box
              .white
              .shadowSm
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(
                top: 50,
                left: 20,
                right: 20,
              ))
              .rounded
              .make(),
        ),
      ),
    ));
  }
}
