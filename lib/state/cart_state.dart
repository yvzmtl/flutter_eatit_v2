

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_eatit_v2/const/const.dart';
import 'package:flutter_eatit_v2/model/cart_model.dart';
import 'package:flutter_eatit_v2/model/food_model.dart';
import 'package:flutter_eatit_v2/strings/cart_string.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartStateController extends GetxController{

  var cart = List<CartModel>.empty(growable: true).obs;
  final box = GetStorage();

  List<CartModel> getCartAnonymous(String restaurantId) =>
      cart.where((item) =>
      item.restaurantId == restaurantId &&(item.userUid == KEY_ANONYMOUS)
      ).toList();


  List<CartModel> getCart(String restaurantId) {
    return cart.where((item) => item.restaurantId == restaurantId &&
        (FirebaseAuth.instance.currentUser == null
            ? item.userUid == KEY_ANONYMOUS
            : item.userUid == FirebaseAuth.instance.currentUser!.uid)
    ).toList();
  }

  addToCart(FoodModel foodModel,String restaurantId,{int quantity:1}) async {
    try{
      var cartItem = CartModel(
        id:foodModel.id,
        name:foodModel.name,
        image:foodModel.image,
        price:foodModel.price,
        size:foodModel.size,
        addon:foodModel.addon,
        description: foodModel.description,
        quantity: quantity,
        restaurantId: restaurantId,
        userUid: FirebaseAuth.instance.currentUser == null ? KEY_ANONYMOUS
            :FirebaseAuth.instance.currentUser!.uid,
      );
      if(isExists(cartItem,restaurantId)){
        //eğer cart içinde aynı üründen varsa sadece miktarını arttıracak
        var foodNeedToUpdate = cart.firstWhere((element) =>
        element.id == cartItem.id);
        foodNeedToUpdate.quantity += quantity;
      }
      else{
        cart.add(cartItem);
      }
      // bilgi güncellendikten sonra, storage kaydedeceğiz
      var jsonDBEncode = jsonEncode(cart);
      await box.write(MY_CART_KEY, jsonDBEncode);
      cart.refresh();
      Get.snackbar(successTitle, successMessage);
    }
    catch(e){
      Get.snackbar(errorTitle, e.toString());
    }
  }

  isExists(CartModel cartItem,String restaurantId) {
    return cart.any((e) => e.id == cartItem.id && e.restaurantId == restaurantId &&
        (FirebaseAuth.instance.currentUser == null
            ? e.userUid == KEY_ANONYMOUS
            : e.userUid == FirebaseAuth.instance.currentUser!.uid));
  }

  sumCart(String restaurantId){
    return getCart(restaurantId).length == 0 ? 0 : getCart(restaurantId).map((e) => e.price*e.quantity)
        .reduce((value, element) => value+element);
  }

  int getQuantity(String restaurantId){
    return getCart(restaurantId).length == 0 ? 0 : getCart(restaurantId).map((e) => e.quantity)
        .reduce((value, element) => value+element);
  }

  getShippingFee(String restaurantId){
    return sumCart(restaurantId)*0.1; //toplam değerden %10 ekleme
  }

  getSubTotal(String restaurantId){
    return sumCart(restaurantId)+getShippingFee(restaurantId);
  }

  clearCart(String restaurantId) {
    cart.value = getCart(restaurantId);
    cart.clear();
    saveDatabase();
  }

  saveDatabase() => box.write(MY_CART_KEY, jsonEncode(cart));
}
