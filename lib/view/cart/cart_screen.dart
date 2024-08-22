import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartapp/consts/consts.dart';
import 'package:emartapp/controller/cart_controller.dart';
import 'package:emartapp/service/firestore_service.dart';
import 'package:emartapp/view/cart/shipping_screen.dart';
import 'package:emartapp/widgets/custom_button.dart';
import 'package:emartapp/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var controller = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(
            color: whiteColor, // Set the desired color here
          ),
          title:
              "Shopping Cart".text.fontFamily(bold).color(darkFontGrey).make(),
        ),
        body: StreamBuilder(
            stream: FirestoreService.getCarts(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Cart is Empty".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot = data;

                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Image.network(
                                  width: 80,
                                  fit: BoxFit.cover,
                                  "${data[index]['img']}",
                                ),
                                title: "${data[index]['title']}  (x${data[index]['qty']})"
                                    .text
                                    .fontFamily(semibold)
                                    .size(16)
                                    .make(),
                                subtitle: "${data[index]['tprice']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(redColor)
                                    .size(16)
                                    .make(),
                                trailing: const Icon(
                                  Icons.delete,
                                  color: redColor,
                                ).onTap(() {
                                  FirestoreService.deleteProductFromCart(
                                      data[index].id);
                                }),
                              );
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total Price: "
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          Obx(
                            () => "${controller.totalP.value}"
                                .numCurrency
                                .text
                                .fontFamily(semibold)
                                .color(redColor)
                                .make(),
                          ),
                        ],
                      )
                          .box
                          .padding(const EdgeInsets.all(12))
                          .color(lightGolden)
                          .width(context.screenWidth - 60)
                          .roundedSM
                          .make(),
                      // SizedBox(
                      //   width: context.screenWidth - 60,
                      //   child: customButton(
                      //       color: redColor,
                      //       title: "Proceed to Shipping",
                      //       textColor: whiteColor,
                      //       onPress: () {}),
                      // )
                    ],
                  ),
                );
              }
            },
        ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: customButton(
            color: redColor,
            title: "Proceed to Shipping",
            textColor: whiteColor,
            onPress: () {
              Get.to(() => const ShippingScreen());
            }
        ),
      ),
    );
  }
}
