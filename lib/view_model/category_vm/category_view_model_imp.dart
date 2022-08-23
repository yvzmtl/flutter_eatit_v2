
import 'package:flutter_eatit_v2/firebase/category_reference.dart';
import 'package:flutter_eatit_v2/model/category_model.dart';
import 'package:flutter_eatit_v2/view_model/category_vm/category_view_model.dart';

class CategoryViewModelImp implements CategoryViewModel{
  @override
  Future<List<CategoryModel>> displayCategoryByRestaurantId(String restaurantId) {
    return getCategoryByRestaurantId(restaurantId);
  }

}