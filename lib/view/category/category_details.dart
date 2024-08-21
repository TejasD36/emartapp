import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartapp/consts/consts.dart';
import 'package:emartapp/controller/product_controller.dart';
import 'package:emartapp/service/firestore_service.dart';
import 'package:emartapp/view/category/item_details.dart';
import 'package:emartapp/widgets/bg_widget.dart';
import 'package:emartapp/widgets/loading_indicator.dart';
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

    var controller = Get.find<ProductController>();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: whiteColor, // Set the desired color here
          ),
          title: widget.title.text.fontFamily(bold).white.make(),
        ),
        body: StreamBuilder(
          stream: FirestoreService.getProducts(widget.title),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: loadingIndicator(),
              );
            }
            else if(snapshot.data!.docs.isEmpty){
              return Center(
                child: "No Product Found".text.color(darkFontGrey).make(),
              );
            }
            else{

              var data = snapshot.data!.docs;

              return Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    //SubCategories
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                            controller.subCat.length,
                                (index) => "${controller.subCat[index]}"
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
                          itemCount: data.length,
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
                                Image.network(
                                  data[index]['p_imgs'][0],
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                10.heightBox,
                                "${data[index]['p_name']}"
                                      .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                "${data[index]['p_price']}"
                                    .numCurrency.text
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
                              Get.to(()=> ItemDetails(title: "${data[index]['p_name']}", data: data,));
                            });
                          }),
                    ),
                  ],
                ),
              );
            }
          },
        )
      ),
    );
  }
}
