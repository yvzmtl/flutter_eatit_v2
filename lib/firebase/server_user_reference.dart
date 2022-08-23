

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_eatit_v2/const/const.dart';
import 'package:flutter_eatit_v2/model/server_user_model.dart';

Future<bool> checkIsServerUser(String userId) async {
  var source = await FirebaseDatabase.instance
      .ref()
      .child(SERVER_REF)
      .child(userId)
      .once();
  return source.snapshot.exists;
}

Future<bool> checkIsUserInRestaurant(String userId,String restaurantId) async {
  var source = await FirebaseDatabase.instance
      .ref()
      .child(SERVER_REF)
      .child(userId)
      .once();
  var result = ServerUserModel.fromJson(jsonDecode(jsonEncode(source.snapshot.value)));
  return result.isActive && result.restaurant == restaurantId;
}

Future<bool> writeServerUserToFirebase(ServerUserModel serverUserModel) async{
  try{
    await FirebaseDatabase.instance
        .ref()
        .child(SERVER_REF)
        .child(serverUserModel.uid)
        .set(serverUserModel.toJson());

    return true;
  }
  catch(e){
    print(e);
    return false;
  }
}