

import 'package:flutter_eatit_v2/firebase/order_reference.dart';
import 'package:flutter_eatit_v2/model/order_model.dart';
import 'package:flutter_eatit_v2/view_model/order_history_vm/order_history_view_model.dart';

class OrderHistoryViewModelImp extends OrderHistoryViewModel{
  @override
  Future<List<OrderModel>> getUserHistory(String restaurantId,String orderStatusMode) {
    return getUserOrderByRestaurant(restaurantId,orderStatusMode);
  }

}