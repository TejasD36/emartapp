import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;


const cartCollection = "carts";
const userCollection = "users";
const productCollection = "products";
const chatCollection = "chats";
const messageCollection = "messages";
const orderCollection = "orders";
