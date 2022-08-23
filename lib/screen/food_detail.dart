

import 'package:flutter/material.dart';
import 'package:flutter_eatit_v2/state/category_sate.dart';
import 'package:flutter_eatit_v2/state/food_detail_state.dart';
import 'package:flutter_eatit_v2/state/food_list_state.dart';
import 'package:flutter_eatit_v2/strings/food_detail_string.dart';
import 'package:flutter_eatit_v2/utils/utils.dart';
import 'package:flutter_eatit_v2/widgets/food_detail/food_detail_description_widget.dart';
import 'package:flutter_eatit_v2/widgets/food_detail/food_detail_image_widget.dart';
import 'package:flutter_eatit_v2/widgets/food_detail/food_detail_name_widget.dart';
import 'package:flutter_eatit_v2/widgets/food_detail/food_detail_size_widget.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodDetailScreen extends StatelessWidget{
  final CategoryStateController categoryStateController = Get.find();
  final FoodListStateController foodListStateController = Get.find();
  final FoodDetailStateController foodDetailStateController = Get.put(FoodDetailStateController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        body: NestedScrollView(headerSliverBuilder:(context,innerBoxIsScrolled){
          return[
            SliverAppBar(
              title: Text("${foodListStateController.selectedFood.value.name}",
                style: GoogleFonts.jetBrainsMono(color: Colors.black),),
              elevation: 10,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              foregroundColor: Colors.black,
              bottom: PreferredSize(
                preferredSize: Size.square(foodDetailImageAreaSize(context),),
                child: FoodDetailImageWidget(foodListStateController: foodListStateController),
              ),
            ),
          ];
        },
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FoodDetailNameWidget(foodListStateController: foodListStateController,
                      foodDetailStateController: foodDetailStateController,),
                    FoodDetailDescriptionWidget(foodListStateController: foodListStateController),
                    FoodDetailSizeWidget(
                        foodListStateController: foodListStateController,
                        foodDetailStateController: foodDetailStateController),
                    Card(
                      elevation: 12,
                      child: Container(
                        width:  double.infinity,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(() => ExpansionTile(
                                title: Text(
                                  addonText,
                                  style: GoogleFonts.jetBrainsMono(
                                      color: Colors.blueGrey,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900),
                                ),
                                children: [
                                  Wrap(
                                    children: foodListStateController.selectedFood.value.addon.map((e) =>
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: ChoiceChip(
                                              label: Text(e.name),
                                              selected: foodDetailStateController.selectedAddon.contains(e),
                                            selectedColor: Colors.yellow,
                                            onSelected: (selected) => selected
                                                ? foodDetailStateController.selectedAddon.add(e) 
                                                : foodDetailStateController.selectedAddon.remove(e),
                                          ),)
                                    ).toList(),
                                  )
                                ]
                            ),),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }


}









