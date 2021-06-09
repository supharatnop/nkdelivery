import 'package:flutter/material.dart';
//import 'package:nkdeliverytoei/screen/home.dart';
import 'package:nkdeliverytoei/screen/login.dart';
import 'package:nkdeliverytoei/screen/order.dart';

void main() { 
  runApp(MyApp()); 
  } 

// main() => runApp(MyApp()); แบบย่อมีค่าเท่ากันกับข้างบน
  


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.teal),
      title: 'nkdelivery',
      home: Login(),
    );
  }
}
//เมื่อโปรเจคทำงาน ตัวเมธอทจะทำการคอล ออฟเจคจากคลาส MyApp MyApp จะไปดึงวิจจเจคที่มาจากหน้า Home มาทำการแสดง