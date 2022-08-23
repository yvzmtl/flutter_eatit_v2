

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eatit_v2/model/popular_item_model.dart';
import 'package:flutter_eatit_v2/state/main_state.dart';
import 'package:flutter_eatit_v2/strings/restaurant_home_strings.dart';
import 'package:flutter_eatit_v2/view_model/restaurant_home_detail_vm/restaurant_home_detail_vm.dart';
import 'package:flutter_eatit_v2/widgets/common/common_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class MostPopularWidget extends StatelessWidget {
  const MostPopularWidget({
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
        future: viewModel.displayMostPopularByRestaurantId(
            mainStateController.selectedRestaurant.value.restaurantId),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator(),);
          else{
            var lstPopular = snapshot.data as List<PopularItemModel>;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mostPopularText,
                  style: GoogleFonts.jetBrainsMono(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: Colors.black45),
                ),
                // Text("Popüler Ürün Sayısı: ${lstPopular.length}"),
                Expanded(
                  child: LiveList(
                    showItemDuration: Duration(milliseconds: 350),
                    showItemInterval: Duration(milliseconds: 150),
                    reAnimateOnVisibility: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: lstPopular.length,
                    itemBuilder: animationItemBuilder((index)=> Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(lstPopular[index].image),
                            minRadius: 40,
                            maxRadius: 60,
                          ),
                          SizedBox(height: 10,),
                          Text(lstPopular[index].name,
                            style: GoogleFonts.jetBrainsMono(),
                          ),
                        ],
                      ),
                    ),

                    ),
                  ),)
              ],
            );
          }
        },
      ),
    );
  }
}