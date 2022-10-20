import 'package:alive_and_kicking/models/explore_recipe.dart';
import 'package:alive_and_kicking/theme/alive_and_kicking_theme.dart';
import 'package:flutter/material.dart';

class Card3 extends StatelessWidget {
  final ExploreRecipe recipe;
  const Card3({Key? key, required this.recipe}) : super(key: key);

  List<Widget> createTagChips() {
    final chips = <Widget>[];
    recipe.tags.take(6).forEach((element) {
      final chip = Chip(
        label: Text(
          element,
          style: AliveAndKickingTheme.darkTextTheme.bodyText1,
        ),
        backgroundColor: Colors.black.withOpacity(0.7),
      );
      chips.add(chip);
    });
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints.expand(
          width: 350,
          height: 450,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(recipe.backgroundImage),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Stack(
          children: <Widget>[
            // Add a container with a color overlay with a 60% semi-transparent
            // background to make the image appear darker.
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                // This gives the appearance of rounded image corners
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(
                    Icons.book,
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(height: 8,),
                  Text(
                    recipe.title,
                    style: AliveAndKickingTheme.darkTextTheme.headline2,
                  ),
                  const SizedBox(height: 30,),
                ],
              ),
            ),
            Center(
              // Wrap is a layout widget that attempts to lay out each of its
              // children adjacent to the previous children. If there’s not
              // enough space, it wraps to the next line.
              child: Wrap(
                // Place the children as close to the left, i.e. the start,
                // as possible.
                alignment: WrapAlignment.start,
                // Apply a 12-pixel space between each child.
                spacing: 12,
                children: createTagChips(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
