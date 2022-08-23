


import 'package:flutter/material.dart';
import 'package:flutter_eatit_v2/const/const.dart';
import 'package:flutter_eatit_v2/state/main_state.dart';
import 'package:flutter_eatit_v2/strings/main_strings.dart';
import 'package:flutter_eatit_v2/view_model/order_history_vm/order_history_view_model_imp.dart';
import 'package:flutter_eatit_v2/widgets/order_history/order_history_widget.dart';
import 'package:get/get.dart';

class OrderHistory extends StatelessWidget {


  final orderHistoryViewModelImp = new OrderHistoryViewModelImp();
  final MainStateController mainStateController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Text(orderHistoryText),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.cancel)),
                  Tab(icon: Icon(Icons.refresh)),
                  Tab(icon: Icon(Icons.check)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                OrderHistoryWidget(orderHistoryViewModelImp, mainStateController, ORDER_CANCELLED),
                OrderHistoryWidget(orderHistoryViewModelImp, mainStateController, ORDER_PROCESSING),
                OrderHistoryWidget(orderHistoryViewModelImp, mainStateController, ORDER_SHIPPED),
              ],
            )
        ),
      ),
    );
  }
}
