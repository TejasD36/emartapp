import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartapp/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' as intl;

import '../../../consts/colors.dart';

Widget senderBubble(DocumentSnapshot data){

  var t = data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);

  return Directionality(
    textDirection: data['uid'] == currentUser!.uid ? TextDirection.rtl :  TextDirection.ltr ,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
          color: data['uid'] == currentUser!.uid ? redColor :  golden ,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: data['uid'] == currentUser!.uid ? const Radius.circular(20) :  const Radius.circular(0) ,
            bottomRight: data['uid'] == currentUser!.uid ? const Radius.circular(0) :  const Radius.circular(20) ,
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "${data['msg']}".text.white.size(16).make(),
          10.heightBox,
          time.text.color(whiteColor.withOpacity(0.5)).make(),
        ],
      ),
    ),
  );
}