import 'package:emartapp/consts/consts.dart';
import 'package:emartapp/controller/cart_controller.dart';
import 'package:emartapp/view/cart/payment_method.dart';
import 'package:emartapp/widgets/custom_button.dart';
import 'package:emartapp/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/colors.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({super.key});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  @override
  Widget build(BuildContext context) {

    var controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: darkFontGrey, // Set the desired color here
        ),
        title: "Shipping Details".text.color(darkFontGrey).fontFamily(bold).make(),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            customTextfield(title: "Address", titleHint: "Address",controller: controller.addressController),
            customTextfield(title: "City", titleHint: "City",controller: controller.cityController),
            customTextfield(title: "State", titleHint: "State",controller: controller.stateController),
            customTextfield(title: "Postal Code", titleHint: "Postal Code",controller: controller.postalCodeController),
            customTextfield(title: "Phone", titleHint: "Phone",controller: controller.phoneController),
          ],
        ),
      ),

      bottomNavigationBar: SizedBox(
        height: 60,
        child: customButton(
          title: "Continue",
          textColor: whiteColor,
          color: redColor,
          onPress: (){
            if(
              controller.addressController.text.isNotEmpty
              && controller.cityController.text.isNotEmpty
              && controller.stateController.text.isNotEmpty
              && controller.postalCodeController.text.isNotEmpty
              && controller.phoneController.text.isNotEmpty
            ){
              Get.to(()=> const PaymentMethod());
            }
            else {
              VxToast.show(context, msg: "Please fill the form");
            }
          },
        ),
      ),
    );
  }
}
