class OrderListModel {
  String orderlistID;
  String datetime;
  String customerID;
  String customerName;
  String addressCus;
  String phoneCus;
  String lat;
  String lng;
  String storeID;
  String storeName;
  String addressStore;
  String latitude;
  String longitude;
  String distance;
  String transport;
  String productID;
  String productname;
  String price;
  String amount;
  String sum;
  String total;
  String totalprice;
  String deliveryID;
  String status;

  OrderListModel(
      {this.orderlistID,
      this.datetime,
      this.customerID,
      this.customerName,
      this.addressCus,
      this.phoneCus,
      this.lat,
      this.lng,
      this.storeID,
      this.storeName,
      this.addressStore,
      this.latitude,
      this.longitude,
      this.distance,
      this.transport,
      this.productID,
      this.productname,
      this.price,
      this.amount,
      this.sum,
      this.total,
      this.totalprice,
      this.deliveryID,
      this.status});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    orderlistID = json['orderlistID'];
    datetime = json['datetime'];
    customerID = json['customerID'];
    customerName = json['customer_name'];
    addressCus = json['address_cus'];
    phoneCus = json['phone_cus'];
    lat = json['lat'];
    lng = json['lng'];
    storeID = json['storeID'];
    storeName = json['store_name'];
    addressStore = json['address_store'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distance = json['distance'];
    transport = json['transport'];
    productID = json['productID'];
    productname = json['productname'];
    price = json['price'];
    amount = json['amount'];
    sum = json['sum'];
    total = json['total'];
    totalprice = json['totalprice'];
    deliveryID = json['deliveryID'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderlistID'] = this.orderlistID;
    data['datetime'] = this.datetime;
    data['customerID'] = this.customerID;
    data['customer_name'] = this.customerName;
    data['address_cus'] = this.addressCus;
    data['phone_cus'] = this.phoneCus;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['storeID'] = this.storeID;
    data['store_name'] = this.storeName;
    data['address_store'] = this.addressStore;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['distance'] = this.distance;
    data['transport'] = this.transport;
    data['productID'] = this.productID;
    data['productname'] = this.productname;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['sum'] = this.sum;
    data['total'] = this.total;
    data['totalprice'] = this.totalprice;
    data['deliveryID'] = this.deliveryID;
    data['status'] = this.status;
    return data;
  }
}
