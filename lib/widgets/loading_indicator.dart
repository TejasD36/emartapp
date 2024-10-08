import 'package:emartapp/consts/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loadingIndicator(){
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}