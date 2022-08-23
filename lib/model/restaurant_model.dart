class RestaurantModel{

  String restaurantId='',address='', name = '', imageUrl = '', paymentUrl = '', phone = '';

  RestaurantModel(
      {required this.address,
        required this.name,
        required this.imageUrl,
        required this.paymentUrl,
        required this.phone});

  // RestaurantModel(
  //      this.address,
  //       this.name,
  //       this.imageUrl,
  //       this.paymentUrl,
  //       this.phone);

  RestaurantModel.fromJson(Map<String,dynamic> json){
    address = json["address"];
    name = json["name"];
    imageUrl = json["imageUrl"];
    paymentUrl = json["paymentUrl"];
    phone = json["phone"];
  }

  Map<String,dynamic> toJson(){
    var data = Map<String, dynamic>();

    data["address"] = this.address;
    data["name"] = this.name;
    data["imageUrl"] = this.imageUrl;
    data["paymentUrl"] = this.paymentUrl;
    data["phone"] = this.phone;

    return data;
  }
}