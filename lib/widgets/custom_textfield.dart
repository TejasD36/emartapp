import 'package:emartapp/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customTextfield({String? title, String? titleHint, controller, isObscure}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      10.heightBox,
      title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        obscureText: isObscure ?? false,
        controller: controller,
        decoration:InputDecoration(
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
          ),
          hintText: titleHint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: redColor,
            )
          )
        ),
      ),
      10.heightBox,
    ],
  );
}