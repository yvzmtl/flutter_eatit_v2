

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eatit_v2/screen/cart.dart';
import 'package:flutter_eatit_v2/state/cart_state.dart';
import 'package:flutter_eatit_v2/state/main_state.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWithCartButton extends StatelessWidget implements PreferredSizeWidget{

  final String title;
  final CartStateController cartStateController = Get.find();
  final MainStateController mainStateController = Get.find();


  AppBarWithCartButton({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "$title"
        ,style: GoogleFonts.jetBrainsMono(color: Colors.black),
      ),
      elevation: 10,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.black),
      actions: [
        Obx(()=> Badge(
          position: BadgePosition(top:1.5, end: 2.5),
          animationDuration: Duration(milliseconds: 200),
          animationType: BadgeAnimationType.scale,
          showBadge: true,
          badgeColor: Colors.red,
          badgeContent: Text("${cartStateController.getQuantity(mainStateController.selectedRestaurant.value.restaurantId)}",
            style: GoogleFonts.jetBrainsMono(color: Colors.white),),
          child: IconButton(
              onPressed: () => Get.to(CartDetailScreen()),
              icon: Icon(Icons.shopping_bag)),
        ),),
        SizedBox(width: 20,),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56.0);

}