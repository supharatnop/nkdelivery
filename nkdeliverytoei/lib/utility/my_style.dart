import 'package:flutter/material.dart';

class Mystyle {

  Widget showeProgress(){
    return Center(child: CircularProgressIndicator(),);
  }

  Color darkColor = Colors.white;
  Color darkColor2 = Colors.blue;
  Color boxColor = Colors.blue;
  Color primaryColor = Colors.green.shade500;
  Color blackColor = Colors.black;

  SizedBox mySizebox() => SizedBox(width:10.0, height: 15.0,);

  Text showText(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );

  Container showLogo() {
    return Container(
      width: 120.0,
      child: Image.asset('images/logo1.png'),
    );
  }

 BoxDecoration myBoxDecoration(String namePic){
   return BoxDecoration(image: DecorationImage(image: AssetImage('images/$namePic'),fit:BoxFit.cover ));
 }

Text showText2(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          //fontWeight: FontWeight.bold,
        ),
      );
 

  TextStyle title1 = TextStyle(
    fontSize: 18.00,
    fontWeight: FontWeight.bold,
    color: Colors.black
  );

  TextStyle title2 = TextStyle(
    fontSize: 16.00,
    fontWeight: FontWeight.normal,
    color: Colors.black
  );

  TextStyle title3 = TextStyle(
    fontSize: 16.00,
    fontWeight: FontWeight.bold,
    color: Colors.black
  );

   Mystyle();
}
