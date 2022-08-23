

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_eatit_v2/firebase/order_reference.dart';
import 'package:flutter_eatit_v2/firebase/server_time_offset_reference.dart';
import 'package:flutter_eatit_v2/model/order_model.dart';
import 'package:flutter_eatit_v2/state/cart_state.dart';
import 'package:flutter_eatit_v2/utils/utils.dart';
import 'package:flutter_eatit_v2/view_model/process_order/process_order_view_model.dart';

class ProcessOrderViewMOdelImp extends ProcessOrderViewModel{
  @override
  Future<bool> submitOrder(OrderModel orderModel) {
    return writeOrderToFirebase(orderModel);
  }

  @override
  Future<OrderModel> createOrderModel({
     required String restaurantId,
     required double discount,
     required String firstName,
     required String lastName,
     required String address,
     required String comment,
     required CartStateController cartStateController ,
     required bool isCod  }) async {
      var servetTime = await getServerTimeOffset();
    return OrderModel(
        userId: FirebaseAuth.instance.currentUser!.uid,
        userName:"$firstName $lastName",
        userPhone: FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
        shippingAddress : address,
        comment : comment,
        orderNumber : createOrderNumber(servetTime).toString(),
        restaurantId : restaurantId,
        totalPayment : cartStateController.getSubTotal(restaurantId),
        finalPayment : calculateFinalPayment(cartStateController.getSubTotal(restaurantId),discount),
        shippingCost : cartStateController.getShippingFee(restaurantId),
        discount : discount,
        isCod : isCod,
        cartItemList : cartStateController.getCart(restaurantId),
        orderStatus : 0,
        createDate : servetTime);
  }



}