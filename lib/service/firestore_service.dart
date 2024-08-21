import 'package:emartapp/consts/consts.dart';

class FirestoreService{

  //Get User Data
  static getUser(uid){
    return firestore.collection(userCollection).where('id',isEqualTo: uid).snapshots();
  }

  //Get Product according to Category
  static getProducts(category){
    return firestore.collection(productCollection).where('p_category',isEqualTo: category).snapshots();
  }

  //Get Cart according to Category
  static getCarts(uid){
    return firestore.collection(cartCollection).where('added_by',isEqualTo: uid).snapshots();
  }

  static deleteProductFromCart(docId){
    return firestore.collection(cartCollection).doc(docId).delete();
  }
}