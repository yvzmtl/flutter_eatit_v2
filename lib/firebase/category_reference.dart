


import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_eatit_v2/const/const.dart';
import 'package:flutter_eatit_v2/model/category_model.dart';

Future<List<CategoryModel>> getCategoryByRestaurantId(String restaurantId) async {

  var list = List<CategoryModel>.empty(growable: true);
  var source = await FirebaseDatabase.instance.ref()
      .child(RESTAURANT_REF)
      .child(restaurantId)
      .child(CATEGORY_REF).once();

  var values = source.snapshot;
  values.children.forEach((element) {
    list.add(CategoryModel.fromJson(jsonDecode(jsonEncode(element.value))));
  });

  return list;
}