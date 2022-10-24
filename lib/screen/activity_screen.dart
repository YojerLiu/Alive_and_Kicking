import 'package:alive_and_kicking/api/mock_service.dart';
import 'package:alive_and_kicking/my_widgets/post_widget.dart';
import 'package:flutter/material.dart';

import '../models/explore_data.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final mockService = MockService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cesare'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 16,
          bottom: 16,
        ),
        child: FutureBuilder(
          future: mockService.getExploreData(),
          builder: (context, AsyncSnapshot<ExploreData> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final data = snapshot.data!.friendPosts;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return PostWidget(
                    post: data[index],
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
