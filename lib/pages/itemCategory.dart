import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inven/models/item.dart';
import 'package:inven/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class ItemCategory extends StatefulWidget {
  final String catName;

  ItemCategory(this.catName);

  @override
  State<StatefulWidget> createState() {
    return ItemCategoryState(this.catName);
  }
}

class ItemCategoryState extends State<ItemCategory> {
  String catName;

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Item> ItemList;
  int count = 0;

  ItemCategoryState(this.catName);

  @override
  Widget build(BuildContext context) {
    if (ItemList == null) {
      ItemList = List<Item>();
      updateListView(catName);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: getItemListView(),
    );
  }

  ListView getItemListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/universal.png'),
            ),
            title: Text(
              this.ItemList[position].title,
              style: titleStyle,
            ),
            subtitle: Text(this.ItemList[position].description),
            trailing: Text(
              (this.ItemList[position].quantity).toString(),
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView(String category) {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Item>> ItemListFuture =
          databaseHelper.getItemCatList(category);
      ItemListFuture.then((ItemList) {
        setState(() {
          this.ItemList = ItemList;
          this.count = ItemList.length;
        });
      });
    });
  }
}
