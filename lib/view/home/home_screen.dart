import 'package:emartapp/consts/consts.dart';
import 'package:emartapp/widgets/custom_image_card.dart';
import 'package:emartapp/widgets/custom_logo_card.dart';
import 'package:flutter/material.dart';

import '../../consts/lists.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            //Search Bar
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: whiteColor,
                    hintText: searchAnything,
                    suffixIcon: Icon(Icons.search),
                    hintStyle: TextStyle(
                      color: textfieldGrey,
                    ),
                    suffixIconColor: textfieldGrey,
                    border: InputBorder.none
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics:const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    10.heightBox,

                    //First Slider
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: slidersList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            slidersList[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),


                    10.heightBox,

                    //First Cards
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
                      //May change later no need to generate list
                      children: List.generate(
                          2,
                              (index) => customLogoCard(
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 2.5,
                            icon: index == 0 ? icTodaysDeal : icFlashDeal,
                            title: index == 0 ? todaysDeal : flashSale,
                          )),
                    ),

                    10.heightBox,

                    //Second Slider
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: secondSlidersList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            slidersList[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),

                    10.heightBox,

                    //Second Cards
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: List.generate(
                          3,
                              (index) => customLogoCard(
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 3.5,
                            icon: index == 0
                                ? icTopCategories
                                : index == 1
                                ? icBrands
                                : icTopSeller,
                            title: index == 0
                                ? topCategories
                                : index == 1
                                ? brands
                                : topSellers,
                          )),
                    ),

                    20.heightBox,

                    //Featured Categories
                    Align(
                      alignment: Alignment.centerLeft,
                      child: featuredCategories.text
                          .color(darkFontGrey)
                          .size(18)
                          .fontFamily(semibold)
                          .make(),
                    ),

                    20.heightBox,

                    //First Featured Category Cards
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

                    20.heightBox,

                    //Featured Products
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image:
                        DecorationImage(
                            image: AssetImage(imgBackground2),
                            fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProducts.text.white.fontFamily(bold).size(18).make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Row(
                              children: List.generate(
                                  6,
                                  (index) => Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        imgP1,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      10.heightBox,
                                      "Laptop".text.fontFamily(semibold).color(darkFontGrey).make(),
                                      10.heightBox,
                                      "Price".text.fontFamily(bold).color(redColor).size(16).make(),
                                    ],
                                  ).box.white.margin(const EdgeInsets.symmetric(horizontal: 5)).roundedSM.padding(const EdgeInsets.all(8)).make(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    20.heightBox,

                    //Third Slider
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: secondSlidersList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            slidersList[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),

                    20.heightBox,

                    //All Products Section
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 6,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 300,
                      ),
                      itemBuilder: (context,index){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [
                            Image.asset(
                              imgP5,
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                            const Spacer(),
                            "Laptop".text.fontFamily(semibold).color(darkFontGrey).make(),
                            10.heightBox,
                            "Price".text.fontFamily(bold).color(redColor).size(16).make(),
                            10.heightBox,
                          ],
                        ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(12)).make();
                      }
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
