

import 'package:flutter_eatit_v2/model/order_model.dart';
import 'package:flutter_eatit_v2/state/cart_state.dart';

abstract class ProcessOrderViewModel{
  Future<bool> submitOrder(OrderModel orderModel);
  Future<OrderModel> createOrderModel({
    required String restaurantId,
    required double discount,
    required String firstName,
    required String lastName,
    required String address,
    required String comment,
    required CartStateController cartStateController ,
    required bool isCod  });
}