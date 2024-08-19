import 'package:emartapp/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/material/scaffold.dart';

Widget bgWidget({required Scaffold child}) {
  return Container(
    decoration: const BoxDecoration(
      image:
          DecorationImage(
              image: AssetImage(imgBackground),
              fit: BoxFit.fill
          ),
    ),
    child: child,
  );
}
