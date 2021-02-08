import 'package:flutter/material.dart';
import 'package:inven/models/item.dart';
import 'package:inven/db/database_helper.dart';

class ItemView extends StatefulWidget {
  final String appBarTitle;
  final Item item;

  ItemView(this.item, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return ItemDetailState(this.item, this.appBarTitle);
  }
}

class ItemDetailState extends State<ItemView> {
  static var _category = [
    'Beverages',
    'Cosmetics',
    'Dairy',
    'Frozen Foods',
    'Meat'
  ];

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Item item;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController countController = TextEditingController();

  ItemDetailState(this.item, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = item.title;
    descriptionController.text = item.description;
    countController.text = item.quantity;

    return WillPopScope(
        onWillPop: () {
          moveToLastPage();
          return;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(appBarTitle),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  moveToLastPage();
                }),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                // First element
                ListTile(
                  title: DropdownButton(
                      items: _category.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      style: textStyle,
                      value: item.category,
                      onChanged: (valueSelectedByUser) {
                        setState(() {
                          item.category = valueSelectedByUser;
                        });
                      }),
                ),

                // Second Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: titleController,
                    style: textStyle,
                    onChanged: (value) {
                      updateTitle();
                    },
                    decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),

                // Third Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: descriptionController,
                    style: textStyle,
                    onChanged: (value) {
                      updateDescription();
                    },
                    decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: countController,
                    style: textStyle,
                    onChanged: (value) {
                      updateQuantity();
                    },
                    decoration: InputDecoration(
                        labelText: 'Quantity',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),

                // Fourth Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Colors.blue[400],
                          textColor: Colors.white,
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _save();
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Colors.redAccent,
                          textColor: Colors.white,
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _delete();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void moveToLastPage() {
    Navigator.pop(context, true);
  }

  void updateTitle() {
    item.title = titleController.text;
  }

  void updateDescription() {
    item.description = descriptionController.text;
  }

  void updateQuantity() {
    item.quantity = countController.text;
  }

  void _save() async {
    moveToLastPage();

    int result;
    if (item.id != null) {
      result = await helper.updateItem(item);
    } else {
      result = await helper.insertItem(item);
    }

    if (result != 0) {
      _showAlertDialog('Status', 'Item Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Saving the Item');
    }
  }

  void _delete() async {
    moveToLastPage();

    if (item.id == null) {
      _showAlertDialog('Status', 'No Item was deleted');
      return;
    }

    int result = await helper.deleteItem(item.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Item Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting the Item');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
