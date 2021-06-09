import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nkdeliverytoei/model/customer_model.dart';
import 'package:nkdeliverytoei/model/orderlist_model.dart';
import 'package:nkdeliverytoei/utility/my_constant.dart';
import 'package:nkdeliverytoei/utility/my_dialog.dart';
import 'package:nkdeliverytoei/utility/my_style.dart';

class ConFirmOrder extends StatefulWidget {
  final OrderListModel orderListModel;
  ConFirmOrder({Key key, this.orderListModel}) : super(key: key);

  @override
  _ConFirmOrderState createState() => _ConFirmOrderState();
}

class _ConFirmOrderState extends State<ConFirmOrder> {
  //String idStore;
  List<OrderListModel> orderListmodel;
  OrderListModel orderListModel;
  CustomerModel customerModel;
  String timeOr,
      nameCus,
      addressCus,
      phonCus,
      menuOr,
      priceMenu,
      amountMenu,
      sumMenu,
      totalMenu,
      transport,
      idOrderList,
      totalPrice;

 // String idCus = CustomerModel().customerID ;


 String customerID ;

  List<List<String>> listMenuFood = List();
  List<List<String>> listPriceFood = List();
  List<List<String>> listTotalFood = List();
  List<List<String>> listSumFood = List(); //อาเรย์ซ้อนอาเรย์

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //findidStore();

    orderListModel = widget.orderListModel;
    idOrderList = orderListModel.orderlistID;
    timeOr = orderListModel.datetime;
    nameCus = orderListModel.customerName;
    addressCus = orderListModel.addressCus;
    phonCus = orderListModel.phoneCus;
    menuOr = orderListModel.productname;
    priceMenu = orderListModel.price;
    amountMenu = orderListModel.amount;
    sumMenu = orderListModel.sum;
    totalMenu = orderListModel.total;
    transport = orderListModel.transport;
    totalPrice = orderListModel.totalprice;
 
    changeAr();
      
  }

  Future<Null> changeAr() {
    List<String> menuFood = changeArrey(orderListModel.productname);
    print('namefood00000 ==> $menuFood');
    List<String> priceFood = changeArrey(orderListModel.price);
    List<String> totalFood = changeArrey(orderListModel.amount);
    List<String> sumFood = changeArrey(orderListModel.sum);

    setState(() {
      listPriceFood.add(priceFood);
      listTotalFood.add(totalFood);
      listSumFood.add(sumFood);
      listMenuFood.add(menuFood);
    });
  }

  //ถอดอาเรย์ในดาต้าเบส
  List<String> changeArrey(String string) {
    List<String> list = List();
    String myString = string.substring(1, string.length - 1);
    print('myString0000000 = $myString');
    list = myString.split(',');

    //เอาช่องว่างออก
    int index = 0;
    for (var string in list) {
      list[index] = string.trim();
      index++;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ยืนยันรายการสั่งซื้อ'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.00),
        itemCount: 1,
        itemBuilder: (context, index) => Column(
          children: [
            buildShowHead(),
            Mystyle().mySizebox(),
            headTable(),
            buildListViewNamefood(index),
            Divider(),
            Mystyle().mySizebox(),
            buildShowBottom(),
            Mystyle().mySizebox(),
            Mystyle().mySizebox(),
            buildButton(),
          ],
        ),
      ),
    );
  }

  Row buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 160,
          child: RaisedButton.icon(
            color: Colors.red,
            onPressed: () {
              editValueOnMySQLCancel();
            },
            icon: Icon(
              Icons.cancel_outlined,
              color: Colors.white,
            ),
            label: Text(
              'ไม่ยืนยัน',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          width: 160,
          child: RaisedButton.icon(
            color: Colors.green,
            onPressed: () => editValueOnMySQLDelivery(),
            icon: Icon(
              Icons.restaurant_menu_outlined,
              color: Colors.white,
            ),
            label: Text(
              'ยืนยัน',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  //  Future<Null> chooseDelivery() async {
  //   showDialog(
  //     context: context,
  //     builder: (context) => SimpleDialog(
  //       title: Center(child: Text('กรุณาเลือกการจัดส่ง')),
  //       children: [
  //         Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             FlatButton(
  //               onPressed: () {} ,
  //               child: Text('จัดส่งเอง', style: TextStyle(color: Colors.teal),),
  //             ),
  //             FlatButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //                 editValueOnMySQLDelivery();
  //               },
  //               child: Text('พนักงานจัดส่ง', style: TextStyle(color: Colors.blue),),

  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Future<Null> editValueOnMySQLDelivery() async {
  //   String id = orderListModel.orderlistID;
  //   String url =
  //       '${MyConstant().domain}/nkdeliverytoei/editStatusWhereId.php?isAdd=true&orderlistID=$id&status=StoreOrder';
  //   print('=====$url');
  //   await Dio().get(url).then(
  //     (value) {
  //       if (value.toString() == 'true') {
  //         notifcationToCustomer(customerID);

  //         Navigator.pop(context);
  //       } else {
  //         myDialog(context, 'กรุณาลองใหม่');
  //       }
  //     },
  //   );
  // }

  Future<Null> editValueOnMySQLDelivery() async {
    String id = orderListModel.orderlistID;
    String url =
        '${MyConstant().domain}/nkdeliverytoei/editStatusWhereId.php?isAdd=true&orderlistID=$id&status=StoreOrder';
    print('=====$url');
    await Dio().get(url).then(
      (value) {
        if (value.toString() == 'true') {
          noficationToCus(customerID);
          Navigator.pop(context);
        } else {
          myDialog(context, 'กรุณาลองใหม่');
        }
      },
    );
  }

//แจ้งเตือนไปยังลูกค้า
Future<Null> noficationToCus(String customerID) async {
  String urlFindToken = '${MyConstant().domain}/nkdeliverytoei/getCusIdOrder.php?isAdd=true&customerID=$customerID';
 await Dio().get(urlFindToken).then((value) {
   var result = json.decode(value.data);
   print('result ******* $result');
 });

}



 
  Future<Null> editValueOnMySQLCancel() async {
    String id = orderListModel.orderlistID;
    String url =
        '${MyConstant().domain}/nkdeliverytoei/editStatusWhereId.php?isAdd=true&orderlistID=$id&status=CancelOrder';
    print('=====$url');
    await Dio().get(url).then(
      (value) {
        if (value.toString() == 'true') {
          Navigator.pop(context);
        } else {
          myDialog(context, 'กรุณาลองใหม่');
        }
      },
    );
  }

  ListView buildListViewNamefood(int index) => ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: listMenuFood[index].length,
        itemBuilder: (context, index2) => Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(listMenuFood[index][index2]),
            ),
            Expanded(
              flex: 1,
              child: Center(child: Text(listPriceFood[index][index2])),
            ),
            Expanded(
              flex: 1,
              child: Center(child: Text(listTotalFood[index][index2])),
            ),
            Expanded(
              flex: 1,
              child: Center(child: Text(listSumFood[index][index2])),
            ),
          ],
        ),
      );

  Widget headTable() {
    return Container(
      decoration: BoxDecoration(color: Colors.teal.shade100),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text('รายการอาหาร'),
          ),
          Expanded(
            flex: 1,
            child: Center(child: Text('ราคา')),
          ),
          Expanded(
            flex: 1,
            child: Center(child: Text('จำนวน')),
          ),
          Expanded(
            flex: 1,
            child: Center(child: Text('รวม')),
          ),
        ],
      ),
    );
  }

  Widget buildShowHead() => Column(
        children: [
          Container(
            //padding: EdgeInsets.only(left: 20.00, right: 15.00),
            child: Row(
              children: [
                Text('วันเวลาที่ออเดอร์ : ${orderListModel.datetime}'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5.00),
            child: Row(
              children: [
                Text('ชื่อผู้สั่ง : ${orderListModel.customerName}'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5.00),
            child: Row(
              children: [
                Text('เบอร์โทรศัพท์ : ${orderListModel.phoneCus}'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5.00),
            child: Row(
              children: [
                Text('ที่อยู่สำหรับจัดส่ง :'),
              ],
            ),
          ),
          Container(
              child: Column(
            children: [Text(orderListModel.addressCus)],
          ))
        ],
      );

  Widget buildShowBottom() => Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('รวมราคาอาหาร ${orderListModel.total} บาท'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5.00),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('ค่าจัดส่ง ${orderListModel.transport} บาท'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5.00),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('รวมค่าจัดส่ง ${orderListModel.totalprice} บาท'),
              ],
            ),
          ),
        ],
      );
}
