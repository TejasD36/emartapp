import 'package:emartapp/consts/consts.dart';
import 'package:emartapp/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        "Are you sure you want to exit?"
        .text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            customButton(
                title: "No",
                color: redColor,
                textColor: whiteColor,
                onPress: (){
                  Navigator.pop(context);
                }
            ),
            customButton(
              title: "Yes",
              color: redColor,
              textColor: whiteColor,
              onPress: (){
                SystemNavigator.pop();
              }
            ),
          ],
        ),
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).rounded.make(),
  );
}