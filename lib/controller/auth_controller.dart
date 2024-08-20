import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartapp/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

  //Login method

  Future<UserCredential?> loginMethod ({email, password, context}) async {
    UserCredential? userCredential;
    try{
      userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
    }
    on FirebaseAuthException catch (e){
      VxToast.show(
          context,
          msg: e.toString()
      );
    }
    return userCredential;
  }

  //Signup method

  Future<UserCredential?> signupMethod ({email, password, context}) async {
    UserCredential? userCredential;
    try{
      userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    }
    on FirebaseAuthException catch (e){
      VxToast.show(
          context,
          msg: e.toString()
      );
    }
    return userCredential;
  }

  //Sign out method

  signOutMethod(context) async{
    try{
      await auth.signOut();
    }
    catch (e){
      VxToast.show(context, msg: e.toString());
    }
  }

  //Storing data

  storeUserData({name, email, password}){
    DocumentReference store = firestore.collection(userCollection).doc(currentUser!.uid);
    store.set({
      'name':name,
      'password':password,
      'email':email,
      'imageUrl':'',
    });
  }
}