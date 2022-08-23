

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalItemWidget extends StatelessWidget {
  const TotalItemWidget({
    Key? key,
    required this.text,
    required this.value,
    required this.isSubTotal,
  }) : super(key: key);

  final String text;
  final String value;
  final bool isSubTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: GoogleFonts.jetBrainsMono(
              fontSize: isSubTotal? 20 : 16,
              fontWeight: FontWeight.bold,
            color: isSubTotal ? Colors.red : Colors.black
          ),
        ),
        Text(
          value,
          style: GoogleFonts.jetBrainsMono(
              fontSize: isSubTotal ? 20 : 16,
              fontWeight: FontWeight.bold,
              color: isSubTotal ? Colors.red : Colors.black
          ),
        ),
      ],
    );
  }
}