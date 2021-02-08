import 'package:flutter/material.dart';
import 'package:inven/pages/category.dart';
import 'package:inven/pages/itemlist.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      appBar: AppBar(
        title: Text('Grossery Store'),
        elevation: 20,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                child: FlatButton(
                  onPressed: () {
                    navigateToCategory();
                  },
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                            width: 150.0,
                            height: 190.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image:
                                        AssetImage('assets/category1.png')))),
                      ),
                      Expanded(
                          flex: 11,
                          child: Container(
                            alignment: Alignment.center,
                            child: ButtonTheme(
                                minWidth: 200.0,
                                height: 100.0,
                                child: Text(
                                  'Catogories',
                                  style: TextStyle(
                                    fontSize: 35.0,
                                    letterSpacing: 2.0,
                                  ),
                                )),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                child: FlatButton(
                  onPressed: () {
                    navigateToItemList();
                  },
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                            width: 150.0,
                            height: 190.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage('assets/category.png')))),
                      ),
                      Expanded(
                          flex: 11,
                          child: Container(
                            alignment: Alignment.center,
                            child: ButtonTheme(
                                minWidth: 200.0,
                                height: 100.0,
                                child: Text(
                                  'Manage',
                                  style: TextStyle(
                                    fontSize: 35.0,
                                    letterSpacing: 2.0,
                                  ),
                                )),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToCategory() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Category();
    }));
  }

  void navigateToItemList() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ItemList();
    }));
  }
}
