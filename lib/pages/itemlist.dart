import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inven/models/item.dart';
import 'package:inven/db/database_helper.dart';
import 'package:inven/pages/itemview.dart';
import 'package:sqflite/sqflite.dart';

class ItemList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ItemListState();
  }
}

class ItemListState extends State<ItemList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Item> ItemList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (ItemList == null) {
      ItemList = List<Item>();
      updateListView();
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Items'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: getItemListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToView(Item('', 'Beverages', '', ''), 'Add Item');
        },
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
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
              backgroundColor: Colors.grey[800],
              child: Text(
                this.ItemList[position].quantity,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(
              this.ItemList[position].title,
              style: titleStyle,
            ),
            subtitle: Text(this.ItemList[position].description),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                _delete(context, ItemList[position]);
              },
            ),
            onTap: () {
              navigateToView(this.ItemList[position], 'Edit Item');
            },
          ),
        );
      },
    );
  }

  void _delete(BuildContext context, Item item) async {
    int result = await databaseHelper.deleteItem(item.id);
    if (result != 0) {
      _showSnackBar(context, 'Item Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToView(Item item, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ItemView(item, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Item>> ItemListFuture = databaseHelper.getItemList();
      ItemListFuture.then((ItemList) {
        setState(() {
          this.ItemList = ItemList;
          this.count = ItemList.length;
        });
      });
    });
  }
}
