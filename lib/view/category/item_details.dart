import 'dart:ffi';

import 'package:emartapp/consts/colors.dart';
import 'package:emartapp/consts/consts.dart';
import 'package:emartapp/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/lists.dart';
import '../../consts/styles.dart';
import '../../controller/product_controller.dart';
import '../../widgets/custom_image_card.dart';

class ItemDetails extends StatefulWidget {
  final String? title;
  final dynamic data;

  const ItemDetails({super.key, required this.title, required this.data});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProductController>();

    return WillPopScope(
      onWillPop: ()async{
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,

        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              controller.resetValues();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          iconTheme: const IconThemeData(
            color: darkFontGrey, // Set the desired color here
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_outline,
              ),
            ),
          ],
          title: widget.title!.text.color(darkFontGrey).fontFamily(bold).make(),
        ),

        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //Photo Slider
                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 350,
                          viewportFraction: 0.9,
                          itemCount: widget.data[0]['p_imgs'].length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              widget.data[0]['p_imgs'][index],
                              width: double.infinity,
                              fit: BoxFit.fill,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(const EdgeInsets.symmetric(horizontal: 8))
                                .make();
                          }),
                      10.heightBox,

                      //title and details section
                      widget.title!.text
                          .size(16)
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,

                      //rating
                      VxRating(
                        isSelectable: false,
                        value: double.parse(widget.data[0]['p_rating']),
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        count: 5,
                        maxRating: 5,
                        size: 25,
                      ),

                      //Price
                      widget.data[0]['p_price'].toString().numCurrency
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(18)
                          .make(),

                      10.heightBox,

                      //Comment section
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.data[0]['p_seller'].toString().text.white.fontFamily(semibold).make(),
                              5.heightBox,
                              "In House Brands"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                            ],
                          )),
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.message_rounded,
                              color: darkFontGrey,
                            ),
                          ),
                        ],
                      )
                          .box
                          .height(60)
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .color(textfieldGrey)
                          .make(),

                      20.heightBox,


                      Obx(
                        ()=> Column(
                          children: [

                            //Colors Section
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Color: ".text.color(textfieldGrey).make(),
                                ),
                                Row(
                                  children: List.generate(
                                    widget.data[0]['p_colors'].length,
                                    (index) => Stack(
                                      children:[
                                        VxBox()
                                            .size(40, 40)
                                            .roundedFull
                                            .color(Color(widget.data[0]['p_colors'][index]).withOpacity(1.0))
                                            .margin(
                                              const EdgeInsets.symmetric(
                                                horizontal: 4
                                              ),
                                            )
                                            .make().onTap((){
                                              controller.changeColourIndex(index);
                                        }),
                                          Visibility(
                                            visible: index == controller.colourIndex.value,
                                            child: const Padding(
                                              padding: EdgeInsets.only(left: 5,top: 2),
                                              child: Icon(Icons.done, color: whiteColor,size: 35,),
                                            )
                                          ),
                                        ]
                                    ),
                                  ),
                                ).box.padding(const EdgeInsets.all(8)).make(),
                              ],
                            ),

                            10.heightBox,

                            //Quantity Section
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Quantity: ".text.color(textfieldGrey).make(),
                                ),
                                Obx(
                                 ()=> Row(
                                    children: [
                                      IconButton(
                                        onPressed: (){
                                          controller.decreaseQuantity();
                                          controller.calculateTotalPrice(int.parse(widget.data[0]['p_price']));
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                      controller.quantity.value.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                                      IconButton(
                                        onPressed: (){
                                          controller.increaseQuantity(int.parse(widget.data[0]['p_quantity']));
                                          controller.calculateTotalPrice(int.parse(widget.data[0]['p_price']));
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                      10.widthBox,
                                      "(${widget.data[0]['p_quantity']} available)".text.color(textfieldGrey).make(),
                                    ],
                                  ).box.padding(const EdgeInsets.all(8)).make(),
                                ),
                              ],
                            ),

                            //Total Price
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Total: ".text.color(textfieldGrey).make(),
                                ),
                                "${controller.totalPrice.value}".numCurrency.text.color(redColor).size(16).fontFamily(bold).make(),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                          ],
                        ).box.white.shadowSm.make(),
                      ),

                      //Description Section
                      10.heightBox,

                      "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                      10.heightBox,
                      widget.data[0]['p_description'].toString().text.color(darkFontGrey).make(),

                      20.heightBox,
                      //Button Section
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            itemDetailsButtonList.length,
                            (index)=>ListTile(
                              title: itemDetailsButtonList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                              trailing: const Icon(Icons.arrow_forward),
                            )
                        ),
                      ),

                      10.heightBox,
                      //Products you may like Section
                      productsYouMayLike.text.fontFamily(bold).size(16).color(darkFontGrey).make(),

                      10.heightBox,
                      //Slider
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            3,
                                (index)=> Column(
                              children: [
                                customImageCard(
                                  icon: featuredImages1[index],
                                  title: featuredTitles1[index],
                                ),
                                10.heightBox,
                                customImageCard(
                                  icon: featuredImages2[index],
                                  title: featuredTitles2[index],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),


            //Add to Cart Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: customButton(
                color: redColor,
                title: addToCart,
                textColor: whiteColor,
                onPress: () {
                  controller.addToCart(
                    color: widget.data[0]['p_colors'][controller.colourIndex.value],
                    context: context,
                    img: widget.data[0]['p_imgs'][0],
                    qty: controller.quantity.value,
                    sellername: widget.data[0]['p_seller'],
                    title: widget.data[0]['p_name'],
                    tprice: controller.totalPrice.value,
                  );
                },
              ),
            ).box.roundedNone.color(redColor).width(double.infinity).make(),
          ],
        ),
      ),
    );
  }
}
