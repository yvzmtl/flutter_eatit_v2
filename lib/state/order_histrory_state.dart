

import 'package:flutter_eatit_v2/model/cart_model.dart';
import 'package:flutter_eatit_v2/model/order_model.dart';
import 'package:get/get.dart';

class OrderHistoryState extends GetxController{
  var selectedOrder = new OrderModel(
      userId: "userId",
      userName: "userName",
      userPhone: "userPhone",
      shippingAddress: "shippingAddress",
      comment: "comment",
      orderNumber: "orderNumber",
      restaurantId: "restaurantId",
      totalPayment: 0,
      finalPayment: 0,
      shippingCost: 0,
      discount: 0,
      isCod: true,
      cartItemList: new List<CartModel>.empty(),
      orderStatus: 0,
      createDate: 0
  ).obs;
}