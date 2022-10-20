import 'package:alive_and_kicking/api/mock_service.dart';
import 'package:alive_and_kicking/my_widgets/recipes_grid_view.dart';
import 'package:flutter/material.dart';

import '../models/simple_recipe.dart';

class RecipeScreen extends StatelessWidget {
  final exploreService = MockService();
  RecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: exploreService.getRecipes(),
      builder: (context, AsyncSnapshot<List<SimpleRecipe>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return RecipesGridView(recipes: snapshot.data ?? []);
        } else {
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}
