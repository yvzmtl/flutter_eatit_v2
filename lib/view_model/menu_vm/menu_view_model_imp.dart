
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_ui/flutter_auth_ui.dart';
import 'package:flutter_eatit_v2/const/const.dart';
import 'package:flutter_eatit_v2/screen/cart.dart';
import 'package:flutter_eatit_v2/screen/category.dart';
import 'package:flutter_eatit_v2/screen/manager_restaurant.dart';
import 'package:flutter_eatit_v2/screen/order_history.dart';
import 'package:flutter_eatit_v2/screen/restaurant_home.dart';
import 'package:flutter_eatit_v2/state/cart_state.dart';
import 'package:flutter_eatit_v2/state/main_state.dart';
import 'package:flutter_eatit_v2/strings/main_strings.dart';
import 'package:flutter_eatit_v2/view_model/menu_vm/menu_view_model.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get_storage/get_storage.dart';

class MenuViewModelImp implements MenuViewModel{
  final cartStateController = Get.put(CartStateController());
  final mainStateController = Get.put(MainStateController());
  @override
  void navigateCategories() {
    Get.to(()=> CategoryScreen());
  }

  @override
  void backToRestaurantList() {
    Get.back(closeOverlays: true, canPop: false);
  }

  // @override
  // void processLoginState(BuildContext context) {
  //   print("Login tıklandı");
  // }

  @override
  bool checkLoginState(BuildContext context) {
    return FirebaseAuth.instance.currentUser != null ? true :false;
  }

  @override
  void login(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    if(user == null){
      FlutterAuthUi.startUi(
          items: [AuthUiProvider.phone],
          tosAndPrivacyPolicy: TosAndPrivacyPolicy(
              tosUrl: "https://google.com",
              privacyPolicyUrl: "https://youtube.com"),
          androidOption: AndroidOption(
              enableSmartLock: false,
              showLogo: true,
              overrideTheme: true
          )
      ).then((value)  async{
        navigationHome(context);
      }).catchError((e){
        Get.snackbar("Hata", "$e");
      });
    }
  }

  @override
  void logout(BuildContext context) {

    Get.defaultDialog(
      title: logoutTitle,
      content: Text(logoutText),
      backgroundColor: Colors.white,
      cancel: ElevatedButton(onPressed: ()=> Get.back(), child: Text(cancelText)),
      confirm: ElevatedButton(onPressed: (){
        FirebaseAuth.instance.signOut().then((value) => Get.offAll(RestaurantHome()));
      },
          child: Text(confirmText,style: TextStyle(color: Colors.red),)),

    );


  }

  @override
  void navigationHome(BuildContext context) async{
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    var box = GetStorage();
    //token kaydet, bildirim  göndermek için kullanacağız
    box.write(KEY_TOKEN, token);
    //clone cart
    if(cartStateController.cart.length > 0){ //boş değilse
      var newCart = cartStateController.getCartAnonymous(mainStateController.selectedRestaurant.value.restaurantId); // koplayadık
      newCart.forEach((element) {
        element.userUid = FirebaseAuth.instance.currentUser!.uid; //userId güncelledik
      });
      cartStateController.cart.addAll(newCart); // bütün sepeti ekledik
      cartStateController.saveDatabase(); //kaydettik
    }
    Get.offAll(()=>RestaurantHome());
  }



  @override
  void navigateCart() => Get.to(()=> CartDetailScreen());

  @override
  void viewOrderHistory(BuildContext context) {
    Get.to(() => OrderHistory());
  }

  @override
  void managerRestaurant(BuildContext context) {
    Get.to(() => ManagerRestaurantScreen());
  }
}