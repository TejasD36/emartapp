import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartapp/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{


  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;

  //Login method

  Future<UserCredential?> loginMethod ({context}) async {
    UserCredential? userCredential;
    try{
      userCredential = await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
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

  Future<void> storeUserData({required String name, required String email, required String password}) async {
    DocumentReference store = firestore.collection(userCollection).doc(currentUser!.uid);
    await store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': currentUser!.uid,
      'cart_count':"00",
      'order_count':"00",
      'wishlist_count':"00",
    });
  }

}