class Item {
  int _id;
  String _title;
  String _description;
  String _category;
  String _quantity;

  Item(this._title, this._category, this._quantity, [this._description]);

  Item.withId(this._id, this._title, this._category, this._quantity,
      [this._description]);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  String get category => _category;

  String get quantity => _quantity;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set quantity(String newQuantity) {
    _quantity = newQuantity;
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set category(String newCategory) {
    _category = newCategory;
  } // Convert a Item object into a Map object

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['category'] = _category;
    map['quantity'] = _quantity;

    return map;
  }

  // Extract a Item object from a Map object
  Item.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._category = map['category'];
    this._quantity = map['quantity'];
  }
}
