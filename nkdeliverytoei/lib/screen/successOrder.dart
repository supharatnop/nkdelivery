import 'package:flutter/material.dart';
import 'package:nkdeliverytoei/model/orderlist_model.dart';
import 'package:nkdeliverytoei/utility/my_style.dart';

class SuccessOrder extends StatefulWidget {

final OrderListModel listModelsSuccess;
  SuccessOrder({Key key, this.listModelsSuccess}) : super(key: key);

  @override
  _SuccessOrderState createState() => _SuccessOrderState();
}

class _SuccessOrderState extends State<SuccessOrder> {

List<OrderListModel> orderListmodel;
  OrderListModel orderListModel;
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
      totalPrice;

  List<List<String>> listMenuFood = List();
  List<List<String>> listPriceFood = List();
  List<List<String>> listTotalFood = List();
  List<List<String>> listSumFood = List(); //อาเรย์ซ้อนอาเรย์

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //findidStore();

    orderListModel = widget.listModelsSuccess;
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
        title: Text('คำสั่งซื้อสำเร็จ'),
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
            
          ],
        ),
      ),
      
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

  //      Row buildButton() {
  //   return Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             Container(width: 160,
  //               child: RaisedButton.icon( 
  //                 color: Colors.green,
  //                 onPressed: () {},
  //                 icon: Icon(Icons.sentiment_satisfied_outlined ,color: Colors.white,),
  //                 label: Text('เสร็จสิ้น', style: TextStyle(color: Colors.white) ,),
  //               ),
  //             ),
  //           ],
  //         );
  // }
}