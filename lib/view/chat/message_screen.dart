import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartapp/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../service/firestore_service.dart';
import '../../widgets/loading_indicator.dart';
import 'chat_screen.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "All Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreService.getAllMessages(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {

              return "No messages yet.."
                  .text
                  .color(darkFontGrey)
                  .makeCentered();
            } else {
              var data = snapshot.data!.docs;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: ListTile(
                                  onTap: ((){
                                    Get.to(
                                            () => const ChatScreen(),
                                        arguments: [
                                          data[index]['friend_name'].toString(),
                                          data[index]['toId'].toString(),
                                        ]
                                    );
                                  }),
                                  leading: const CircleAvatar(
                                    backgroundColor: redColor,
                                    child: Icon(
                                      Icons.person,
                                      color: whiteColor,
                                    ),
                                  ),
                                  title: "${data[index]['friend_name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  subtitle: "${data[index]['last_msg']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                ),
                              );
                            }))
                  ],
                ),
              );
            }
          }),
    );
  }
}
