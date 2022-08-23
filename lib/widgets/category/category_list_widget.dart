

import 'dart:ui';

import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eatit_v2/const/const.dart';
import 'package:flutter_eatit_v2/model/category_model.dart';
import 'package:flutter_eatit_v2/screen/food_list.dart';
import 'package:flutter_eatit_v2/state/category_sate.dart';
import 'package:flutter_eatit_v2/widgets/common/common_widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({
    Key? key,
    required this.lst,
    required this.categoryStateController,
  }) : super(key: key);

  final List<CategoryModel> lst;
  final CategoryStateController categoryStateController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LiveGrid(
            showItemInterval: Duration(milliseconds: 300),
            showItemDuration: Duration(milliseconds: 300),
            reAnimateOnVisibility: true,
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 1, mainAxisSpacing: 1
            ),
            itemCount: lst.length,
            itemBuilder: animationItemBuilder((index)=>InkWell(
              onTap: (){
                categoryStateController.selectedCategory.value = lst[index];
                Get.to(()=>FoodListScreen());
              },
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: lst[index].image,
                      fit: BoxFit.cover,
                      errorWidget: (context,url,err)=>
                          Center(
                            child: Icon(Icons.image),
                          ),
                      progressIndicatorBuilder: (context,url,dowloadProgress) =>
                          Center(
                            child: CircularProgressIndicator(),),
                    ),
                    Container(color: Color(COLOR_OVERLAY),),
                    Center(
                      child: Text("${lst[index].name}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.jetBrainsMono(
                            color: Colors.white,
                            fontSize: 20
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ),
          ),
        ),
      ],
    );
  }
}