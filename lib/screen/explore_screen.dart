import 'package:alive_and_kicking/api/mock_service.dart';
import 'package:alive_and_kicking/my_widgets/friend_post_list_view.dart';
import 'package:alive_and_kicking/my_widgets/today_recipe_list_view.dart';
import 'package:flutter/material.dart';

import '../models/explore_data.dart';

class ExploreScreen extends StatefulWidget {

  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final mockService = MockService();
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_listener);
  }

  void _listener() {
    if (_scrollController!.offset >=
        _scrollController!.position.maxScrollExtent &&
        !_scrollController!.position.outOfRange) {
      print('Reach the bottom');
    } else if (_scrollController!.offset <=
        _scrollController!.position.minScrollExtent &&
        !_scrollController!.position.outOfRange) {
      print('Reach the top');
    }
  }

  @override
  void dispose() {
    _scrollController!.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // The FutureBuilder takes in a Future as a parameter. getExploreData()
      // creates a future that will, in turn, return an ExploreData instance.
      // That instance will contain two lists, todayRecipes and friendPosts.
      future: mockService.getExploreData(),
      // Within builder, you use snapshot to check the current state of the
      // Future.
      builder: (context, AsyncSnapshot<ExploreData> snapshot) {
        // Now, the Future is complete and you can extract the data to pass to
        // your widget.
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              TodayRecipeListView(
                recipes: snapshot.data?.todayRecipes ?? [],
              ),
              const SizedBox(height: 16,),
              FriendPostListView(
                friendPosts: snapshot.data?.friendPosts ?? [],
              ),
            ],
          );
        } else {
          // The future is still loading, so you show a spinner to let the user
          // know something is happening.
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
