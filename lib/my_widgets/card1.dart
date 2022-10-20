import 'package:alive_and_kicking/models/explore_recipe.dart';
import 'package:alive_and_kicking/theme/alive_and_kicking_theme.dart';
import 'package:flutter/material.dart';

/// `Card1` is composed of the following widgets:
///
/// **Container**: Groups all the other widgets together. It applies **Padding**
/// and uses a **BoxDecoration** to describe how to apply shadows and rounded
/// corners.
///
/// **Stack**: Layers widgets on top of each other.
///
/// **Text**: Displays the recipe content, like title, subtitle and author.
///
/// **Image**: Shows the recipe's art.
class Card1 extends StatelessWidget {
  final ExploreRecipe recipe;

  const Card1({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // Apply a padding of 16 on all sides of the box.
        padding: const EdgeInsets.all(16),
        // Constrain the container’s size to a width of 350 and a height of 450.
        constraints: const BoxConstraints.expand(
          width: 350,
          height: 450,
        ),
        // Apply BoxDecoration. This describes how to draw a box.
        decoration: BoxDecoration(
          // set up DecorationImage, which tells the box to paint an
          // image.
          image: DecorationImage(
            image: AssetImage(recipe.backgroundImage),
            // Cover the entire box with that image.
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Stack(
          children: <Widget>[
            Text(
              recipe.subtitle,
              style: AliveAndKickingTheme.darkTextTheme.bodyText1,
            ),
            Positioned(
              child: Text(
                recipe.title,
                style: AliveAndKickingTheme.darkTextTheme.headline2,
              ),
              top: 20,
            ),
            Positioned(
              child: Text(
                recipe.message,
                style: AliveAndKickingTheme.darkTextTheme.bodyText1,
              ),
              bottom: 30,
              right: 0,
            ),
            Positioned(
              child: Text(
                recipe.authorName,
                style: AliveAndKickingTheme.darkTextTheme.bodyText1,
              ),
              bottom: 10,
              right: 0,
            ),
          ],
        ),
      ),
    );
  }
}
