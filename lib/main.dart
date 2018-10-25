import 'package:flutter/material.dart';
import 'package:grid_images_with_flutter/pages/homepage.dart';
import 'package:grid_images_with_flutter/cemera/imagePicker.dart';
void main()
{
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "this is title",
      theme: ThemeData(
        primarySwatch: Colors.amber
      ),
      home: new HomePage(),
    );
  }


}