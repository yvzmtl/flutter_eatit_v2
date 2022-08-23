

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eatit_v2/model/popular_item_model.dart';
import 'package:flutter_eatit_v2/state/main_state.dart';
import 'package:flutter_eatit_v2/view_model/restaurant_home_detail_vm/restaurant_home_detail_vm.dart';
import 'package:google_fonts/google_fonts.dart';

class BestDealsWidget extends StatelessWidget {
  const BestDealsWidget({
    Key? key,
    required this.viewModel,
    required this.mainStateController,
  }) : super(key: key);

  final RestaurantHomeDetailViewModel viewModel;
  final MainStateController mainStateController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: viewModel.displayBestDealsByRestaurantId(
              mainStateController.selectedRestaurant.value.restaurantId),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator(),);
            else{
              var lstBestDeals = snapshot.data as List<PopularItemModel>;
              return CarouselSlider(
                  items: lstBestDeals.map((e) =>
                      Builder(builder: (BuildContext context){
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ImageFiltered(
                                  imageFilter: ImageFilter.blur(
                                      sigmaX: 5, sigmaY: 5),
                                  child: CachedNetworkImage(
                                    imageUrl: e.image,
                                    fit: BoxFit.cover,
                                    errorWidget: (context,url,err)=>
                                        Center(
                                          child: Icon(Icons.image),
                                        ),
                                    progressIndicatorBuilder: (context,url,dowloadProgress) =>
                                        Center(
                                          child: CircularProgressIndicator(),),
                                  ),
                                ),
                                Center(
                                  child: Text("${e.name}",
                                    style: GoogleFonts.jetBrainsMono(
                                        color: Colors.white,
                                        fontSize: 20
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(seconds: 3),
                    autoPlayCurve: Curves.easeIn,
                    height: double.infinity,
                  ));
            }
          }),
    );
  }
}