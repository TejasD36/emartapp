import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartapp/consts/consts.dart';
import 'package:flutter/material.dart';

import '../../service/firestore_service.dart';
import '../../widgets/loading_indicator.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreService.getWishlist(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: loadingIndicator(),
              );
            }
            else if(snapshot.data!.docs.isEmpty){
              return "No items in wishlist..".text.color(darkFontGrey).makeCentered();
            }
            else{

              var data = snapshot.data!.docs;
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true ,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Image.network(
                          width: 80,
                          fit: BoxFit.cover,
                          "${data[index]['p_imgs'][0]}",
                        ),
                        title: "${data[index]['p_name']}"
                            .text
                            .fontFamily(semibold)
                            .size(16)
                            .make(),
                        subtitle: "${data[index]['p_price']}".numCurrency
                            .text
                            .fontFamily(semibold)
                            .color(redColor)
                            .size(16)
                            .make(),
                        trailing: const Icon(
                          Icons.favorite_outlined,
                          color: redColor,
                        ).onTap(() async{
                          await firestore.collection(productCollection).doc(data[index].id).set({
                            'p_wishlist':FieldValue.arrayRemove([currentUser!.uid])
                          }, SetOptions(merge: true));

                          VxToast.show(context, msg: "Removed from Wishlist");
                        }),
                      );
                    },
                ),
              );
            }
          }
      ),
    );
  }
}
