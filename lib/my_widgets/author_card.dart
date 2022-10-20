import 'package:alive_and_kicking/my_widgets/my_circle_image.dart';
import 'package:alive_and_kicking/theme/alive_and_kicking_theme.dart';
import 'package:flutter/material.dart';

class AuthorCard extends StatefulWidget {
  final String authorName;
  final String title;
  final ImageProvider? imageProvider;

  const AuthorCard(
      {Key? key,
        required this.authorName,
        required this.title,
        this.imageProvider})
      : super(key: key);

  @override
  State<AuthorCard> createState() => _AuthorCardState();
}

class _AuthorCardState extends State<AuthorCard> {
  bool _isLiked = false;

  void onLiked() {
    if (!_isLiked) {
      const snackBar = SnackBar(
        content: Text('Favorite Pressed'),
        duration: Duration(seconds: 1),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(
        content: Text('Favorite cancelled'),
        duration: Duration(seconds: 1),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleImage(
                imageProvider: widget.imageProvider,
                imageRadius: 28,
              ),
              const SizedBox(width: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.authorName,
                    style: AliveAndKickingTheme.lightTextTheme.headline2,
                  ),
                  Text(
                    widget.title,
                    style: AliveAndKickingTheme.lightTextTheme.headline3,
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: onLiked,
            icon: _isLiked
                ? const Icon(Icons.favorite, color: Colors.red,)
                : Icon(Icons.favorite_border, color: Colors.grey[400],),
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}
