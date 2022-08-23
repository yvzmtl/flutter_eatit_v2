

import 'package:flutter_eatit_v2/firebase/best_deals_reference.dart';
import 'package:flutter_eatit_v2/firebase/popular_reference.dart';
import 'package:flutter_eatit_v2/model/popular_item_model.dart';
import 'package:flutter_eatit_v2/view_model/restaurant_home_detail_vm/restaurant_home_detail_vm.dart';

class RestaurantHomeDetailViewModelImp extends RestaurantHomeDetailViewModel{
  @override
  Future<List<PopularItemModel>> displayMostPopularByRestaurantId(String restaurantId) {
    return getMostPopularByRestaurantId(restaurantId);
  }

  @override
  Future<List<PopularItemModel>> displayBestDealsByRestaurantId(String restaurantId) {
    return getBestDealByRestaurantId(restaurantId);
  }

}