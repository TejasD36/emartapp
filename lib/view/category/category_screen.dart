import 'package:emartapp/consts/consts.dart';
import 'package:emartapp/consts/lists.dart';
import 'package:emartapp/controller/product_controller.dart';
import 'package:emartapp/view/category/category_details.dart';
import 'package:emartapp/widgets/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProductController());

    return bgWidget(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: whiteColor, // Set the desired color here
            ),
            title: categories.text.fontFamily(bold).white.make(),
          ),
          body: Container(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 200,
              ),
              itemBuilder: (context, index){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    10.heightBox,
                    Image.asset(
                      categoriesImg[index] ,
                      height: 120,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    10.heightBox,
                    categoriesList[index].text.color(darkFontGrey).align(TextAlign.center).make(),
                    10.heightBox,
                  ],
                ).box.white.clip(Clip.antiAlias).rounded.outerShadowSm.make().onTap((){
                  controller.getSubCategories(categoriesList[index]);
                  Get.to(()=> CategoryDetails(title: categoriesList[index]));
                });
              }
            ),
          ),
        ),
    );
  }
}
