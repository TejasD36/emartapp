import 'package:emartapp/consts/consts.dart';
import 'package:flutter/material.dart';

import '../../consts/colors.dart';
import '../../widgets/custom_button.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(
          color: darkFontGrey, // Set the desired color here
      ),
      title: "Payment Methods".text.color(darkFontGrey).fontFamily(bold).make(),
      ),

      bottomNavigationBar: SizedBox(
        height: 60,
        child: customButton(
          title: "Place my Order",
          textColor: whiteColor,
          color: redColor,
          onPress: (){

          },
        ),
      ),
    );
  }
}
