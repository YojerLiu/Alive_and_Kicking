import 'package:alive_and_kicking/mock_data/recipe.dart';
import 'package:flutter/material.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetail({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  int _sliderVal = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.label),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // One new thing is the SizedBox around the Image, which defines resizable bounds
            // for the image. Here, the height is fixed at 300 but the width will adjust to fit the
            // aspect ratio. The unit of measurement in Flutter is logical pixels.
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image(image: AssetImage(widget.recipe.imageUrl),),
            ),
            const SizedBox(height: 4,),
            Text(
              widget.recipe.label,
              style: const TextStyle(fontSize: 18,),
            ),
            // An Expanded widget, which expands to fill the space in a Column. This way, the
            // ingredient list will take up the space not filled by the other widgets.
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(7),
                itemCount: widget.recipe.ingredient.length,
                itemBuilder: (context, index) {
                  final ingredient = widget.recipe.ingredient[index];
                  return Text(
                    '${ingredient.quantity * _sliderVal} ${ingredient.measure} ${ingredient.name}',
                  );
                },
              ),
            ),
            buildSlider(),
          ],
        ),
      ),
    );
  }

  Widget buildSlider() {
    return Slider(
      value: _sliderVal.toDouble(),
      max: 10,
      min: 1,
      divisions: 10,
      label: '${_sliderVal * widget.recipe.servings} servings',
      activeColor: Colors.green,
      inactiveColor: Colors.black,
      onChanged: (value) {
        setState(() {
          _sliderVal = value.round();
        });
      },
    );
  }
}
