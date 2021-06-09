import 'dart:convert';
//import 'dart:html';
import 'dart:io';
import 'dart:math';
//import 'dart:js';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:nkdeliverytoei/model/user_model.dart';
import 'package:nkdeliverytoei/utility/my_constant.dart';
import 'package:nkdeliverytoei/utility/my_dialog.dart';
import 'package:nkdeliverytoei/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditInfoShop extends StatefulWidget {
  @override
  _EditInfoShopState createState() => _EditInfoShopState();
}

class _EditInfoShopState extends State<EditInfoShop> {
  UserModel userModel;
  String storename,
      commercialNumber,
      phoneStore,
      nameoperator,
      addressstore,
      timeopen,timeclose,dayopen,dayclose,
      pimg;
  Location location = Location();
  double lat, lng;
  File fileimg;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findLatLag();
    readCurrentInfo();

    // location.onLocationChanged.listen((event) {
    //   setState(() {
    //     lat = event.altitude;
    //     lng = event.longitude;
    //     print('lat = $lat, lng = $lng');
    //   });
    // });
  }

  Future<Null> findLatLag() async {
    LocationData locationData = await findLocationData();
    setState(() {
      lat = locationData.latitude;
      lng = locationData.longitude;
    });
    // print('lat = $lat, lng = $lng');
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  //อ่านIDร้าน
  Future<Null> readCurrentInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idShop = preferences.getString('storeID');
    //print('idShop ==>> $idShop');

    String url =
        '${MyConstant().domain}/nkdeliverytoei/getUserWhereid.php?isAdd=true&storeID=$idShop';

    Response response = await Dio().get(url);
    //print('response ==>> $response');

    //อ่านภาษาไทย
    var result = json.decode(response.data);
    //print('result ==>> $result');

    //เอาอาเรย์ออก
    for (var map in result) {
      print('map ==> $map');
      setState(
        () {
          userModel = UserModel.fromJson(map);
          storename = userModel.storeName;
          addressstore = userModel.addressStore;
          nameoperator = userModel.nameOperator;
          pimg = userModel.pImg;
          phoneStore = userModel.phoneStore;
          commercialNumber = userModel.commercialNumber;
          timeopen = userModel.timeopen;
          timeclose = userModel.timeclose;
          dayopen = userModel.dayopen;
          dayclose = userModel.dayclose;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userModel == null ? Mystyle().showeProgress() : showContent(),
      appBar: AppBar(
        title: Text('แก้ไขรายละเอียดร้าน'),
      ),
    );
  }

  Widget showContent() => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            showImageShop(),
            Mystyle().mySizebox(),

            showText(),
            showdayopenandclose(),
            Mystyle().mySizebox(),
            showText2(), 
            showtimeopenandclose(),
            Mystyle().mySizebox(),

            //showtimeopen(),
            showNameShop(),
            showCommercialNumber(),
            showName(),
            showPhon(),
            showAddress(),
            Mystyle().mySizebox(),
            lat == null ? Mystyle().showeProgress() : showMap(),
            editButton()
          ],
        ),
      );

  Widget editButton() {
    return Container(
      width: 250.0,
      child: RaisedButton.icon(
        color: Mystyle().boxColor,
        onPressed: () => confirmDialog(),
        icon: Icon(Icons.save, color: Mystyle().darkColor),
        label: Text(
          'แก้ไขรายละเอียดร้าน',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<Null> confirmDialog() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('แก้ไขรายละเอียดร้านหรือไม่ ?'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ไม่'),
              ),
              Mystyle().mySizebox(),
              FlatButton(
                //padding: EdgeInsets.only(left: 5.00),

                onPressed: () {
                  Navigator.pop(context);
                  
                  if (fileimg == null) {
            myDialog(context, 'กรุณาใส่รูปภาพ');
          } else {
            uploadImage();
          }
    
                 // uploadImage();
                },

                child: Text('ใช่'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future <Null>uploadImage() async {

     //แก้ไขรูปภาพ
    //ตั้งชื่อ
    Random random = Random();
    int i = random.nextInt(100000);
    String nameFileImg = 'editShop$i.jpg';

     //อัพขึ้น
    String urlUploadImg =
        '${MyConstant().domain}/nkdeliverytoei/saveFileImages.php';

    try {
      //เตรียมอัพขึ้น
    Map<String, dynamic> map = Map();
    map['file'] =
        await MultipartFile.fromFile(fileimg.path, filename: nameFileImg);
    FormData formData = FormData.fromMap(map);
    await Dio().post(urlUploadImg, data: formData).then(
      (value) async {
        pimg = '/nkdeliverytoei/ImageShop/$nameFileImg';

        editThread();
      });   
    } catch (e) {
    }

  }

  Future<Null> editThread() async {
   
        String id = userModel.storeID;
        print('idedit = $id');

        String urlEditShop =
            '${MyConstant().domain}/nkdeliverytoei/editUserDataWhereId.php?isAdd=true&storeID=$id&latitude=$lat&longitude=$lng&p_img=$pimg&store_name=$storename&commercial_number=$commercialNumber&name_operator=$nameoperator&phone_store=$phoneStore&address_store=$addressstore&address_store=$addressstore&dayopen=$dayopen&dayclose=$dayclose&timeopen=$timeopen&timeclose=$timeclose';
        Response response = await Dio().get(urlEditShop);

        if (response.toString() == 'true') {
          Navigator.pop(context);
        } else {
          myDialog(context, 'ไม่สามารถแก้ไขได้ กรุณาลองใหม่');
        }
      
    

    //   String id = userModel.storeID;
    //  String urlEditShop =
    //         '${MyConstant().domain}/nkdeliverytoei/editUserDataWhereId.php?isAdd=true&storeID=$id&latitude=$lat&longitude=$lng&p_img=$pimg&store_name=$storename&commercial_number=$commercialNumber&name_operator=$nameoperator&phone_store=$phoneStore&address_store=$addressstore&address_store=$addressstore';
    //     Response response =
    //     await Dio().get(urlEditShop);

    //     if (response.toString() == 'true') {
    //       Navigator.pop(context);
    //     } else {
    //       myDialog(context, 'ไม่สามารถแก้ไขได้ กรุณาลองใหม่');
    //     }
  }

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('myCustommer'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: 'ที่อยู่ของคุณ',
          snippet: 'ละติจูด = $lat,ลองติจูด = $lng',
        ),
      )
    ].toSet();
  }

  Container showMap() {
    
    LatLng latLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );

    return Container(

      padding: EdgeInsets.only(left: 20.00, right: 20.00, top: 16.00, bottom: 16.00),
      height: 300.0,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: myMarker(),
      ),
    );
  }

  Widget showImageShop() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(top: 16.00),
            // width: 150.00,
            // height: 250.00,
            child: Column(
              children: [
                Container(
                  width: 250,
                  height: 250,
                  child: fileimg == null
                      ? Image.network('${MyConstant().domain}$pimg')
                      : Image.file(fileimg),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add_a_photo),
                      onPressed: () => chooseImg(ImageSource.camera),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_photo_alternate),
                      onPressed: () => chooseImg(ImageSource.gallery),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      );

  //แก้ไขรูปภาพ
  Future<Null> chooseImg(ImageSource source) async {
    try {
      var object = await ImagePicker().getImage(
        source: source,
        maxWidth: 800.00,
        maxHeight: 800.00,
      );

      setState(() {
        fileimg = File(object.path);
      });
    } catch (e) {}
  }

  Widget showNameShop() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            width: 250.00,
            child: TextFormField(
              onChanged: (value) => storename = value,
              initialValue: storename,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'ชื่อร้าน'),
            ),
          ),
        ],
      );

  Widget showCommercialNumber() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.00,
            child: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) => commercialNumber = value,
              initialValue: commercialNumber,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'หมายเลขทะเบียนพานิชณ์'),
            ),
          ),
        ],
      );

  Widget showName() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.00,
            child: TextFormField(
              onChanged: (value) => nameoperator = value,
              initialValue: nameoperator,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'ชื่อ-นามสกุล'),
            ),
          ),
        ],
      );

  Widget showPhon() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.00,
            child: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) => phoneStore = value,
              initialValue: phoneStore,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'หมายเลขโทรศัพท์'),
            ),
          ),
        ],
      );

  Widget showAddress() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.00,
            child: TextFormField(
              onChanged: (value) => addressstore = value,
              initialValue: addressstore,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'ที่อยู่ร้าน'),
            ),
          ),
        ],
      );

  Widget showText() => Container(
        margin: EdgeInsets.only(left: 50.0),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('วันเปิดปิดร้าน เช่น "จันทร์ - ศุกร์"'),
          ],
        ),
      );

  Widget showdayopenandclose() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 120.00,
            child: TextFormField(
              onChanged: (value) => dayopen = value,
              initialValue: dayopen,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'วัน'),
            ),
          ),
          Text('  -  '),
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 120.00,
            child: TextFormField(
              onChanged: (value) => dayclose = value,
              initialValue: dayclose,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'วัน'),
            ),
          ),
        ],
      );

      Widget showText2() => Container(
        margin: EdgeInsets.only(left: 50.0),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('เวลาเปิดปิดร้าน เช่น "07.00 น. - 16.00 น."'),
          ],
        ),
      );

  Widget showtimeopenandclose() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 100.00,
            child: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) => timeopen = value,
              initialValue: timeopen,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'เวลา'),
            ),
          ),

          Text('  น.  -  '),

           Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 100.00,
            child: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) => timeclose = value,
              initialValue: timeclose,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'เวลา'),
            ),
          ),
           Text('  น.'),
        ],
      );

  // Widget showtimeopen() {
  //   return Container(
  //     child: CupertinoPicker(
  //       itemExtent: 50,
  //       onSelectedItemChanged: (int index) {
  //         print(index);
  //       },
  //       children: <Widget> [
  //         Text('item 1'),
  //         Text('item 2'),
  //         Text('item 3'),
  //         Text('item 4'),
  //         Text('item 5'),

  //       ],
  //     ),
  //   );
  // }

}
