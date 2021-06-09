import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:nkdeliverytoei/utility/my_constant.dart';
import 'package:nkdeliverytoei/utility/my_dialog.dart';
import 'package:nkdeliverytoei/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddEditInformationShop extends StatefulWidget {
  @override
  _AddEditInformationShopState createState() => _AddEditInformationShopState();
}

class _AddEditInformationShopState extends State<AddEditInformationShop> {
  //ประกาศตัวแปลรับค่าลัดลอง
  double lat, lng;
  File fileimage;
  String urlImage;

  @override
  void initState() {
    super.initState();
    findLatLng();
  }

  Future<Null> findLatLng() async {
    LocationData locationData = await findLocationData();
    setState(() {
      lat = locationData.latitude;
      lng = locationData.longitude;
    });
    print('lat =$lat, lng = $lng');
  }

  //เทรดรีเทินค่ากลับเป็นโลเคชั่น
  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มข้อมูล'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Mystyle().mySizebox(),
            groupImage(),
            Mystyle().mySizebox(),
            Mystyle().mySizebox(),
            lat == null ? Mystyle().showeProgress() : showMap(),
            Mystyle().mySizebox(),
            Mystyle().mySizebox(),
            saveButton()
          ],
        ),
      ),
    );
  }

  Widget saveButton() {
    return Container(
      width: 250.0,
      //MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        color: Mystyle().boxColor,
        onPressed: () {
          if (fileimage == null) {
            myDialog(context, 'กรุณาใส่รูปภาพ');
          } else {
            uploadImage();
          }
        },
        icon: Icon(
          Icons.save,
          color: Mystyle().darkColor,
        ),
        label: Text(
          'Save Imfomation',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<Null> uploadImage() async {
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameImage = 'shop$i.jpg';

    String url = '${MyConstant().domain}/nkdeliverytoei/saveFileImages.php';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(fileimage.path, filename: nameImage);

      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) {
        print('Response ==>> $value');

        urlImage = '/nkdeliverytoei/ImageShop/$nameImage';
        print('urlImage = $urlImage');
        editUserShop();
      });
    } catch (e) {}
  }

  Future<Null> editUserShop() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String storeID = preferences.getString('storeID');
    String url =
        '${MyConstant().domain}/nkdeliverytoei/editUserDataWhereId.php?isAdd=true&storeID=$storeID&latitude=$lat&longitude=$lng&p_img=$urlImage';

    await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context);
      } else {
        myDialog(context, 'กรุณาลองใหม่ ไม่สามารถบันทึกได้');
      }
    });
  }

  //สร้างมาร์คเกอร์
  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('myMarkerShop'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
            title: 'ตำแหน่งร้านของคุณ',
            snippet: 'ลัดติจูต =$lat,ลองติจูต = $lng'),
      )
    ].toSet();
  }

  Container showMap() {
    //LatLng(latitude,longitude)
    LatLng latLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );

    return Container(
      height: 300.0,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: myMarker(),
      ),
    );
  }

  Row groupImage() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add_a_photo,
              size: 36.0,
            ),
            onPressed: () => chooseImage(ImageSource.camera),
          ),
          Container(
            height: 250.0,
            child: fileimage == null
                ? Image.asset('images/iconimage.png')
                : Image.file(fileimage),
          ),
          IconButton(
            icon: Icon(
              Icons.add_photo_alternate,
              size: 36.0,
            ),
            onPressed: () => chooseImage(ImageSource.gallery),
          )
        ],
      );

  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker().getImage(
        source: imageSource,
        maxWidth: 800.00,
        maxHeight: 800.0,
      );
      setState(() {
        fileimage = File(object.path);
      });
    } catch (e) {}
  }
}
