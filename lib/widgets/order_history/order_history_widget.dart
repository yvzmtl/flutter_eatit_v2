

import 'package:flutter/material.dart';
import 'package:flutter_eatit_v2/model/order_model.dart';
import 'package:flutter_eatit_v2/state/main_state.dart';
import 'package:flutter_eatit_v2/strings/order_history_string.dart';
import 'package:flutter_eatit_v2/view_model/order_history_vm/order_history_view_model_imp.dart';
import 'order_history_list_widget.dart';

class OrderHistoryWidget extends StatelessWidget {

  final  OrderHistoryViewModelImp orderHistoryViewModelImp;
  final MainStateController mainStateController;
  final String OrderStatusMode;


  OrderHistoryWidget(this.orderHistoryViewModelImp, this.mainStateController,
      this.OrderStatusMode);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: orderHistoryViewModelImp.getUserHistory(mainStateController.selectedRestaurant.value.restaurantId,OrderStatusMode),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),);
        }
        else{
          var lst = snapshot.data as List<OrderModel>;
          if(lst.length == 0){
            return Center(child: Text(emptyText),);
          }
          return OrderHistoryListWidget(listOrder: lst);
        }
      },
    );
  }
}

