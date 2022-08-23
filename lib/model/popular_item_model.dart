

class PopularItemModel{
  String foodId = '', name = '', menuId = '', image = '';

  PopularItemModel(this.foodId, this.name, this.menuId, this.image);

  PopularItemModel.fromJson(Map<String,dynamic> json){
    foodId = json["food_id"] == null ? '' : json["food_id"];
    name = json["name"]== null ? '' : json["name"];
    menuId = json["menu_id"]== null ? '' : json["menu_id"];
    image = json["image"]== null ? '' : json["image"];
  }

  Map<String,dynamic> toJson(){
    final data = Map<String,dynamic>();

    data["food_id"] = this.foodId;
    data["name"] = this.name;
    data["menu_id"] = this.menuId;
    data["image"] = this.image;

    return data;
  }
}