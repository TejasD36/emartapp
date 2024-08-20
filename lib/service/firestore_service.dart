import 'package:emartapp/consts/consts.dart';

class FirestoreService{

  //Get User Data
  static getUser(uid){
    return firestore.collection(userCollection).where('id',isEqualTo: uid).snapshots();
  }
}