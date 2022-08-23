
import 'package:flutter/material.dart';

abstract class MenuViewModel{
  void navigateCategories();
  void backToRestaurantList();
  // void processLoginState(BuildContext context);
  bool checkLoginState(BuildContext context);
  void login(BuildContext context);
  void logout(BuildContext context);
  void navigationHome(BuildContext context);
  void navigateCart();
  void viewOrderHistory(BuildContext context);
  void managerRestaurant(BuildContext context);
}