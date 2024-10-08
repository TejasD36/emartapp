import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartapp/consts/consts.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../model/category_model.dart';

class ProductController extends GetxController{

  var quantity = 0.obs;
  var colourIndex = 0.obs;
  var totalPrice = 0.obs;
  var isFav = false.obs;

  var subCat = [];

  getSubCategories(title) async{


    subCat.clear();

    var data = await rootBundle.loadString("lib/service/category_model.json");
    var decoded = welcomeFromJson(data);
    var s = decoded.categories.where((element)=> element.name == title).toList();

    if (s.isNotEmpty) {
      for (var e in s[0].subcategory) {
        print(e);
        subCat.add(e);
      }
    } else {
      print("No categories found with the title: $title");
    }
  }

  changeColourIndex(index){
    colourIndex.value =index;
  }

  increaseQuantity(totalQuantity){
    if(quantity.value<totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity(){
    if(quantity.value>0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(itemPrice){
    totalPrice.value=itemPrice*quantity.value;
  }

  addToCart({title, img, sellername, color, qty, tprice, vendorId, context}) async{

    await firestore.collection("carts").doc().set({
      'title':title,
      'img':img,
      'sellername':sellername,
      'color':color,
      'qty':qty,
      'tprice':tprice,
      'vendor_id':vendorId,
      'added_by':currentUser!.uid
    }).then((value){
      VxToast.show(context, msg: "Added to Cart");
    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues(){
    totalPrice.value = 0;
    quantity.value = 0;
    colourIndex.value = 0;
  }

  addToWishlist(docId,context) async{
    await firestore.collection(productCollection).doc(docId).set({
      'p_wishlist':FieldValue.arrayUnion([currentUser!.uid]),
    },SetOptions(merge: true),
    );

    isFav(true);
    VxToast.show(context, msg: "Added to Wishlist");
  }

  removeFromWishlist(docId, context) async{
    await firestore.collection(productCollection).doc(docId).set({
      'p_wishlist':FieldValue.arrayRemove([currentUser!.uid]),
    },SetOptions(merge: true),
    );

    isFav(false);
    VxToast.show(context, msg: "Removed from Wishlist");
  }

  checkIfFav(data) async{
    if(data['p_wishlist'].contains(currentUser!.uid)){
      isFav(true);
    }
    else{
      isFav(false);
    }
  }
}