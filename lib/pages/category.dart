import 'package:flutter/material.dart';
import 'package:inven/models/ctg.dart';
import 'package:inven/pages/itemCategory.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<Categories> ctg = [
    Categories(
        Name: 'Beverages',
        desitems: 'Water, Milk, Soft drinks, Juice, Spirits',
        asset: 'beverage.jpg'),
    Categories(
        Name: 'Cosmetics',
        desitems: 'Creams, Lotions, Powders, Gels',
        asset: 'cosmetics.jpg'),
    Categories(
        Name: 'Dairy',
        desitems: 'Yogurt, Cottage Cheese, Sour Cream, Dips',
        asset: 'diary.jpg'),
    Categories(
        Name: 'Frozen Foods',
        desitems: 'Ice Cream, Fish fillets, Chips',
        asset: 'frozen.jpg'),
    Categories(
        Name: 'Meat',
        desitems: 'Beef, Pork, Goat, Lamb, Chicken',
        asset: 'meat.jpg')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('Categories'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          elevation: 0,
        ),
        body: ListView.builder(
          itemCount: ctg.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 3.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    navigateToList(ctg[index].Name);
                  },
                  title: Text(ctg[index].Name),
                  subtitle: Text(ctg[index].desitems),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/${ctg[index].asset}'),
                  ),
                ),
              ),
            );
          },
        ));
  }

  void navigateToList(String category) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ItemCategory(category);
    }));
  }
}
