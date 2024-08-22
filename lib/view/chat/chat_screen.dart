import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartapp/consts/consts.dart';
import 'package:emartapp/controller/chats_controller.dart';
import 'package:emartapp/service/firestore_service.dart';
import 'package:emartapp/view/chat/components/sender_bubble.dart';
import 'package:emartapp/widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ChatsController());

    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: darkFontGrey, // Set the desired color here
        ),
        title: "${controller.friendName}".text.color(darkFontGrey).fontFamily(bold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Obx(
              ()=>
                controller.isLoading.value
                    ? Center(
                        child: loadingIndicator(),
                      )
                    : Expanded(
                      child: StreamBuilder(
                        stream: FirestoreService.getChatMessages(controller.chatDocId.toString()),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                          if(!snapshot.hasData){
                            return Center(
                              child: loadingIndicator(),
                            );
                          }
                          else if(snapshot.data!.docs.isEmpty){
                            return Center(
                              child: "Send a message..".text.color(darkFontGrey).make(),
                            );
                          }
                          else{
                            return ListView(
                              children: snapshot.data!.docs.mapIndexed((currentValue, index){
                                var data = snapshot.data!.docs[index];

                                return Align(
                                  alignment: data['uid'] == currentUser!.uid
                                    ?  Alignment.centerRight
                                    :  Alignment.centerLeft
                                  ,
                                  child: senderBubble(data),
                                );
                              }).toList(),
                            );
                          }
                        }
                      ),
              ),
            ),
            Row(
              children: [
                Expanded(child: TextFormField(
                  controller: controller.msgController,
                  decoration: const  InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textfieldGrey,
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textfieldGrey,
                        )
                    ),
                    hintText: "Type a message",
                  ),
                )),
                IconButton(
                    onPressed: (){
                      controller.sendMsg(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: const Icon(Icons.send, color: redColor,))
              ],
            ).box.height(80).padding(const EdgeInsets.all(12)).make(),
          ],
        ),
      ),
    );
  }
}
