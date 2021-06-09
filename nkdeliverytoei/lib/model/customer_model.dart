class CustomerModel {
  String customerID;
  String username;
  String password;
  String customerName;
  String addressCus;
  String phoneCus;
  String lat;
  String lng;
  String token;

  CustomerModel(
      {this.customerID,
      this.username,
      this.password,
      this.customerName,
      this.addressCus,
      this.phoneCus,
      this.lat,
      this.lng,
      this.token});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    customerID = json['customerID'];
    username = json['username'];
    password = json['password'];
    customerName = json['customer_name'];
    addressCus = json['address_cus'];
    phoneCus = json['phone_cus'];
    lat = json['lat'];
    lng = json['lng'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerID'] = this.customerID;
    data['username'] = this.username;
    data['password'] = this.password;
    data['customer_name'] = this.customerName;
    data['address_cus'] = this.addressCus;
    data['phone_cus'] = this.phoneCus;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['token'] = this.token;
    return data;
  }
}
