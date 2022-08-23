

import 'package:flutter/material.dart';
import 'package:flutter_eatit_v2/state/cart_state.dart';
import 'package:flutter_eatit_v2/state/main_state.dart';
import 'package:flutter_eatit_v2/strings/cart_string.dart';
import 'package:flutter_eatit_v2/utils/utils.dart';
import 'package:get/get.dart';
import 'cart_total_item_widget.dart';


class TotalWidget extends StatelessWidget {
   TotalWidget({
    Key? key,
    required this.cartStateController,
  }) : super(key: key);

  final CartStateController cartStateController;
  final MainStateController mainStateController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TotalItemWidget(
                text: totaltext,
                value: currencyFormat.format(cartStateController.sumCart(mainStateController.selectedRestaurant.value.restaurantId)),
                isSubTotal: false
            ),
            Divider(thickness: 2),
            TotalItemWidget(
                text: shippingFeeText,
                value: currencyFormat.format(cartStateController.getShippingFee(mainStateController.selectedRestaurant.value.restaurantId)),
                isSubTotal: false
            ),
            Divider(thickness: 2),
            TotalItemWidget(
                text: subTotal,
                value: currencyFormat.format(cartStateController.getSubTotal(mainStateController.selectedRestaurant.value.restaurantId)),
                isSubTotal: true
            )
          ],
        ),
      ),
    );
  }
}

