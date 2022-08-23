import 'package:flutter/material.dart';
import 'package:flutter_eatit_v2/state/cart_state.dart';
import 'package:flutter_eatit_v2/state/main_state.dart';
import 'package:flutter_eatit_v2/strings/cart_string.dart';
import 'package:flutter_eatit_v2/view_model/cart_vm/cart_view_model_imp.dart';
import 'package:flutter_eatit_v2/widgets/cart/cart_image_widget.dart';
import 'package:flutter_eatit_v2/widgets/cart/cart_info_widget.dart';
import 'package:flutter_eatit_v2/widgets/cart/cart_total_widget.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartDetailScreen extends StatelessWidget{
  final box = GetStorage();
  final CartStateController cartStateController = Get.find();
  final CartViewModelImp cartViewModelImp = CartViewModelImp();
  final MainStateController mainStateController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sepet"),
        actions: [
          cartStateController.getQuantity(mainStateController.selectedRestaurant.value.restaurantId) > 0
              ? IconButton(
            onPressed: (){
              Get.defaultDialog(
                title: clearCartConfirmTitleText,
                middleText: clearCartConfirmContentText,
                textCancel: cancelText,
                textConfirm: confirmText,
                confirmTextColor: Colors.yellow,
                onConfirm: ()=> cartViewModelImp.clearCart(cartStateController),
              );

            },
            icon: Icon(Icons.clear),
          )
              : Container(),
        ],
      ),
      body: cartStateController.getQuantity(mainStateController.selectedRestaurant.value.restaurantId)> 0
          ? Obx(()=> Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartStateController.getCart(
                  mainStateController.selectedRestaurant.value.restaurantId).length ,
              itemBuilder: (context,index)=> Slidable(
                child: Card(
                  elevation: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex:2,
                          child:CartImageWidget(cartStateController: cartStateController,
                            cartModel: cartStateController.getCart(
                                mainStateController.selectedRestaurant.value.restaurantId)[index],
                          ),
                        ),
                        Expanded(
                          flex:6,
                          child: CartInfo(cartModel: cartStateController.getCart(
                              mainStateController.selectedRestaurant.value.restaurantId)[index]),
                        ),
                        Center(
                          child: ElegantNumberButton(
                              initialValue: cartStateController.getCart(
                                  mainStateController.selectedRestaurant.value.restaurantId)[index].quantity,
                              minValue: 1,
                              maxValue: 100,
                              color: Colors.amber,
                              onChanged: (value){
                                cartViewModelImp.updateCart(cartStateController,mainStateController.selectedRestaurant.value.restaurantId, index,value.toInt() );
                              },
                              decimalPlaces: 0),
                        )
                      ],
                    ),
                  ),
                ),
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      label: deleteText,
                      icon: Icons.delete,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      onPressed: (context){
                        Get.defaultDialog(
                            title: deleteCartConfirmTitleText,
                            middleText: deleteCartConfirmContentText,
                            textCancel: cancelText,
                            textConfirm: confirmText,
                            confirmTextColor: Colors.yellow,
                            onConfirm: () {
                              cartViewModelImp.deleteCart(
                                  cartStateController,mainStateController.
                              selectedRestaurant.value.restaurantId, index);
                              Get.back();

                            });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          TotalWidget(cartStateController: cartStateController,),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: ()=> cartViewModelImp.processCheckout(context,cartStateController.getCart(
                      mainStateController.selectedRestaurant.value.restaurantId)),
              child: Text(checkOutText),
            ),
          ),

        ],
      )
      )
          : Center(child: Text(cartEmptyText),
      ),
    );
  }

}





