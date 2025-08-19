import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GroceryListState();
  }
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = groceryItems.toList();

  void _onAddItem() async {
    final newItem = await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (ctx) => const NewItem()));

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your grocery'),
        actions: [
          IconButton(
            onPressed: _onAddItem,
            icon: Icon(Icons.add_circle_outline),
          ),
        ],
      ),

      body: ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) {
          final currentItem = _groceryItems[index];

          return Dismissible(
            key: Key(currentItem.id),
            onDismissed: (direction) {
              setState(() {
                _groceryItems.remove(currentItem);
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${currentItem.name} dismissed')),
              );
            },
            background: Container(color: Colors.red, child: Text('Removing...'),),
            child: ListTile(
              title: Text(currentItem.name),
              leading: Container(
                width: 24,
                height: 24,
                color: currentItem.category.color,
              ),
              trailing: Text(currentItem.quantity.toString()),
            ),
          );
        },
      ),
    );
  }
}
