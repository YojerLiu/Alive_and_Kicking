import 'package:alive_and_kicking/models/grocery_manager.dart';
import 'package:alive_and_kicking/my_widgets/grocery_tile.dart';
import 'package:alive_and_kicking/screen/grocery_item_screen.dart';
import 'package:flutter/material.dart';

class GroceryListScreen extends StatelessWidget {
  final GroceryManager groceryManager;

  const GroceryListScreen({Key? key, required this.groceryManager})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groceryItems = groceryManager.groceryItems;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        itemCount: groceryItems.length,
        itemBuilder: (context, index) {
          final item = groceryItems[index];
          return Dismissible(
            // The dismissible widget includes a Key. Flutter needs this to find
            // and remove the right element in the tree.
            key: Key(item.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 50,
              ),
            ),
            onDismissed: (direction) {
              groceryManager.deleteItem(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${item.name} dismissed')),
              );
            },
            child: InkWell(
              child: GroceryTile(
                key: Key(item.id),
                item: item,
                onComplete: (change) {
                  // Check if there is a change and update the item’s isComplete
                  // status.
                  if (change != null) {
                    groceryManager.completeItem(index, change);
                  }
                },
              ),
              onTap: () => groceryManager.groceryItemTapped(index),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16,),
      ),
    );
  }
}
