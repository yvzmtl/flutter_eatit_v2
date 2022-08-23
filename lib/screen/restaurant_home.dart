

import 'package:flutter/material.dart';
import 'package:flutter_eatit_v2/screen/menu.dart';
import 'package:flutter_eatit_v2/screen/restaurant_home_detail.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';


class RestaurantHome extends StatelessWidget{
  final drawerZoomController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ZoomDrawer(
          controller: drawerZoomController,
            menuScreen: MenuScreen(drawerZoomController),
            mainScreen: RestaurantHomeDetail(drawerZoomController),
          borderRadius: 24.0,
          showShadow: true,
          angle: 0.0,
          menuBackgroundColor: Colors.grey[300]!,
          slideWidth: MediaQuery.of(context).size.width*0.55,
          openCurve: Curves.bounceInOut,
          closeCurve: Curves.ease,
        ),
      ),
    );
  }


}



