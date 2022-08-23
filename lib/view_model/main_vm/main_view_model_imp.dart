

import 'package:flutter_eatit_v2/firebase/restaurant_reference.dart';
import 'package:flutter_eatit_v2/model/restaurant_model.dart';

import 'main_view_model.dart';


class MainViewModelImp implements MainViewModel{
  @override
  Future<List<RestaurantModel>> displayRestaurantList() {
    return getRestaurantList();
  }

}