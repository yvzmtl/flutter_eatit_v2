
import 'package:flutter/material.dart';
import 'package:flutter_eatit_v2/model/cart_model.dart';
import 'package:flutter_eatit_v2/state/cart_state.dart';

abstract class CartViewModel{
    void updateCart(CartStateController cartStateController,String restaurantIdi, int index, int value);
    void deleteCart(CartStateController cartStateController, String restaurantId,int index);
    void clearCart(CartStateController cartStateController);
    processCheckout(BuildContext context, List<CartModel> cart);

}