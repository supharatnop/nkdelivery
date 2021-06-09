import 'dart:convert';
//import 'dart:js';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nkdeliverytoei/model/user_model.dart';
import 'package:nkdeliverytoei/screen/addeditinformationshop.dart';
import 'package:nkdeliverytoei/screen/editinfoshop.dart';
import 'package:nkdeliverytoei/utility/my_constant.dart';
import 'package:nkdeliverytoei/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformationShop extends StatefulWidget {
  @override
  _InformationShopState createState() => _InformationShopState();
}

class _InformationShopState extends State<InformationShop> {
  UserModel userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readDataUser();
  }

  Future<Null> readDataUser() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String storeID = preferences.getString('storeID');

    String url =
        '${MyConstant().domain}/nkdeliverytoei/getUserWhereid.php?isAdd=true&storeID=$storeID';
    await Dio().get(url).then((value) {
      //print('value = $value');

      //อ่านภาษาไทย
      var result = json.decode(value.data);
      //print('result = $result');

      for (var map in result) {
        setState(() {
          userModel = UserModel.fromJson(map);
        });

        print('storeName = ${userModel.storeName}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget>[
            userModel == null
                ? Mystyle().showeProgress()
                : userModel.pImg.isEmpty
                    ? showeListNoInfoShop()
                    : showeListInfoShop(),
            addAndeditButton()
          ],
    );
  }

    Widget showeListInfoShop() => ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
      return Column(children: <Widget> [
        Mystyle().mySizebox(),
        Mystyle().showText2('ชื่อร้าน ${userModel.storeName}'),
        showImg(),

        Container( padding: EdgeInsets.only(left: 30.00, bottom: 5.00),
          child: Row( 
              children: [
                Mystyle().showText2('วันเปิดปิดร้าน'),
              ],
            ),
        ),
          Container(padding: EdgeInsets.only(left: 35.00, bottom: 5.00),
            child: Row(
              children: [
                Text('${userModel.dayopen} - ${userModel.dayclose}'),
              ],
            ),
          ),
          Container( padding: EdgeInsets.only(left: 30.00, bottom: 5.00),
          child: Row( 
              children: [
                Mystyle().showText2('เวลาเปิดปิดร้าน'),
              ],
            ),
        ),
          Container(padding: EdgeInsets.only(left: 35.00, bottom: 5.00),
            child: Row(
              children: [
                Text('${userModel.timeopen} - ${userModel.timeclose}'),
              ],
            ),
          ),

        Container( padding: EdgeInsets.only(left: 30.00, bottom: 5.00),
          child: Row( 
              children: [
                Mystyle().showText2('หมายเลขทะเบียนพาณิชย์'),
              ],
            ),
        ),
          Container(padding: EdgeInsets.only(left: 35.00, bottom: 5.00),
            child: Row(
              children: [
                Text(userModel.commercialNumber),
              ],
            ),
          ),
          Container(padding: EdgeInsets.only(left: 30.00, bottom: 5.00),
            child: Row(
              children: [
                Mystyle().showText2('ชื่อ-นามสกุล'),
              ],
            ),
          ),
          Container(padding: EdgeInsets.only(left: 35.00, bottom: 5.00),
            child: Row(
              children: [
                Text(userModel.nameOperator),
              ],
            ),
          ),
          Container(padding: EdgeInsets.only(left: 30.00, bottom: 5.00),
            child: Row(
              children: [
                Mystyle().showText2('หมายเลขโทรศัพท์'),
              ],
            ),
          ),
          Container(padding: EdgeInsets.only(left: 35.00, bottom: 5.00),
            child: Row(
              children: [
                Text(userModel.phoneStore),
              ],
            ),
          ),
          Container(padding: EdgeInsets.only(left: 30.00, bottom: 5.00),
              child: Row(
                children: [
                  Mystyle().showText2('ที่อยู่ร้าน'),
                ],
              ),
            ),
          
          Container(padding: EdgeInsets.only(left: 35.00, bottom: 5.00),
            child: Text(userModel.addressStore)),
          showMap(),

      ],);
    },);
      
      //หน้าที่ยังไม่มีรูปภาพและแผนที่
       Widget showeListNoInfoShop() => ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
      return Column(children: <Widget> [
        Mystyle().mySizebox(),
        Mystyle().showText2('ชื่อร้าน ${userModel.storeName}'),
        showNoImg(),
        Container( padding: EdgeInsets.only(left: 30.00, bottom: 5.00),
          child: Row( 
              children: [
                Mystyle().showText2('หมายเลขทะเบียนพานิชณ์'),
              ],
            ),
        ),
          Container(padding: EdgeInsets.only(left: 35.00, bottom: 5.00),
            child: Row(
              children: [
                Text(userModel.commercialNumber),
              ],
            ),
          ),
          Container(padding: EdgeInsets.only(left: 30.00, bottom: 5.00),
            child: Row(
              children: [
                Mystyle().showText2('ชื่อ-นามสกุล'),
              ],
            ),
          ),
          Container(padding: EdgeInsets.only(left: 35.00, bottom: 5.00),
            child: Row(
              children: [
                Text(userModel.nameOperator),
              ],
            ),
          ),
          Container(padding: EdgeInsets.only(left: 30.00, bottom: 5.00),
            child: Row(
              children: [
                Mystyle().showText2('หมายเลขโทรศัพท์'),
              ],
            ),
          ),
          Container(padding: EdgeInsets.only(left: 35.00, bottom: 5.00),
            child: Row(
              children: [
                Text(userModel.phoneStore),
              ],
            ),
          ),
          Container(padding: EdgeInsets.only(left: 30.00, bottom: 5.00),
              child: Row(
                children: [
                  Mystyle().showText2('ที่อยู่ร้าน'),
                ],
              ),
            ),
          
          Container(padding: EdgeInsets.only(left: 35.00, bottom: 5.00),
            child: Text(userModel.addressStore)),
          //showMap(),

      ],);
    },);

  Container showImg() => Container(margin: EdgeInsets.all(16.00),
        width: 150.00,
        height: 150.00,
        child: Image.network('${MyConstant().domain}${userModel.pImg}'),
      );
      
//หน้าที่ยังไม่มีรูปภาพ
  Container showNoImg() => Container(margin: EdgeInsets.all(16.00),
        width: 150.00,
        height: 150.00,
        child: Image.asset('images/iconimage.png')
      );

  Set<Marker> showMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId('shopID'),
          position: LatLng(
            double.parse(userModel.latitude),
            double.parse(userModel.longitude),
          ),
          infoWindow: InfoWindow(
              title: 'ตำแหน่งร้านของคุณ',
              snippet:
                  'ละติจูต = ${userModel.latitude},ลองติจูด = ${userModel.longitude}'))
    ].toSet();
  }

  Widget showMap() {
    double lat = double.parse(userModel.latitude);
    double lng = double.parse(userModel.longitude);

    LatLng latLng = LatLng(lat, lng);
    CameraPosition position = CameraPosition(target: latLng, zoom: 16.0);

    return Container(
        padding: EdgeInsets.only(left: 20.00, right: 20.00, top: 16.00, bottom: 16.00),
        height: 300.00,
        child: GoogleMap(
      initialCameraPosition: position,
      mapType: MapType.normal,
      onMapCreated: (controller) {},
      markers: showMarker(),
    ));
  }

  // Widget showeNoData(BuildContext context) {
  //   return Text('ยังไม่มีข้อมูล');
  // }

  Row addAndeditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: FloatingActionButton(
                  child: Icon(Icons.edit), onPressed: () => routeToAdd()),
            ),
          ],
        ),
      ],
    );
  }

  void routeToAdd() {
    Widget widget =
        userModel.storeName.isEmpty ? AddEditInformationShop() : EditInfoShop();
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
      builder: (context) => widget,
    );
    Navigator.push(context, materialPageRoute).then((value) => readDataUser());
  }
}
