import 'package:alive_and_kicking/models/post.dart';
import 'package:alive_and_kicking/my_widgets/my_circle_image.dart';
import 'package:alive_and_kicking/screen/activity_screen.dart';
import 'package:flutter/material.dart';

class FriendPostTile extends StatelessWidget {
  final Post post;
  const FriendPostTile({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          child: CircleImage(
            imageRadius: 20,
            imageProvider: AssetImage(post.profileImageUrl),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ActivityScreen(),
              ),
            );
          },
        ),
        const SizedBox(width: 16,),
        // Create Expanded, which makes the children fill the rest of the container.
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(post.comment),
              Text(
                '${post.timestamp} mins ago',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
