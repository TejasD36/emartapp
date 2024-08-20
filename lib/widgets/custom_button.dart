import 'package:emartapp/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customButton({onPress, color, textColor,required String title}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(

      foregroundColor: color,
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
    ),
      onPressed: onPress,
      child: title.text.color(textColor).fontFamily(bold).make(),
  );
}