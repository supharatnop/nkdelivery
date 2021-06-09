import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nkdeliverytoei/model/orderlist_model.dart';
import 'package:nkdeliverytoei/screen/confirmOrder.dart';
import 'package:nkdeliverytoei/screen/showOrderConfirm.dart';
import 'package:nkdeliverytoei/screen/successOrder.dart';
import 'package:nkdeliverytoei/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderListShop extends StatefulWidget {
  @override
  _OrderListShopState createState() => _OrderListShopState();
}

class _OrderListShopState extends State<OrderListShop> {
  List<OrderListModel> orderListModel = List();
  List<OrderListModel> listModels = List();
  List<OrderListModel> listModelsSuccess = List();

  bool loadStatus = true; //ยังโหลดไม่เสร็จ
  bool status = true; //มีข้อมูล

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readID();
  }

  Future<Null> readID() async {
    if (orderListModel.length != 0) {
      orderListModel.clear();
    }

    if (listModels.length != 0) {
      listModels.clear();
    }

    if (listModelsSuccess.length != 0) {
      listModelsSuccess.clear();
    }

    //อ่านว่าเข้าสู่ระบบด้วยไอดีอะไร
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String storeID = preferences.getString('storeID');
    //print('storeID = $storeID');

  
  //สำเร็จ
  
    String url3 =
        '${MyConstant().domain}/nkdeliverytoei/getOrderWhereidStoreID.php?isAdd=true&storeID=$storeID&status=Finish';
    await Dio().get(url3).then((value) {
      setState(() {
        loadStatus = false;
      });

      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        for (var map in result) {
          OrderListModel listModel_Success = OrderListModel.fromJson(map);

          String staTUS = listModel_Success.status;

          if (staTUS == 'Finish') {
            print('Status ======> ${listModel_Success.status}');

            setState(() {
              listModelsSuccess.add(listModel_Success);
            });
          }
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });


//คำสั่งซื้อ
    String url2 =
        '${MyConstant().domain}/nkdeliverytoei/getOrderWhereidStoreID.php?isAdd=true&storeID=$storeID&status=RiderOrder';
    await Dio().get(url2).then((value) {
      setState(() {
        loadStatus = false;
      });

      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        for (var map in result) {
          OrderListModel listModel = OrderListModel.fromJson(map);

          String staTus = listModel.status;

          if (staTus == 'RiderOrder') {
            print('Status ======> ${listModel.status}');

            setState(() {
              listModels.add(listModel);
            });
          }
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });


//ยืนยันคำสั่งซื้อ
    String url1 =
        '${MyConstant().domain}/nkdeliverytoei/getOrderWhereidStoreID.php?isAdd=true&storeID=$storeID&status=UserOrder';
    await Dio().get(url1).then(
      (value) {
        setState(() {
          loadStatus = false;
        });

        if (value.toString() != 'null') {
          var result = json.decode(value.data);
          for (var map in result) {
            OrderListModel orderlistModel = OrderListModel.fromJson(map);

            String sTatus = orderlistModel.status;

            if (sTatus == 'UserOrder') {
              print('Status ======> ${orderlistModel.status}');

              setState(() {
                orderListModel.add(orderlistModel);
              });
            }
          }
        } else {
          setState(() {
            status = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.white,
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  TabBar(
                    labelColor: Colors.black,
                    tabs: [
                      Tab(
                        text: "ยืนยันคำสั่งซื้อ",
                      ),
                      Tab(
                        text: "คำสั่งซื้อ",
                      ),
                      Tab(
                        text: "สำเร็จ",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            showeDataOrder(),
            showeDataOrderShowOrder(),
            showeDataOrderSuccess(),
          ],
        ),
      ),
    );
  }

  Widget showeNoData1(BuildContext context) {
    return Text('ยังไม่คำสั่งซื้อ');
  }

 
 //โชว์ยืนยันคำสั่งซื้อ
  Widget showeDataOrder() {
    return RefreshIndicator(
      onRefresh: getRefresh,
      child: ListView.builder(
          padding: EdgeInsets.only(top: 10),
          itemCount: orderListModel.length,
          itemBuilder: (context, index) {
            return Card(
              color: index % 2 == 0 ? Colors.teal.shade50 : Colors.teal.shade200,
              child: Padding(
                padding: const EdgeInsets.all(0.10),
                child: ListTile(
                  title: Column(
                    children: [
                      Row(
                        children: [
                          Text(orderListModel[index].customerName),
                        ],
                      ),
                      Row(
                        children: [
                          Text(orderListModel[index].datetime),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ConFirmOrder(orderListModel: orderListModel[index]),
                      ),
                    ).then((value) => readID());
                  },
                ),
              ),
            );
          }),
    );
  }

Future<Null> getRefresh() async {
  await Future.delayed(Duration(seconds: 2));

  setState(() {
    status = true;
  });
  
}
  //โชว์คำสั่งซื้อ
  Widget showeDataOrderShowOrder() {
    return RefreshIndicator(
      onRefresh: getRefresh,
      child: ListView.builder(
          padding: EdgeInsets.only(top: 10),
          itemCount: listModels.length,
          itemBuilder: (context, index) {
            return Card(
              color: index % 2 == 0 ? Colors.blue.shade50 : Colors.blue.shade200,
              child: Padding(
                padding: const EdgeInsets.all(0.10),
                child: ListTile(
                  title: Column(
                    children: [
                      Row(
                        children: [
                          Text(listModels[index].customerName),
                        ],
                      ),
                      Row(
                        children: [
                          Text(listModels[index].datetime),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ShowOrderConfirm(listModels: listModels[index]),
                      ),
                    );//.then((value) => readID());
                  },
                ),
              ),
            );
          }),
    );
  }

  
  //โชว์สำเร้จ
  Widget showeDataOrderSuccess() {
    return RefreshIndicator(
      onRefresh: getRefresh,
      child: ListView.builder(
          padding: EdgeInsets.only(top: 10),
          itemCount: listModelsSuccess.length,
          itemBuilder: (context, index) {
            return Card(
              color:
                  index % 2 == 0 ? Colors.green.shade50 : Colors.green.shade200,
              child: Padding(
                padding: const EdgeInsets.all(0.10),
                child: ListTile(
                  title: Column(
                    children: [
                      Row(
                        children: [
                          Text(listModelsSuccess[index].customerName),
                        ],
                      ),
                      Row(
                        children: [
                          Text(listModelsSuccess[index].datetime),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessOrder(
                            listModelsSuccess: listModelsSuccess[index]),
                      ),
                    ).then((value) => readID());
                  },
                ),
              ),
            );
          }),
    );
  }
}
