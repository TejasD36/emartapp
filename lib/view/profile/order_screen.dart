import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartapp/consts/consts.dart';
import 'package:emartapp/service/firestore_service.dart';
import 'package:emartapp/view/profile/order_details.dart';
import 'package:emartapp/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreService.getAllOrders(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: loadingIndicator(),
              );
            }
            else if(snapshot.data!.docs.isEmpty){
              return "No orders yet..".text.color(darkFontGrey).makeCentered();
            }
            else{

              var data = snapshot.data!.docs;

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    leading: "${index+1}".text.fontFamily(bold).color(darkFontGrey).xl.make(),
                    title: data[index]['order_code'].toString().text.fontFamily(semibold).color(redColor).make(),
                    subtitle: data[index]['total_amount'].toString().numCurrency.text.fontFamily(bold).make(),
                    trailing: IconButton(
                        onPressed: (){
                          Get.to(()=> OrderDetails(data: data));
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: darkFontGrey,
                        )
                    ),
                  );
                }
              );
            }
          }
      ),
    );
  }
}
