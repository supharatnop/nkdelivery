import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nkdeliverytoei/model/user_model.dart';
import 'package:nkdeliverytoei/screen/order.dart';
import 'package:nkdeliverytoei/utility/my_constant.dart';
import 'package:nkdeliverytoei/utility/my_dialog.dart';
import 'package:nkdeliverytoei/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  void initState() {
    super.initState();
    chackPerferance();
  }

  Future<Null> chackPerferance() async {
    try {

      // //หา FirebaseMessaging
      // FirebaseMessaging firebaseMessaging = FirebaseMessaging();
      // String token = await firebaseMessaging.getToken();
      // print('token =====> $token');

      SharedPreferences preferences = await SharedPreferences.getInstance();
      String userName = preferences.getString('username');

      // //หา id login
      // String idLogin = preferences.getString('storeID');
      // print('idLogin ==> $idLogin');

      // if (idLogin != null && idLogin.isNotEmpty) {
      //   String url = '${MyConstant().domain}/nkdeliverytoei/editTokenWhereId.php?isAdd=true&storeID=$idLogin&token=$token';
      //   await Dio().get(url).then((value) => print('====>Update Token Success<===='));
        
      // }


      if (userName != null && userName.isNotEmpty ) {
        if (userName == 'usernrame') {
          MaterialPageRoute route = MaterialPageRoute(builder: (context) => Order(),);
          Navigator.pushAndRemoveUntil(context, route, (route) => false);
        }else{
          myDialog(context, 'Error User Type');
        }
        
      }
    } catch (e) {
    }
  }


  String username,password;
  //เกทเอาค่ามาตรวจสอบช่องว่าง

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
        //title: Text('เข้าสู่ระบบ'),
      //),
      body: Container(
        decoration: new BoxDecoration(color: Color(0xFF00838F)),
        //decoration: BoxDecoration(gradient:RadialGradient(colors:<Color> [Colors.white,Mystyle().primaryColor],radius: 1.0 ,center: Alignment(0, -0.3))),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              //จัดหน้าให้เป็นเซ็นเตอร์ และกำหนดแกน เป็น min ถ้า max มันจะไม่กลาง
              children: <Widget>[
                Mystyle().showLogo(), Mystyle().mySizebox(),
                Mystyle().showText('หนองคาย เดลิเวอรี่'), Mystyle().mySizebox(),
                Mystyle().showText('NongKhai Delivery'), Mystyle().mySizebox(),
                Mystyle().mySizebox(),
                Mystyle().mySizebox(),
                // Text(
                //   'Login',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 18.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ), Mystyle().mySizebox(),
                //ใช้ class ที่อยู่ใน style
                userForm(),
                Mystyle().mySizebox(),
                passwordForm(), Mystyle().mySizebox(),
                loginButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() => Container(
        //color: Mystyle().darkColor,
        width: 250.0,
        child: RaisedButton(
          onPressed: () {
            print('username = $username, password = $password');

            if (username == null || username.isEmpty || password == null || password.isEmpty) {
              print('Have Space');
              myDialog(context, 'กรุณากรอกให้ครบ');
            } else {
              loginThread();
            }
            //ตรวจสอบช่องว่างจากการเกทค่าเวลากดปุ่มlogin
          },
          child: Text(
            'เข้าสู่ระบบ',
            style: TextStyle(color: Colors.white),
          ),
          color: Mystyle().boxColor,
          padding: EdgeInsets.all(12.0),
        ),
      );

      //เทรด รอดูผลลัพธ์
      Future<Null> loginThread()async{
        String url='${MyConstant().domain}/nkdeliverytoei/getUserWhereUserStore.php?isAdd=true&username=$username';

        try { 
          Response response = await Dio().get(url);
          print('res=$response');

          //ถอดรหัสภาษาไทย
          var result = json.decode(response.data);
          print('result = $result');
          
          //ลูปส่งค่าเมทของ user ให้กับ model
          for (var map in result) {
            UserModel userModel = UserModel.fromJson(map);
            if (password == userModel.password) {
              //กรณีมีผู้ใช้หลายประเภท
              // String username = userModel.username;
              // if (username == 'username') {
              //   routeTuService(Order());
              // }else{
              //   myDialog(context, 'กรุณาลองใหม่');
              // }
              routeToService(Order(),userModel);
              
            } else {
              myDialog(context, 'กรุณากรอกใหม่');
            }
          }
          
        } catch (e) {
        }
      }

      Future<Null> routeToService(Widget myWidget,UserModel userModel) async {

        //จดจำชื่อผู้ใช้
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('storeID', userModel.storeID);
        preferences.setString('username', userModel.username);
        preferences.setString('store_name', userModel.storeName);
        preferences.setString('p_img', userModel.pImg);
        preferences.setString('name_operator', userModel.nameOperator);

        MaterialPageRoute route = MaterialPageRoute(builder: (context) => myWidget,);
        Navigator.pushAndRemoveUntil(context, route, (route) => false);

      }

  Widget userForm() => Container(
      width: 250.0,
      child: TextField(
        onChanged: (value) => username = value.trim(),
        //เชคค่าช่องว่างในเทคบล็อก
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box, color: Mystyle().darkColor),
            labelStyle: TextStyle(color: Mystyle().darkColor),
            labelText: 'Username :',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Mystyle().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Mystyle().primaryColor))),
      ));

  Widget passwordForm() => Container(
      width: 250.0,
      child: TextField(
      onChanged: (value) => password = value.trim(),
      obscureText: true, //จุดตรงรหัสผ่าน
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock, color: Mystyle().darkColor),
            labelStyle: TextStyle(color: Mystyle().darkColor),
            labelText: 'password :',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Mystyle().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Mystyle().primaryColor))),
      ));
}
