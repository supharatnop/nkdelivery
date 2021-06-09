class DeliveryModel {
  String deliveryID;
  String username;
  String password;
  String nameDelivery;
  String addressDelivery;
  String phoneDelivery;
  String typeId;
  String numberDriver;
  String numberCar;
  String token;
  String lat;
  String lng;

  DeliveryModel(
      {this.deliveryID,
      this.username,
      this.password,
      this.nameDelivery,
      this.addressDelivery,
      this.phoneDelivery,
      this.typeId,
      this.numberDriver,
      this.numberCar,
      this.token,
      this.lat,
      this.lng});

  DeliveryModel.fromJson(Map<String, dynamic> json) {
    deliveryID = json['deliveryID'];
    username = json['username'];
    password = json['password'];
    nameDelivery = json['name_delivery'];
    addressDelivery = json['address_delivery'];
    phoneDelivery = json['phone_delivery'];
    typeId = json['type_id'];
    numberDriver = json['number_driver'];
    numberCar = json['number_car'];
    token = json['token'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deliveryID'] = this.deliveryID;
    data['username'] = this.username;
    data['password'] = this.password;
    data['name_delivery'] = this.nameDelivery;
    data['address_delivery'] = this.addressDelivery;
    data['phone_delivery'] = this.phoneDelivery;
    data['type_id'] = this.typeId;
    data['number_driver'] = this.numberDriver;
    data['number_car'] = this.numberCar;
    data['token'] = this.token;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
