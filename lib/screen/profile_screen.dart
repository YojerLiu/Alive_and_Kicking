import 'package:alive_and_kicking/models/alive_and_kicking_pages.dart';
import 'package:alive_and_kicking/models/app_state_manager.dart';
import 'package:alive_and_kicking/models/profile_manager.dart';
import 'package:alive_and_kicking/my_widgets/my_circle_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/user.dart';

class ProfileScreen extends StatefulWidget {

  final User user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  static MaterialPage page(User user) {
    return MaterialPage(
      name: AliveAndKickingPages.profilePath,
      key: ValueKey(AliveAndKickingPages.profilePath),
      child: ProfileScreen(user: user),
    );
  }

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            // Close Profile Screen
            Provider.of<ProfileManager>(context, listen: false)
                .tapOnProfile(false);
          },
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 16,),
            buildProfile(),
            Expanded(child: buildMenu(),),
          ],
        ),
      ),
    );
  }

  Widget buildProfile() {
    return Column(
      children: <Widget>[
        CircleImage(
          imageRadius: 60,
          imageProvider: AssetImage(widget.user.profileImageUrl),
        ),
        const SizedBox(height: 16,),
        Text(
          widget.user.firstName,
          style: const TextStyle(fontSize: 21,),
        ),
        Text(widget.user.role),
        Text(
          '${widget.user.points} points',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget buildDarkModeRow() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text('Dark Mode'),
          Switch(
            activeColor: Colors.green,
            value: widget.user.darkMode,
            onChanged: (value) {
              Provider.of<ProfileManager>(context, listen: false).darkMode =
                  value;
            },
          ),
        ],
      ),
    );
  }

  Widget buildMenu() {
    return ListView(
      children: <Widget>[
        buildDarkModeRow(),
        ListTile(
          title: const Text('View slides of Alive & Kicking',),
          onTap: () async {
            if (kIsWeb) {
              await launchUrlString('https://docs.google.com/presentation/d/1qBWM4DabIK-qsj-SWmo4XJR9eyN563MKkInuXS5Z2wo/edit#slide=id.g16b42df49dd_1_163');
            } else {
              // Open WebView
              Provider.of<ProfileManager>(context, listen: false)
                  .tapOnAliveAndKicking(true);
            }
          },
        ),
        ListTile(
          title: const Text('Log out'),
          onTap: () {
            // Logout user
            // Make sure exit from ProfileScreen first
            Provider.of<ProfileManager>(context, listen: false)
                .tapOnProfile(false);
            Provider.of<AppStateManager>(context, listen: false).logout();
          },
        ),
      ],
    );
  }
}
