import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io';
import 'dart:math';

class ImagePickere extends StatefulWidget {
  ImagePickerState createState() => ImagePickerState();
}

class ImagePickerState extends State<ImagePickere> {
  final mainReference = Firestore.instance.collection('images');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Bar Titie'),
      ),
      body: _loadItem(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => picker(),
        child: Icon(Icons.camera),
      ),
    );
  }

  Widget _loadItem() {
    return StreamBuilder(
      stream: mainReference.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
        if (!snap.hasData) return new Text('Loading.....');
        return ListView(
          children: snap.data.documents.map((doc) {
            var id = doc.documentID.toString();
            return Image.network(
              doc['avtarUrl'],
              fit: BoxFit.fill,
            );
          }).toList(),
        );
      },
    );
  }

  picker() async {
    debugPrint("hello this is new");
    File img = await ImagePicker.pickImage(source: ImageSource.camera);

    var no = new Random();
    int id;
    for (var i = 0; i < 10; i++) {
      id = no.nextInt(100);
    }
    StorageReference storageRef =
        FirebaseStorage.instance.ref().child("images/$id");

    StorageUploadTask file = storageRef.putFile(img);

    var ids = await (await file.onComplete).ref.getDownloadURL();

    debugPrint("this is path down $ids");

    debugPrint("image location is   :-   ${img.path}");

    mainReference.document().setData({'avtarUrl': ids});
  }
}
