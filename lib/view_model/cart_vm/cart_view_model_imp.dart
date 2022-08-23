

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_eatit_v2/model/cart_model.dart';
import 'package:flutter_eatit_v2/screen/place_order.dart';
import 'package:flutter_eatit_v2/state/cart_state.dart';
import 'package:flutter_eatit_v2/state/main_state.dart';
import 'package:flutter_eatit_v2/view_model/cart_vm/cart_view_model.dart';
import 'package:flutter_eatit_v2/view_model/menu_vm/menu_view_model_imp.dart';
import 'package:get/get.dart';

class CartViewModelImp implements CartViewModel{

  final MainStateController mainStateController = Get.find();
  final MenuViewModelImp menuViewModelImp = new MenuViewModelImp();

  @override
  void updateCart(CartStateController cartStateController,String restaurantId, int index, int value) {
    //miktarı güncelliyoruz
    cartStateController.cart.value = cartStateController.getCart(restaurantId);
    cartStateController.cart[index].quantity = value;
    cartStateController.cart.refresh();
    cartStateController.saveDatabase();
  }

  void deleteCart(CartStateController cartStateController,String restaurantId, int index){
    cartStateController.cart.value = cartStateController.getCart(restaurantId);
    cartStateController.cart.removeAt(index);
    cartStateController.saveDatabase();
  }

  @override
  void clearCart(CartStateController cartStateController) {
    cartStateController.clearCart(mainStateController.selectedRestaurant.value.restaurantId);
  }

  @override
  processCheckout(BuildContext context, List<CartModel> cart) {
    if(FirebaseAuth.instance.currentUser != null){
      Get.to(() => PlaceOrderScreen());
    }
    else{
      menuViewModelImp.login(context);
    }
  }

}