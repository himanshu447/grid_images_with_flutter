import 'package:flutter/material.dart';
import 'package:grid_images_with_flutter/model/city.dart';
import 'package:grid_images_with_flutter/widget/mygridview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  final List<City> _allCity = City.allCities();

  HomePage() {}

  final GlobalKey scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            'This is AppBar Title',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent),
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () => picker(),
          child: Icon(Icons.camera),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
          child: getHomePAgeBody(context),
        ));
  }

  picker() async {
    File uri = await ImagePicker.pickImage(source: ImageSource.camera);

    var no = Random();
    var id = no.nextInt(100);

    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("images/$id");

    StorageUploadTask storageUploadTask = storageReference.putFile(uri);

    var downloadUrl =
        await (await storageUploadTask.onComplete).ref.getDownloadURL();

    Firestore.instance
        .collection('images')
        .document()
        .setData({'avtarUrl': downloadUrl});
  }

  getHomePAgeBody(BuildContext context) {
    /*if (MediaQuery
        .of(context)
        .orientation == Orientation.portrait)
      return ListView.builder(
        itemCount: _allCity.length,
        itemBuilder: __getListItemUI,
        padding: EdgeInsets.all(0.0),
      );
    else*/
    return new MyGrid(allCities: _allCity);
  }

  Widget __getListItemUI(BuildContext context, int index,
      {double imgwidth: 50.0}) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: new Image.asset(
              "assets/" + _allCity[index].image,
              fit: BoxFit.fill,
              height: imgwidth,
              width: imgwidth,
            ),
            title: new Text(
              _allCity[index].name,
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
            subtitle: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(_allCity[index].countery,
                    style: new TextStyle(
                        fontSize: 13.0, fontWeight: FontWeight.normal)),
                new Text(_allCity[index].population,
                    style: new TextStyle(
                        fontSize: 13.0, fontWeight: FontWeight.normal)),
              ],
            ),
            onTap: () => _showSnackBar(context, _allCity[index]),
          )
        ],
      ),
    );
  }

  _showSnackBar(BuildContext context, City item) {
    final SnackBar obj = SnackBar(
      content: new Text("${item.name} is city in ${item.countery}"),
      backgroundColor: Colors.amber,
    );

    Scaffold.of(context).showSnackBar(obj);
  }
}
