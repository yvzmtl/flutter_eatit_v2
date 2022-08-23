

import 'package:flutter_eatit_v2/model/food_model.dart';
import 'package:get/get.dart';

class FoodListStateController extends GetxController{
  var selectedFood = FoodModel(
      description:"description",
      id:"id",
      name: "name",
      image: "image",
      price: 0,
      size: [],
      addon: []).obs;
}