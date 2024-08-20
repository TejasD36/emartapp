import 'package:emartapp/consts/consts.dart';
import 'package:emartapp/view/category/item_details.dart';
import 'package:emartapp/widgets/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CategoryDetails extends StatefulWidget {
  final String title;

  const CategoryDetails({super.key, required this.title});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: whiteColor, // Set the desired color here
          ),
          title: widget.title.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              //SubCategories
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: List.generate(
                      6,
                      (index) => "Cloth1"
                          .text
                          .size(12)
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .makeCentered()
                          .box
                          .white
                          .rounded
                          .size(120, 60)
                          .margin(const EdgeInsets.symmetric(horizontal: 4))
                          .make()),
                ),
              ),

              20.heightBox,

              //All Products Section
              Expanded(
                child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 250,
                    ),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            imgP5,
                            height: 150,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                          10.heightBox,
                          "Laptop"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          10.heightBox,
                          "Price"
                              .text
                              .fontFamily(bold)
                              .color(redColor)
                              .size(16)
                              .make(),
                          10.heightBox,
                        ],
                      )
                          .box
                          .white
                          .roundedSM
                          .padding(const EdgeInsets.all(12))
                          .outerShadowSm
                          .make().onTap((){
                            Get.to(()=> const ItemDetails(title: "Dummy"));
                      });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
