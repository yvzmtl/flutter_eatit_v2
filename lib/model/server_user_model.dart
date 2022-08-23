
class ServerUserModel{
  String name = "",restaurant="",uid="",phone="";
  bool _isActive = false;
  bool get isActive => _isActive;

  ServerUserModel(this.name, this.restaurant, this.uid, this.phone);

  ServerUserModel.fromJson(Map<String,dynamic> json){
    restaurant = json["restaurant"];
    name = json["name"];
    uid = json["uid"];
    phone = json["phone"];
    _isActive = json["isActive"] as bool;
  }

  Map<String,dynamic> toJson(){
    var data = Map<String,dynamic>();
    data["restaurant"] = this.restaurant;
    data["name"] = this.name;
    data["uid"] = this.uid;
    data["phone"] = this.phone;
    data["isActive"] = this._isActive;

    return data;
  }
}