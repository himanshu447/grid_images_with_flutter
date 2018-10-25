import 'package:flutter/material.dart';
import 'package:grid_images_with_flutter/model/city.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyGrid extends StatelessWidget {
  final List<City> allCities;

  MyGrid({Key key, this.allCities}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('images').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {

        if (!snap.hasData) return new Text('Loading.....');

        return GridView.count(
          children: snap.data.documents.map((doc) {
            var id = doc.documentID.toString();
            debugPrint("id is as follow $id");
            String url = doc['avtarUrl'];
            Widget w = _getGridItemUI(context, 'abc', url);
            return w;
          }).toList(),
          crossAxisCount: 2,
          padding: EdgeInsets.all(16.0),
          childAspectRatio: 8.0 / 9.0,
        );
      },
    );
    /* return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16.0),
      childAspectRatio: 8.0 / 9.0,
      children: _getGridViewItems(context),
    );*/
  }

  _getGridViewItems(BuildContext context) {
    List<Widget> allwidgets = List<Widget>();

    StreamBuilder(
      stream: Firestore.instance.collection('images').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
        if (!snap.hasData) return new Text('Loading.....');
        snap.data.documents.map((doc) {
          String url = doc['avtarUrl'];
          var widget = _getGridItemUI(context, 'abc', url);
          allwidgets.add(widget);
          var id = doc.documentID.toString();
          debugPrint("doc id is $id");
        }).toList();
      },
    );

    return allwidgets;
  }

  _getGridItemUI(BuildContext context, String item, String url) {
    return new InkWell(
      splashColor: Colors.greenAccent,
      highlightColor: Colors.pinkAccent,
      //onTap: () => _showSnackBar(context, item),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: Center(
                    child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
              child: Column(
                children: <Widget>[
                  Image.network(
                    url,
                    fit: BoxFit.fill,
                    height: 50.0,
                    width: 50.0,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    //item.name,
                    item,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(item),
                  Text('Population: ${item}'),
                ],
              ),
            )))
          ],
        ),
        elevation: 2.0,
        margin: EdgeInsets.all(7.0),
      ),
    );
  }

  Widget _loadItem() {
    return StreamBuilder(
      stream: Firestore.instance.collection('images').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
        if (!snap.hasData) return new Text('Loading.....');
        snap.data.documents.map((doc) {
          var id = doc.documentID.toString();
          return Image.network(
            doc['avtarUrl'],
            fit: BoxFit.fill,
            height: 50.0,
            width: 50.0,
          );
        }).toList();
      },
    );
  }

  _showSnackBar(BuildContext context, City item) {
    final SnackBar objSnackbar = new SnackBar(
      content: new Text("${item.name} is a city in ${item.countery}"),
      backgroundColor: Colors.amber,
    );

    Scaffold.of(context).showSnackBar(objSnackbar);
  }
}
