

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_eatit_v2/const/const.dart';
import 'package:flutter_eatit_v2/model/popular_item_model.dart';

Future<List<PopularItemModel>> getMostPopularByRestaurantId(String restaurantId) async {

  var list = List<PopularItemModel>.empty(growable: true);
  var source = await FirebaseDatabase.instance.ref()
      .child(RESTAURANT_REF)
      .child(restaurantId)
      .child(MOST_POPULAR_REF).once();

  var values = source.snapshot;
  values.children.forEach((element) {
    list.add(PopularItemModel.fromJson(jsonDecode(jsonEncode(element.value))));
  });

  return list;
}