import 'dart:convert';
import 'package:auto_animated/auto_animated.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eatit_v2/const/const.dart';
import 'package:flutter_eatit_v2/model/cart_model.dart';
import 'package:flutter_eatit_v2/model/restaurant_model.dart';
import 'package:flutter_eatit_v2/screen/restaurant_home.dart';
import 'package:flutter_eatit_v2/state/cart_state.dart';
import 'package:flutter_eatit_v2/state/main_state.dart';
import 'package:flutter_eatit_v2/strings/main_strings.dart';

import 'package:flutter_eatit_v2/view_model/main_vm/main_view_model_imp.dart';
import 'package:flutter_eatit_v2/widgets/common/common_widgets.dart';
import 'package:flutter_eatit_v2/widgets/main/main_widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();
  await GetStorage.init();
  runApp( MyApp(app: app));
}

class MyApp extends StatelessWidget {
  final FirebaseApp app;

  MyApp({required this.app});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(app:app),
    );
  }
}

class MyHomePage extends StatefulWidget{

  final FirebaseApp app;
  final viewModel = MainViewModelImp();
  final mainStateController = Get.put(MainStateController());
  final cartStateController = Get.put(CartStateController());
  final box = GetStorage();

  MyHomePage({required this.app});

  @override
  MyHomePageState createState() => MyHomePageState();

}

class MyHomePageState extends State<MyHomePage>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(widget.box.hasData(MY_CART_KEY)){
        var cartSave = await widget.box.read(MY_CART_KEY) as String;
        if(cartSave.length > 0 && cartSave.isNotEmpty){
          final listCart = jsonDecode(cartSave) as List<dynamic>;
          final listCartParsed = listCart.map((e) => CartModel.fromJson(e)).toList();
          if(listCartParsed.length > 0){
            widget.cartStateController.cart.value = listCartParsed;
          }
        }
      }
      else{
        widget.cartStateController.cart.value = new List<CartModel>.empty(growable: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(restaurantText,
        style: GoogleFonts.jetBrainsMono(
            fontWeight: FontWeight.w900, color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 10,
      ),
      body: FutureBuilder(
        future: widget.viewModel.displayRestaurantList(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator(),);
          else{
            var lst = snapshot.data as List<RestaurantModel>;
            return Container(
              margin: const EdgeInsets.only(top: 10),
              child: LiveList(
                showItemDuration: Duration(milliseconds: 350),
                showItemInterval: Duration(milliseconds: 150),
                reAnimateOnVisibility: true,
                scrollDirection: Axis.vertical,
                itemCount: lst.length,
                itemBuilder: animationItemBuilder((index)=>
                    InkWell(
                      onTap: (){
                        widget.mainStateController.selectedRestaurant.value = lst[index];
                        Get.to(()=> RestaurantHome());
                      },
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height/2.5*1.1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RestaurantImageWidget(
                                imageUrl : lst[index].imageUrl),
                            RestaurantInfoWidget(name: lst[index].name, address: lst[index].address)
                          ],
                        ),
                      ),
                    ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}


