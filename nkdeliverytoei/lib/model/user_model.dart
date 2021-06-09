class UserModel {
  String storeID;
  String username;
  String password;
  String storeName;
  String commercialNumber;
  String nameOperator;
  String addressStore;
  String longitude;
  String latitude;
  String addressOperator;
  String phoneStore;
  String pImg;
  String status;
  String token;
  String timeopen;
  String timeclose;
  String dayopen;
  String dayclose;

  UserModel(
      {this.storeID,
      this.username,
      this.password,
      this.storeName,
      this.commercialNumber,
      this.nameOperator,
      this.addressStore,
      this.longitude,
      this.latitude,
      this.addressOperator,
      this.phoneStore,
      this.pImg,
      this.status,
      this.token,
      this.timeopen,
      this.timeclose,
      this.dayopen,
      this.dayclose});

  UserModel.fromJson(Map<String, dynamic> json) {
    storeID = json['storeID'];
    username = json['username'];
    password = json['password'];
    storeName = json['store_name'];
    commercialNumber = json['commercial_number'];
    nameOperator = json['name_operator'];
    addressStore = json['address_store'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    addressOperator = json['address_operator'];
    phoneStore = json['phone_store'];
    pImg = json['p_img'];
    status = json['status'];
    token = json['token'];
    timeopen = json['timeopen'];
    timeclose = json['timeclose'];
    dayopen = json['dayopen'];
    dayclose = json['dayclose'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeID'] = this.storeID;
    data['username'] = this.username;
    data['password'] = this.password;
    data['store_name'] = this.storeName;
    data['commercial_number'] = this.commercialNumber;
    data['name_operator'] = this.nameOperator;
    data['address_store'] = this.addressStore;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['address_operator'] = this.addressOperator;
    data['phone_store'] = this.phoneStore;
    data['p_img'] = this.pImg;
    data['status'] = this.status;
    data['token'] = this.token;
    data['timeopen'] = this.timeopen;
    data['timeclose'] = this.timeclose;
    data['dayopen'] = this.dayopen;
    data['dayclose'] = this.dayclose;
    return data;
  }
}
