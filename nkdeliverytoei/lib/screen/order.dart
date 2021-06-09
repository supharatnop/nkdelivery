//import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nkdeliverytoei/model/user_model.dart';
import 'package:nkdeliverytoei/screen/login.dart';

import 'package:nkdeliverytoei/utility/my_constant.dart';
//import 'package:nkdeliverytoei/screen/manageshop.dart';
//import 'package:nkdeliverytoei/screen/menu.dart';
import 'package:nkdeliverytoei/utility/my_style.dart';
import 'package:nkdeliverytoei/widget/informationshop.dart';
import 'package:nkdeliverytoei/widget/listfoodmenushop.dart';
import 'package:nkdeliverytoei/widget/orderShop.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  Widget currentWidget = OrderListShop();

  //จดจำชื่อผู้ใช้
  String nameStore, idshop, username;
  UserModel userModel;
  String imgshop;

  @override
  void initState() {
    super.initState();
    findUser();
  }

//เทรดจดจำชื่อผู้ใช้
  Future<Null> findUser() async {
    
    //หา FirebaseMessaging
    FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    String token = await firebaseMessaging.getToken();
    print('token =====> $token');

    SharedPreferences preferences = await SharedPreferences.getInstance();

    //หา id login
    String idLogin = preferences.getString('storeID');
    print('idLogin ==> $idLogin');

    if (idLogin != null && idLogin.isNotEmpty) {
      String url =
          '${MyConstant().domain}/nkdeliverytoei/editTokenWhereId.php?isAdd=true&storeID=$idLogin&token=$token';
      await Dio()
          .get(url)
          .then((value) => print('====>Update Token Success<===='));
    }

    setState(
      () {
        nameStore = preferences.getString('store_name');
        username = preferences.getString('name_operator');
        //imgshop = preferences.getString('p_img');
        print('nameStore  == $nameStore');
        print('username  == $username');
        //print('idshop  == $imgshop');
      },
    );
  }

  // สวิตส์เปิดปิดร้าน
  bool switchPrint = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameStore == null ? 'คำสั่งซื้อ' : '$nameStore '),
      ),
      drawer: showDrawer(),
      body: currentWidget, //หน้าที่ login เข้ามาเจอเป็นหน้าแรก
      //สร้างเมธอท showDrawer
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(children: <Widget>[

          showHeadDrawer(),
          SwitchListTile(
            title: Text('ปิด/เปิดร้าน'),
            value: switchPrint,
            onChanged: (bool value) async {
              setState(() {
                switchPrint = value;
              });

              if (switchPrint == true) {
                SharedPreferences preferences = await SharedPreferences.getInstance();
                String id = preferences.getString('storeID');
                String url = '${MyConstant().domain}/nkdeliverytoei/editStatusOpenAndCloseWhereId.php?isAdd=true&storeID=$id&status=open';
                print('เปิด ปิด =====$url');
                await Dio().get(url).then((value) {
                  if (value.toString() == 'true') {
                    //print('object123456'); 
                  } 
                });
                  
              } else if (switchPrint == false) {
                SharedPreferences preferences = await SharedPreferences.getInstance();
                String id1 = preferences.getString('storeID');
                String url1 = '${MyConstant().domain}/nkdeliverytoei/editStatusOpenAndCloseWhereId.php?isAdd=true&storeID=$id1&status=close';
                print('เปิด ปิด =====$url1');
                await Dio().get(url1).then((value) {
                  if (value.toString() == 'true') {
                   // print('55555');       
                  } 
                });
              } 
            },
            secondary: const Icon(Icons.power_settings_new_outlined),
          ),

          orderMenu(), //สร้างเมทอธ orderMenu
          menuMenu(), //สร้างเมทอธ menuMenu
          manageshopMenu(), //สร้างเมทอธ manageshopMenu
          //loginMenu(),
          logoutMenu(),
         

        ]),
      );

  ListTile orderMenu() {
    return ListTile(
      leading: Icon(Icons.assignment_rounded),
      title: Text('คำสั่งซื้อ'),
      onTap: () {
        setState(() {
          currentWidget = OrderListShop();
        });
        Navigator.pop(context);
        // MaterialPageRoute route = MaterialPageRoute(builder: (value) => Order());
        // Navigator.push(context, route);
      },
    );
    // onTap: เป็นตัว route หน้าหรือเชื่อมโยงหน้า
  }

  ListTile menuMenu() {
    return ListTile(
      leading: Icon(Icons.menu),
      title: Text('เมนูอาหาร'),
      onTap: () {
        setState(() {
          currentWidget = ListFoodNenuShop();
        });
        Navigator.pop(context);
        // MaterialPageRoute route = MaterialPageRoute(builder: (value) => Menu());
        // Navigator.push(context, route);
      },
    );
  }

  ListTile manageshopMenu() {
    return ListTile(
      leading: Icon(Icons.edit),
      title: Text('จัดการร้านค้า'),
      onTap: () {
        setState(() {
          currentWidget = InformationShop();
        });
        Navigator.pop(context);
        // MaterialPageRoute route = MaterialPageRoute(builder: (value) => Manageshop());
        // Navigator.push(context, route);
      },
    );
  }

  // ListTile loginMenu() {
  //   return ListTile(
  //     leading: Icon(Icons.login),
  //     title: Text('เข้าสู่ระบบ'),
  //     onTap: () {
  //       Navigator.pop(context);
  //       MaterialPageRoute route =
  //           MaterialPageRoute(builder: (value) => Login());
  //       Navigator.push(context, route);
  //     },
  //   );
  // }

  // //log out
  Future<Null> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    //exit(0);

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => Login(),
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  ListTile logoutMenu() {
    return ListTile(
      leading: Icon(Icons.logout),
      title: Text('ออกจากระบบ'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Login());
        Navigator.push(context, route);
        logout();
      },
    );
  }

  UserAccountsDrawerHeader showHeadDrawer() {
    return UserAccountsDrawerHeader(
        decoration: Mystyle().myBoxDecoration('welcome.png'),

        //currentAccountPicture: Mystyle().showLogo(),//showLogo
        accountName: Text(
          '$username',
          style: TextStyle(color: Mystyle().darkColor),
        )
        // accountEmail: Text('Please Lotgin', style: TextStyle(color: Mystyle().darkColor),)
        );
  }

  

}
