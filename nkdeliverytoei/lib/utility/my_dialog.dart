import 'package:flutter/material.dart';

//เชคช่องว่าง

Future<void> myDialog(BuildContext context, String message)async{
  showDialog(context: context, 
             builder: (context) => SimpleDialog(
               title: Text(message),children:<Widget> [
                 Row( mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     FlatButton(onPressed: () => 
                     Navigator.pop(context),
                     child: Text('OK',
                     style: TextStyle(color: Colors.red),)),
                   ],
                 )
                 ],
             ),
  );
}