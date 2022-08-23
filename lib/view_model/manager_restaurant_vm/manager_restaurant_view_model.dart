
import 'package:flutter_eatit_v2/model/server_user_model.dart';

abstract class ManagerRestaurantViewModel{
  Future registerServerUser(ServerUserModel serverUserModel);
}