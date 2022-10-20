import 'package:alive_and_kicking/models/grocery_manager.dart';
import 'package:alive_and_kicking/screen/empty_grocery_screen.dart';
import 'package:alive_and_kicking/screen/grocery_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final groceryManager = Provider.of<GroceryManager>(
            context,
            listen: false,
          );
          groceryManager.createNewItem();
        },
      ),
      body: buildGroceryScreen(),
    );
  }

  Widget buildGroceryScreen() {
    // Consumer rebuilds the widgets below itself when the grocery manager items
    // changes.(including GroceryListScreen)
    // You should only wrap a Consumer around widgets that need it. For
    // example, wrapping a consumer widget at the top level would force it to
    // rebuild the entire tree!
    return Consumer<GroceryManager>(
      builder: (context, groceryManager, child) {
        if (groceryManager.groceryItems.isNotEmpty) {
          return GroceryListScreen(groceryManager: groceryManager);
        } else {
          return const EmptyGroceryScreen();
        }
      },
    );
  }
}
