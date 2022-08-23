

import 'package:flutter_eatit_v2/model/popular_item_model.dart';

abstract class RestaurantHomeDetailViewModel{
  Future<List<PopularItemModel>> displayMostPopularByRestaurantId(String restaurantId);

  Future<List<PopularItemModel>> displayBestDealsByRestaurantId(String restaurantId);
}