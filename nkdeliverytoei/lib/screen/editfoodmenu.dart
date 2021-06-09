//import 'dart:html';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nkdeliverytoei/model/food_model.dart';
import 'package:nkdeliverytoei/utility/my_constant.dart';
import 'package:nkdeliverytoei/utility/my_dialog.dart';
import 'package:nkdeliverytoei/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditFoodMenu extends StatefulWidget {
  final FoodModel foodModel; //รับค่ามาค่าไหนค่านั้น
  EditFoodMenu({Key key, this.foodModel}) : super(key: key);

  @override
  _EditFoodMenuState createState() => _EditFoodMenuState();
}

class _EditFoodMenuState extends State<EditFoodMenu> {
  FoodModel foodModel;
  File file;
  String namefood, pricefood, detailfood, imgfood,urlPathImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    foodModel = widget.foodModel;
    namefood = foodModel.productname;
    pricefood = foodModel.price;
    detailfood = foodModel.detail;
    imgfood = foodModel.photo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขเมนู ${foodModel.productname}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            nameFood(),
            groupImg(),
            priceFood(),
            detailFood(),
            editButton()
          ],
        ),
      ),
    );
  }

  Widget editButton() => Container(
        margin: EdgeInsets.only(top: 16.00, bottom: 16.00),
        width: 250.00,
        //color: Colors.blue,
        child: RaisedButton.icon(
          color: Mystyle().darkColor2,
          onPressed: () {
            if (namefood.isEmpty || pricefood.isEmpty || detailfood.isEmpty) {
              myDialog(context, 'กรุณากรอกทุกช่อง');
            } else {
              confirmEdit();
            }
          },
          icon: Icon(
            Icons.save,
            color: Colors.white,
          ),
          label: Text(
            'แก้ไขเมนูอาหาร',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<Null> confirmEdit() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('แก้ไขรายละเอียดหรือไม่ ?'),
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton(
                onPressed: () => Navigator.pop(context) ,
                child: Text('ไม่'),
              ),
              FlatButton(
                onPressed: () {
                   Navigator.pop(context);       
                  if (file == null) {
            myDialog(context, 'กรุณาใส่รูปภาพ');
          } else {
            uploadImage();
          }       
                },
                child: Text('ใช่'),
                
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<Null> uploadImage() async {

     //อัพโหลดรูปภาพ
    String urlUpload = '${MyConstant().domain}/nkdeliverytoei/saveFoodImages.php';
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameFile = 'editfood$i.jpg';

    try {
      Map<String,dynamic> map = Map();
      map['file'] = await MultipartFile.fromFile(file.path , filename: nameFile);
      FormData formData = FormData.fromMap(map);

      await Dio().post(urlUpload, data: formData).then((value) async{
         urlPathImage = '/nkdeliverytoei/ImageFood/$nameFile';
        //print('urlPathImage = ${MyConstant().domain}$urlPathImage');
        editValueOnMySQL();

        // SharedPreferences preferences = await SharedPreferences.getInstance();
        // String storeID = preferences.getString('storeID');

        // String id = foodModel.productID;

        // String urlInserData = '${MyConstant().domain}/nkdeliverytoei/editFoodWhereId.php?isAdd=true&productID=$id&productname=$namefood&detail=$detailfood&price=$pricefood&photo=$urlPathImage';
        // await Dio().get(urlInserData).then((value) => Navigator.pop(context),);


      },);

    } catch (e) {
    }


  }

  Future<Null> editValueOnMySQL() async {  
    String id = foodModel.productID;
    String url = '${MyConstant().domain}/nkdeliverytoei/editFoodWhereId.php?isAdd=true&productID=$id&productname=$namefood&detail=$detailfood&price=$pricefood&photo=$urlPathImage';
    await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context);
        
      } else {
        myDialog(context, 'กรุณาลองใหม่');
      }
    },);
  }

  Widget groupImg() => Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.00),
            width: 250.0,
            height: 250.0,
            child: file == null
                ? Image.network(
                    '${MyConstant().domain}${foodModel.photo}',
                    fit: BoxFit.cover,
                  )
                : Image.file(file),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.add_a_photo),
                onPressed: () => chooseImg(ImageSource.camera),
              ),
              Mystyle().mySizebox(),
              IconButton(
                icon: Icon(Icons.add_photo_alternate),
                onPressed: () => chooseImg(ImageSource.gallery),
              ),
            ],
          ),
        ],
      );

  Future<Null> chooseImg(ImageSource source) async {
    try {
      var object = await ImagePicker()
          .getImage(source: source, maxHeight: 800.00, maxWidth: 800.00);
      setState(
        () {
          file = File(object.path);
        },
      );
    } catch (e) {}
  }

  Widget nameFood() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.00),
            width: 250.00,
            child: TextFormField(
              onChanged: (value) => namefood = value.trim(),
              initialValue: namefood,
              decoration: InputDecoration(
                labelText: 'ชื่ออาหาร',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget priceFood() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.00),
            width: 250.00,
            child: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) => pricefood = value.trim(),
              initialValue: pricefood,
              decoration: InputDecoration(
                labelText: 'ราคา',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget detailFood() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.00),
            width: 250.00,
            child: TextFormField(maxLines: 5,
              keyboardType: TextInputType.multiline,
              onChanged: (value) => detailfood = value.trim(),
              initialValue: detailfood,
              decoration: InputDecoration(
                labelText: 'รายละเอียดอาหาร',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );
}
