import 'package:alive_and_kicking/models/post.dart';
import 'package:alive_and_kicking/my_widgets/friend_post_tile.dart';
import 'package:flutter/material.dart';

class FriendPostListView extends StatelessWidget {
  final List<Post> friendPosts;

  const FriendPostListView({Key? key, required this.friendPosts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 0,
        left: 16,
        right: 16
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Social Chefs 👩‍🍳',
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(height: 16,),
          ListView.separated(
            // Since you’re nesting two list views, it’s a good idea to set
            // primary to false. That lets Flutter know that this isn’t the
            // primary scroll view.
            primary: false,
            // Set the scrolling physics to NeverScrollableScrollPhysics. Even
            // though you set primary to false, it’s also a good idea to disable
            // the scrolling for this list view.That will propagate up to the
            // parent list view.
            physics: const NeverScrollableScrollPhysics(),
            // If the scroll view does not shrink wrap, then the scroll view
            // will expand to the maximum allowed size in the scrollDirection.
            // If the scroll view has unbounded constraints in the
            // scrollDirection, then shrinkWrap must be true.
            // If this were false, you’d get an unbounded height error, since
            // there is no height constraint for this scroll view
            shrinkWrap: true,
            itemCount: friendPosts.length,
            itemBuilder: (context, index) {
              final post = friendPosts[index];
              return FriendPostTile(post: post,);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16,);
            },
          ),
          const SizedBox(height: 16,),
        ],
      ),
    );
  }
}
