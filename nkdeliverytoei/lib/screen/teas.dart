// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:nkdeliveryman/dwidget/update_order_rider.dart';
// import 'package:nkdeliveryman/model/orderlist_model.dart';
// import 'package:nkdeliveryman/utility/my_style.dart';
// import 'package:nkdeliveryman/utility/myconstant.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class OrederListRider extends StatefulWidget {
//   @override
//   _OrederListRiderState createState() => _OrederListRiderState();
// }

// class _OrederListRiderState extends State<OrederListRider> {
//   String deliveryID;
//   bool statusOreder = true;
//   List<OrderlistModel> orderlistModel = List();
//   List<List<String>> listMenuOrder = List();
//   List<List<String>> listPrices = List();
//   List<List<String>> listAmunts = List();
//   List<List<String>> listSums = List();
//   List<int> totalIns = List();

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     findDelivery();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return statusOreder ? buildNonOrder() : buildContent();
//   }

//   Widget buildContent() => ListView.builder(
//         padding: EdgeInsets.all(16),
//         itemCount: orderlistModel.length,
//         itemBuilder: (context, index) => Column(
//           children: [
//             buildBatetime(index),
//             buildNameOrder(index),
//             buildAddressStore(index),
//             buildOrderID(index),
//             buildAddressCus(index),
//             buildPhoneCus(index),
//             buildHead(),
//             builListViewMenuOrder(index),
//             buildTotal(index),
//             buildTransport(index),
//             buildTotalprice(index),
//             MyStyle().mySizedbox(),
//             MyStyle().mySizedbox(),
//           ],
//         ),
//       );

//   ListView builListViewMenuOrder(int index) => ListView.builder(
//         shrinkWrap: true,
//         physics: ScrollPhysics(),
//         itemCount: listMenuOrder[index].length,
//         itemBuilder: (context, index2) => Row(
//           children: [
//             Expanded(
//               flex: 3,
//               child: Text(listMenuOrder[index][index2]),
//             ),
//             Expanded(
//               flex: 1,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(listPrices[index][index2]),
//                 ],
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(listAmunts[index][index2]),
//                 ],
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(listSums[index][index2]),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );

//   Container buildHead() {
//     return Container(
//       padding: EdgeInsets.only(left: 8),
//       decoration: BoxDecoration(color: Colors.green),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 3,
//             child: MyStyle().showTitleH3white('รายการสินค้า'),
//           ),
//           Expanded(
//             flex: 1,
//             child: MyStyle().showTitleH3white('ราคา'),
//           ),
//           Expanded(
//             flex: 1,
//             child: MyStyle().showTitleH3white('จำนวน'),
//           ),
//           Expanded(
//             flex: 1,
//             child: MyStyle().showTitleH3white('ผลรวม'),
//           ),
//         ],
//       ),
//     );
//   }

//   Row buildOrderID(int index) {
//     return Row(
//       children: [
//         MyStyle().showTitleH3('บิลที่ ${orderlistModel[index].orderlistID}'),
//       ],
//     );
//   }

//   Widget buildAddressCus(int index) => Container(
//           child: Column(
//         children: [
//           MyStyle()
//               .showTitleH4('ที่อยู่ลูกค้า ${orderlistModel[index].addressCus}'),
//         ],
//       ));

//   Row buildPhoneCus(int index) {
//     return Row(
//       children: [
//         MyStyle().showTitleH4('เบอร์โทร ${orderlistModel[index].phoneCus}'),
//       ],
//     );
//   }

//   Row buildBatetime(int index) {
//     return Row(
//       children: [
//         MyStyle().showTitleH4('วันเวลา ${orderlistModel[index].datetime}'),
//       ],
//     );
//   }

//  Widget buildTotal(int index) => Row(
//         children: [
//           Expanded(
//             flex: 4,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 MyStyle().showTitleH4('รวมราคาสินค้า '),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 MyStyle().showTitleH4(' ${orderlistModel[index].total} '),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                  MyStyle().showTitleH4('บาท'),
//               ],
//             ),
//           ),
//         ],
//       );


//  Widget buildTransport(int index) => Row(
//         children: [
//           Expanded(
//             flex: 4,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 MyStyle().showTitleH4('ค่าจัดส่ง '),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 MyStyle().showTitleH4(' ${orderlistModel[index].transport} '),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                  MyStyle().showTitleH4('บาท'),
//               ],
//             ),
//           ),
//         ],
//       );


// Widget buildTotalprice(int index) => Row(
//         children: [
//           Expanded(
//             flex: 4,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 MyStyle().showTitleH4('รวมทั้งหมด '),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 MyStyle().showTitleH4(' ${orderlistModel[index].totalprice} '),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                  MyStyle().showTitleH4('บาท'),
//               ],
//             ),
//           ),
//         ],
//       );


//   Widget buildAddressStore(int index) => Container(
//           child: Column(
//         children: [
//           MyStyle().showTitleH4(
//               'ที่อยู่ร้าน ${orderlistModel[index].addressStore} '),
//         ],
//       ));

//   Row buildNameOrder(int index) {
//     return Row(
//       children: [
//         MyStyle().showTitleH2_1('ร้าน ${orderlistModel[index].storeName}'),
//       ],
//     );
//   }

//   Center buildNonOrder() {
//     return Center(
//       child: Text(
//         'ยังไม่มีข้อมูลออเดอร์',
//       ),
//     );
//   }

//   Future<Null> findDelivery() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     deliveryID = preferences.getString('deliveryID');
//     print('deliveryID = $deliveryID');
//     readOrederFromDeliveryID();
//   }

//   Future<Null> readOrederFromDeliveryID() async {
//     if (deliveryID != null) {
//       String url =
//           '${MyConstant().domain}/nkdeliveryman/getOrderlistWhereDeliveryID.php?isAdd=true&deliveryID=$deliveryID';

//       Response response = await Dio().get(url);
//       print('response = $response');

//       if (response.toString() != 'null') {
//         var result = json.decode(response.data);
//         for (var map in result) {
//           OrderlistModel model = OrderlistModel.fromJson(map);
//           List<String> menuOrder = changeArrey(model.productname);
//           List<String> menuPrices = changeArrey(model.price);
//           List<String> menuAmunts = changeArrey(model.amount);
//           List<String> menuSums = changeArrey(model.sum);
//           // print('menuOrder ==>> $menuOrder');
//           setState(() {
//             statusOreder = false;
//             orderlistModel.add(model);
//             listMenuOrder.add(menuOrder);
//             listPrices.add(menuPrices);
//             listAmunts.add(menuAmunts);
//             listSums.add(menuSums);
//           });
//         }
//       }
//     }
//   }

//   List<String> changeArrey(String string) {
//     List<String> list = List();
//     String myString = string.substring(1, string.length - 1);
//     print('myString =$myString');
//     list = myString.split(',');
//     int index = 0;
//     for (var string in list) {
//       list[index] = string.trim();
//       index++;
//     }
//     return list;
//   }
// }
