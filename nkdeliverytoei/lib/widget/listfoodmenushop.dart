import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nkdeliverytoei/model/food_model.dart';
import 'package:nkdeliverytoei/screen/addfoodmenu.dart';
import 'package:nkdeliverytoei/screen/editfoodmenu.dart';
import 'package:nkdeliverytoei/utility/my_constant.dart';
import 'package:nkdeliverytoei/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListFoodNenuShop extends StatefulWidget {
  @override
  _ListFoodNenuShopState createState() => _ListFoodNenuShopState();
}

class _ListFoodNenuShopState extends State<ListFoodNenuShop> {
  bool loadStatus = true; //ยังโหลดไม่เสร็จ
  bool status = true; //มีข้อมูล
  List<FoodModel> foodModels = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //อ่าน Food จาก IDstore
    readFoodMenu();
  }

  Future<Null> readFoodMenu() async {
    if (foodModels.length != 0) {
      foodModels.clear();
    }

    //อ่านว่าเข้าสู่ระบบด้วยไอดีอะไร
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String storeID = preferences.getString('storeID');
    print('storeID = $storeID');

    String url =
        '${MyConstant().domain}/nkdeliverytoei/getFoodWhereidShop.php?isAdd=true&storeID=$storeID';
    await Dio().get(url).then(
      (value) {
        setState(() {
          loadStatus = false;
        });

        //เงื่อนไขหน้าเพิ่มเมนู
        if (value.toString() != 'null') {
          // print('value ==> $value');

          var result = json.decode(value.data);
          // print('result ==> $result');

          for (var map in result) {
            FoodModel foodModel = FoodModel.fromJson(map);
            setState(() {
              foodModels.add(foodModel);
            });
          }
        } else {
          setState(
            () {
              status = false;
            },
          );
        }
      },
    );
  }

  // Stack การซ้อนทับของหน้า
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        loadStatus ? Mystyle().showeProgress() : showContent(),
        addMenuButton(),
      ],
    );
  }

  Widget showContent() {
    return status
        ? showListFood()
        : Center(
            child: Text('ยังไม่มีรายการอาหาร'),
          );
  }

  Widget showListFood() => ListView.builder(
        itemCount: foodModels.length,
        itemBuilder: (context, index) => Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10.0, left: 10.00, top: 10.00),
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
              child: Image.network(
                '${MyConstant().domain}${foodModels[index].photo}',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 10.0, left: 10.00, top: 10.00),
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.4,
              child: SingleChildScrollView(
                              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      foodModels[index].productname,
                      style: Mystyle().title1,
                    ),
                    Text(
                      'ราคา ${foodModels[index].price} บาท',
                      style: Mystyle().title2,
                    ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       'รายละเอียดอาหาร ${foodModels[index].detail} ',
                    //       style: Mystyle().title2,
                    //     ),
                    //   ],
                    // ),
                     Column(
                      children: [
                        Text(
                          'รายละเอียดอาหาร',
                          style: Mystyle().title3,
                        ),
                        Text(
                          foodModels[index].detail ,
                          style: Mystyle().title2,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            MaterialPageRoute route = MaterialPageRoute(
                              builder: (context) => EditFoodMenu(foodModel: foodModels[index],),
                            );
                            Navigator.push(context, route).then(
                              (value) => readFoodMenu(),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () => deleteMenu(foodModels[index]),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Future<Null> deleteMenu(FoodModel foodModel) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title:
            Mystyle().showText2('คุณต้องการลบเมนู ${foodModel.productname} ?'),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ยังไม่ยืนยัน'),
              ),
              FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  String url =
                      '${MyConstant().domain}/nkdeliverytoei/deleteMenu.php?isAdd=true&productID=${foodModel.productID}';
                  await Dio().get(url).then(
                        (value) => readFoodMenu(),
                      );
                },
                child: Text('ยืนยัน'),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget addMenuButton() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 16.0, right: 16.0),
                child: FloatingActionButton(
                  onPressed: () {
                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => AddFoodMenu(),
                    );
                    Navigator.push(context, route)
                        .then((value) => readFoodMenu());
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ],
      );
}
