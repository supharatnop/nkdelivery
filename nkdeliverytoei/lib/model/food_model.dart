class FoodModel {
  String productID;
  String storeID;
  String productname;
  String detail;
  String price;
  String photo;

  FoodModel(
      {this.productID,
      this.storeID,
      this.productname,
      this.detail,
      this.price,
      this.photo});

  FoodModel.fromJson(Map<String, dynamic> json) {
    productID = json['productID'];
    storeID = json['storeID'];
    productname = json['productname'];
    detail = json['detail'];
    price = json['price'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productID'] = this.productID;
    data['storeID'] = this.storeID;
    data['productname'] = this.productname;
    data['detail'] = this.detail;
    data['price'] = this.price;
    data['photo'] = this.photo;
    return data;
  }
}
