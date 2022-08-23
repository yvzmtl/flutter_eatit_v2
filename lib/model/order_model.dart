
import 'package:flutter_eatit_v2/model/cart_model.dart';

class OrderModel{
  String userId= "",userName="",userPhone="",shippingAddress="",
      comment="",orderNumber="",restaurantId="";
  double totalPayment=0,finalPayment=0,shippingCost=0,discount=0;
  bool isCod = false;
  List<CartModel> cartItemList = List<CartModel>.empty(growable: true);
  int orderStatus=0,createDate=0;


  OrderModel({
     required this.userId,
     required this.userName,
     required this.userPhone,
     required this.shippingAddress,
     required this.comment,
     required this.orderNumber,
     required this.restaurantId,
     required this.totalPayment,
     required this.finalPayment,
     required this.shippingCost,
     required this.discount,
     required this.isCod,
     required this.cartItemList,
     required this.orderStatus,
     required this.createDate});

  OrderModel.fromJson(Map<String,dynamic> json){
    userId = json["userId"];
    userName = json["userName"];
    userPhone = json["userPhone"];
    shippingAddress = json["shippingAddress"];
    comment = json["comment"];
    orderNumber = json["orderNumber"];
    restaurantId = json["restaurantId"];
    totalPayment = double.parse(json["totalPayment"].toString());
    finalPayment = double.parse(json["finalPayment"].toString());
    shippingCost = double.parse(json["shippingCost"].toString());
    discount = double.parse(json["discount"].toString());
    isCod = json["isCod"] as bool;
    orderStatus = int.parse(json["orderStatus"].toString());
    createDate = int.parse(json["createDate"].toString());
    if(json["cartItemList"] != null){
      json["cartItemList"].forEach((v){
        cartItemList.add(CartModel.fromJson(v));
      });
    }

  }

  Map<String,dynamic> toJson(){
    final data = Map<String,dynamic>();
    data["userId"] = this.userId;
    data["userName"] = this.userName;
    data["userPhone"] = this.userPhone;
    data["shippingAddress"] = this.shippingAddress;
    data["comment"] = this.comment;
    data["orderNumber"] = this.orderNumber;
    data["restaurantId"] = this.restaurantId;
    data["totalPayment"] = this.totalPayment;
    data["finalPayment"] = this.finalPayment;
    data["shippingCost"] = this.shippingCost;
    data["discount"] = this.discount;
    data["isCod"] = this.isCod;
    data["orderStatus"] = this.orderStatus;
    data["cartItemList"] = this.cartItemList.map((e) => e.toJson()).toList();
    data["createDate"] = this.createDate;

    return data;
  }
}

