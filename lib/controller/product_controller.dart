import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../model/category_model.dart';

class ProductController extends GetxController{

  var subCat = [];

  getSubCategories(title) async{
    subCat.clear();

    var data = await rootBundle.loadString("lib/service/category_model.json");
    var decoded = welcomeFromJson(data);
    var s = decoded.categories.where((element)=> element.name == title).toList();

    if (s.isNotEmpty) {
      for (var e in s[0].subcategory) {
        print(e);
        subCat.add(e);
      }
    } else {
      print("No categories found with the title: $title");
    }
  }
}