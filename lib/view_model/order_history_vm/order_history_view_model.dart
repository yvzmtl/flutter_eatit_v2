

import 'package:flutter_eatit_v2/model/order_model.dart';

abstract class OrderHistoryViewModel{
  Future<List<OrderModel>> getUserHistory(String restaurantId,String OrderStatusMode);
}