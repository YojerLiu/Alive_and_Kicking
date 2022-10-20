import 'package:alive_and_kicking/models/app_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EmptyGroceryScreen extends StatelessWidget {
  const EmptyGroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Column(
          // Place the children at the center of the row (horizontally)
          crossAxisAlignment: CrossAxisAlignment.center,
          // Place the children at the center of the column (vertically)
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Flexible gives a child the ability to fill the available space
            // in the main axis.
            Flexible(
              // AspectRatio sizes its child to the specified aspectRatio.
              // Although aspectRatio is a double, the Flutter documentation
              // recommends writing it as width / height instead of the
              // calculated result. In this case, you want a square aspect
              // ratio of 1 / 1 and not 1.0.
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.asset('assets/fooderlich_assets/empty_list.png'),
              ),
            ),
            const Text(
              'No groceries',
              style: TextStyle(fontSize: 21.0),
            ),
            const SizedBox(height: 16,),
            const Text(
              'Shopping for ingredients?\n'
              'Tap the + button to write them down!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16,),
            MaterialButton(
              onPressed: () {
                Provider.of<AppStateManager>(context, listen: false)
                    .goToRecipes();
              },
              textColor: Colors.white,
              child: const Text('Browse Recipes'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
