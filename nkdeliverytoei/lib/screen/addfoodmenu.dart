//import 'dart:html';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nkdeliverytoei/utility/my_constant.dart';
import 'package:nkdeliverytoei/utility/my_dialog.dart';
import 'package:nkdeliverytoei/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFoodMenu extends StatefulWidget {
  @override
  _AddFoodMenuState createState() => _AddFoodMenuState();
}

class _AddFoodMenuState extends State<AddFoodMenu> {
  //ตัวแปรเก็บภาพ
  File file;
  String nameFood, priceFood, detaiFood;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มเมนูอาหาร'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            nameForm(),
            showImageFood(),
            iconAddFood(),
            Mystyle().mySizebox(),
            priceForm(),
            Mystyle().mySizebox(),
            detaiForm(),
            Mystyle().mySizebox(),
            saveButton()
          ],
        ),
      ),
    );
  }

  Widget saveButton() {
    return Container(
      width: 250.00,
      // height: 250.00,
      child: RaisedButton.icon(
        color: Mystyle().darkColor2,
        onPressed: () {
          //เช็คว่ามีรูปภาพไหม
          if (file == null) {
            myDialog(context, 'กรุณาเลือกรูปภาพ');
          } else if (nameFood == null ||
              nameFood.isEmpty ||
              priceFood == null ||
              priceFood.isEmpty ||
              detaiFood == null ||
              detaiFood.isEmpty) {
            myDialog(context, 'กรุณากรอกทุกช่อง');
          }else{
            uploadFoodAndInserData();
          }
        },
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: Text(
          'บันทึกรายการอาหาร',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<Null>uploadFoodAndInserData() async {

    //อัพโหลดรูปภาพ
    String urlUpload = '${MyConstant().domain}/nkdeliverytoei/saveFoodImages.php';
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameFile = 'food$i.jpg';

    try {
      Map<String,dynamic> map = Map();
      map['file'] = await MultipartFile.fromFile(file.path , filename: nameFile);
      FormData formData = FormData.fromMap(map);

      await Dio().post(urlUpload, data: formData).then((value) async{
        String urlPathImage = '/nkdeliverytoei/ImageFood/$nameFile';
        print('urlPathImage = ${MyConstant().domain}$urlPathImage');

        SharedPreferences preferences = await SharedPreferences.getInstance();
        String storeID = preferences.getString('storeID');

        String urlInserData = '${MyConstant().domain}/nkdeliverytoei/addMenu.php?isAdd=true&storeID=$storeID&productname=$nameFood&price=$priceFood&detail=$detaiFood&photo=$urlPathImage';
        await Dio().get(urlInserData).then((value) => Navigator.pop(context),);


      },);

    } catch (e) {
    }

  }

  Widget nameForm() => Container(
        margin: EdgeInsets.all(16.00),
        width: 250.00,
        // height: 250.00,
        child: TextField(
          onChanged: (value) => nameFood = value.trim(),
          decoration: InputDecoration(
            labelText: 'ชื่ออาหาร',
            border: OutlineInputBorder(),
          ),
        ),
      );

  Widget priceForm() => Container(
        width: 250.00,
        // height: 250.00,
        child: TextField(keyboardType: TextInputType.number,
          onChanged: (value) => priceFood = value.trim(),
          decoration: InputDecoration(
            labelText: 'ราคาอาหาร',
            border: OutlineInputBorder(),
          ),
        ),
      );

  Widget detaiForm() => Container(
        width: 250.00,
        // height: 250.00,
        child: TextField(
          // keyboardType: TextInputType.number,
          onChanged: (value) => detaiFood = value.trim(),
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          decoration: InputDecoration(
            labelText: 'รายละเอียดอาหาร',
            border: OutlineInputBorder(),
          ),
        ),
      );

  Row iconAddFood() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.add_a_photo),
          onPressed: () => chooseImg(ImageSource.camera),
        ),
        IconButton(
          icon: Icon(Icons.add_photo_alternate),
          onPressed: () => chooseImg(ImageSource.gallery),
        ),
      ],
    );
  }

  Future<Null> chooseImg(ImageSource source) async {
    try {
      var object = await ImagePicker().getImage(
        source: source,
        maxWidth: 800.00,
        maxHeight: 800.00,
      );

      setState(() {
        file = File(object.path);
      });
    } catch (e) {}
  }

  Widget showImageFood() {
    return Container(
      margin: EdgeInsets.only(left: 16.00, right: 16.00 ,top: 16.00),
      //margin: EdgeInsets.all(16.00),
      //width: 300.00,
      height: 200.00,
      child:
          file == null ? Image.asset('images/iconimage.png') : Image.file(file, fit: BoxFit.cover,)
    );
  }
}
