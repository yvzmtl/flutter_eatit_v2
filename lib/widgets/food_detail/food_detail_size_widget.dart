

import 'package:flutter/material.dart';
import 'package:flutter_eatit_v2/model/size_model.dart';
import 'package:flutter_eatit_v2/state/food_detail_state.dart';
import 'package:flutter_eatit_v2/state/food_list_state.dart';
import 'package:flutter_eatit_v2/strings/food_detail_string.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodDetailSizeWidget extends StatelessWidget {
  const FoodDetailSizeWidget({
    Key? key,
    required this.foodListStateController,
    required this.foodDetailStateController,
  }) : super(key: key);

  final FoodListStateController foodListStateController;
  final FoodDetailStateController foodDetailStateController;

  @override
  Widget build(BuildContext context) {
    return foodListStateController.selectedFood.value.size.length > 0 ? Card(
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
                sizeText,
                style: GoogleFonts.jetBrainsMono(
                    color: Colors.blueGrey,
                    fontSize: 20,
                    fontWeight: FontWeight.w900),
              ),
              children: foodListStateController.selectedFood.value.size.map((e) =>
                  RadioListTile<SizeModel>(
                      title: Text(e.name),
                      value: e,
                      groupValue: foodDetailStateController.selectedSize.value,
                      onChanged: (value)=> foodDetailStateController.selectedSize.value = value!)).toList(),
            ),),
          ],
        ),
      ),
    ) : Container();
  }
}