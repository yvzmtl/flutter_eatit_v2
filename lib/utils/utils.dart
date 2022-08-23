

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eatit_v2/model/addon_model.dart';
import 'package:intl/intl.dart';

final currencyFormat = NumberFormat.simpleCurrency();

double foodDetailImageAreaSize(BuildContext context){

  return MediaQuery.of(context).size.height/3;
}

int createOrderNumber(int original){
  return original + new Random().nextInt(1000);
}

double calculateFinalPayment(double subTotal, double discount){
  return subTotal - (subTotal*(discount/100));
}

String convertToDate(int date){
  return DateFormat("dd-MM-yyyy HH:mm").format(DateTime.fromMillisecondsSinceEpoch(date));
}

String convertStatus(int status){
  return status == 0
      ? "Hazırlanıyor"
      :status == 1
        ? "Yolda"
        : status == 2
          ? "Teslim edildi"
          : "iptal edildi";
}

MaterialColor convertStatusToColor(int orderStatus){
  return orderStatus == -1 ? Colors.red
      : orderStatus == 0 ? Colors.blue
        :orderStatus == 1 ? Colors.yellow
          :Colors.green;
}

String convertAddonToText(List<AddonModel> addon){
  var result = "";
  addon.map((e) => result += "${e.name}");
  return result.length > 0 ? result.substring(0,result.length - 1) : result;
}