import 'package:emartapp/consts/consts.dart';
import 'package:emartapp/consts/lists.dart';
import 'package:emartapp/controller/cart_controller.dart';
import 'package:emartapp/view/navigator_screen.dart';
import 'package:emartapp/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

    var controller = Get.find<CartController>();

    return Obx(
      ()=> Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            iconTheme: const IconThemeData(
            color: darkFontGrey, // Set the desired color here
        ),
        title: "Payment Methods".text.color(darkFontGrey).fontFamily(bold).make(),
        ),

        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Obx(
            ()=> Column(
              children: List.generate(
                  paymentMethodsImg.length,
                  (index){
                    return GestureDetector(
                      onTap: (){
                        controller.changePaymentIndex(index);
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: controller.paymentIndex.value == index ? redColor: whiteColor,
                            width: 4,
                          )
                        ),
                        margin: const EdgeInsets.all(8),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.asset(
                              paymentMethodsImg[index],
                              width: double.infinity,
                              colorBlendMode: controller.paymentIndex.value == index ? BlendMode.darken : BlendMode.color,
                              color: controller.paymentIndex.value == index ? Colors.black.withOpacity(0.3) : Colors.transparent,
                              height: 120,
                              fit: BoxFit.cover,
                            ),

                            controller.paymentIndex.value == index
                              ?  Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                    activeColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    value: true,
                                    onChanged: (value){
                                    },
                                  ),
                                )
                              :  Container(),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: paymentMethods[index].text.white.fontFamily(bold).size(16).make()
                            )
                          ]
                        ),
                      ),
                    );
                  },
              ),
            ),
          ),
        ),

        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
          ? Center(child: loadingIndicator(),)
          : customButton(
              title: "Place my Order",
              textColor: whiteColor,
              color: redColor,
              onPress: () async{
                await controller.placeMyOrder(
                    orderPaymentMethod: paymentMethods[controller.paymentIndex.value],
                    totalAmount: controller.totalP.value
                );


                VxToast.show(context, msg: "Order placed Successfully");
                await controller.clearCart();

                Get.offAll(const NavigatorScreen());
              },
            ),
        ),
      ),
    );
  }
}
