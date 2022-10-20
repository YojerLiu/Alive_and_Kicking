import 'package:alive_and_kicking/models/simple_recipe.dart';
import 'package:alive_and_kicking/my_widgets/recipe_thumbnail.dart';
import 'package:flutter/material.dart';

class RecipesGridView extends StatelessWidget {
  final List<SimpleRecipe> recipes;
  const RecipesGridView({Key? key, required this.recipes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Apply a 16 point padding on the left, right, and top.
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
      ),
      child: GridView.builder(
        itemCount: recipes.length,
        // Add SliverGridDelegateWithFixedCrossAxisCount and set the
        // crossAxisCount to 2. That means that there will be only two columns.
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          final simpleRecipe = recipes[index];
          return RecipeThumbnail(recipe: simpleRecipe);
        },
      ),
    );
  }
}
