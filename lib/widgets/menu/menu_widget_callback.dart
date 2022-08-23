
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuWidgetCallback extends StatelessWidget {

  final String menuName;
  final Function(BuildContext context) callback;
  final IconData icon;
  // final ZoomDrawerController zoomDrawerController;

  const MenuWidgetCallback({
    Key? key,
    required this.menuName,
    required this.callback,
    required this.icon,
    // required this.zoomDrawerController,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callback(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon,color: Colors.white),
            SizedBox(width: 30,),
            Text(menuName,
              style: GoogleFonts.jetBrainsMono(fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),),
          ],
        ),
      ),
    );
  }
}