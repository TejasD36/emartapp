import 'package:emartapp/consts/consts.dart';
import 'package:emartapp/widgets/custom_card.dart';
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
                      //May change later no need to generate list
                      children: List.generate(
                          2,
                              (index) => customCard(
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 2.5,
                            icon: index == 0 ? icTodaysDeal : icFlashDeal,
                            title: index == 0 ? todaysDeal : flashSale,
                          )),
                    ),
                    10.heightBox,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
                      //May change later no need to generate list
                      children: List.generate(
                          3,
                              (index) => customCard(
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
                    10.heightBox,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: featuredCategories.text
                          .color(darkFontGrey)
                          .size(18)
                          .fontFamily(semibold)
                          .make(),
                    )
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
