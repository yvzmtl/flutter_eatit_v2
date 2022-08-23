
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eatit_v2/model/category_model.dart';
import 'package:flutter_eatit_v2/state/category_sate.dart';
import 'package:flutter_eatit_v2/state/main_state.dart';
import 'package:flutter_eatit_v2/strings/restaurant_home_strings.dart';
import 'package:flutter_eatit_v2/view_model/category_vm/category_view_model_imp.dart';
import 'package:flutter_eatit_v2/widgets/category/category_list_widget.dart';
import 'package:flutter_eatit_v2/widgets/common/appbar_with_cart_widget.dart';
import 'package:flutter_eatit_v2/widgets/common/common_widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends StatelessWidget{
  final viewModel = CategoryViewModelImp();
  final MainStateController mainStateController = Get.find();
  final CategoryStateController categoryStateController = Get.put(CategoryStateController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithCartButton(title: "${mainStateController.selectedRestaurant.value.name}",),
      body: FutureBuilder(
        future: viewModel.displayCategoryByRestaurantId(
            mainStateController.selectedRestaurant.value.restaurantId),

        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator(),);
          else{
            var lst = snapshot.data as List<CategoryModel>;
            return Container(
              margin: const EdgeInsets.only(top: 10),
              child: CategoryListWidget(lst: lst,categoryStateController: categoryStateController,),
            );
          }
        },
      ),
    );
  }


}

