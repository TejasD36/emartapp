import 'package:emartapp/consts/consts.dart';

class FirestoreService {
  //Get User Data
  static getUser(uid) {
    return firestore
        .collection(userCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //Get Product according to Category
  static getProducts(category) {
    return firestore
        .collection(productCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  //Get Product according to Sub-Category
  static getSubcategoryProducts(title) {
    return firestore
        .collection(productCollection)
        .where('p_subcategory', isEqualTo: title)
        .snapshots();
  }

  //Get Cart according to Category
  static getCarts(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  //Delete product from cart
  static deleteProductFromCart(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  //Get all chat messages
  static getChatMessages(docId) {
    return firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(messageCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }


  //Get all chat messages
  static getAllOrders() {
    return firestore
        .collection(orderCollection)
        .where("order_by", isEqualTo: currentUser!.uid)
        .snapshots();
  }

  //Get Wishlist
  static getWishlist() {
    return firestore
        .collection(productCollection)
        .where("p_wishlist", arrayContains: currentUser!.uid)
        .snapshots();
  }

  //Get all  messages
  static getAllMessages() {
    return firestore
        .collection(chatCollection)
        .where("fromId", isEqualTo: currentUser!.uid)
        .snapshots();
  }

  //Get all  messages
  static getCounts() async{
    var res= await Future.wait([
      firestore.collection(cartCollection)
        .where("added_by", isEqualTo: currentUser!.uid)
        .get().then((value){
          return value.docs.length;
      }),
      firestore.collection(productCollection)
          .where("p_wishlist", arrayContains: currentUser!.uid)
          .get().then((value){
        return value.docs.length;
      }),
      firestore.collection(orderCollection)
          .where("order_by", isEqualTo: currentUser!.uid)
          .get().then((value){
        return value.docs.length;
      })
    ]);
    return res;
  }

  //Get All Products
  static getAllProducts() {
    return firestore
        .collection(productCollection)
        .snapshots();
  }

  //Get Featured Products
  static getFeaturedProducts() {
    return firestore
        .collection(productCollection)
        .where('isFeatured',isEqualTo: true)
        .get();                 //For FutureBuilder
        // .snapshots();        //For StreamBuilder

  }

  //Get Searched Products
  static getSearchedProducts() {
    return firestore
        .collection(productCollection)
        .get();                 //For FutureBuilder
    // .snapshots();        //For StreamBuilder
  }
}

