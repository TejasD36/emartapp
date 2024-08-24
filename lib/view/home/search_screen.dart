import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartapp/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/colors.dart';
import '../../consts/lists.dart';
import '../../controller/product_controller.dart';
import '../../service/firestore_service.dart';
import '../../widgets/loading_indicator.dart';
import '../category/category_details.dart';
import '../category/item_details.dart';

class SearchScreen extends StatefulWidget {

  final String? searchText;

  const SearchScreen({super.key, required this.searchText});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  var controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${widget.searchText}".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: FutureBuilder(
          future: FirestoreService.getSearchedProducts(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: loadingIndicator(),
              );
            }
            else if(snapshot.data!.docs.isEmpty){
              return "No Similar Item Found..".text.color(darkFontGrey).makeCentered();
            }
            else{

              var data = snapshot.data!.docs;

              var filtered= data.where(
                  (element) => element['p_name'].toString().toLowerCase().contains(widget.searchText!.toLowerCase()),
              ).toList();

              // return Padding(
              //     padding: const EdgeInsets.all(8),
              //   child: GridView(
              //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2,
              //         mainAxisSpacing: 8,
              //         crossAxisSpacing: 8,
              //         mainAxisExtent: 300
              //       ),
              //     children: filtered
              //         .mapIndexed((currentValue, index)=>Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Image.network(
              //           filtered[index]['p_imgs'][0],
              //           height: 200,
              //           width: 200,
              //           fit: BoxFit.cover,
              //         ),
              //         const Spacer(),
              //         "${filtered[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
              //         "${filtered[index]['p_price']}".text.fontFamily(bold).color(redColor).size(16).make(),
              //       ],
              //     ),
              //     ),
              //   ),
              // );

              return Padding(
                padding: const EdgeInsets.all(8),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 260,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          filtered[index]['p_imgs'][0],
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        const Spacer(),
                        Text(
                          "${filtered[index]['p_name']}",
                          style: const TextStyle(fontFamily: semibold, color: darkFontGrey),
                        ),
                        Text(
                          "${filtered[index]['p_price']}",
                          style: const TextStyle(fontFamily: bold, color: redColor, fontSize: 16),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 4).box.roundedSM.outerShadowMd.white.make().onTap((){

                      controller.checkIfFav(filtered[index]);

                      Get.to(
                              ()=> ItemDetails(
                            title: "${filtered[index]['p_name']}",
                            data: data,
                          )
                      );
                    });
                  },
                ),
              );

            }
          }
      ),
    );
  }
}
