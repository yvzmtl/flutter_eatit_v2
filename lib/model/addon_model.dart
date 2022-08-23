

class AddonModel{
  String name ='';
  double price = 0;

  AddonModel(this.name, this.price);

  AddonModel.fromJson(Map<String,dynamic> json){
    name = json["name"];
    price = double.parse(json["price"].toString());
  }

  Map<String,dynamic> toJson(){
    final data = Map<String,dynamic>();

    data["name"] = this.name;
    data["price"] = this.price;

    return data;
  }
}