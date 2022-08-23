

import 'package:flutter/material.dart';
import 'package:flutter_eatit_v2/model/cart_model.dart';
import 'package:flutter_eatit_v2/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class CartInfo extends StatelessWidget {
  const CartInfo({
    Key? key,
    required this.cartModel,
  }) : super(key: key);

  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              cartModel.name,
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.monetization_on,
                    color: Colors.grey,
                    size: 16,
                  ),
                  SizedBox(width:4),
                  Text(
                    "${currencyFormat.format(cartModel.price)}",
                    style: GoogleFonts.jetBrainsMono(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // SizedBox(width:1),
                  // Text("₺"),
                ],
              )
          ),
        ],
      ),
    );
  }
}