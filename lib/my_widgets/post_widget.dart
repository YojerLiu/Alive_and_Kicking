import 'package:alive_and_kicking/models/profile_manager.dart';
import 'package:alive_and_kicking/my_widgets/my_circle_image.dart';
import 'package:alive_and_kicking/theme/alive_and_kicking_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  final String? imagePath;
  const PostWidget({Key? key, required this.post, this.imagePath}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Provider.of<ProfileManager>(context, listen: false).darkMode
            ? Colors.black12
            : Colors.white,
        boxShadow: [
          BoxShadow(
            color: AliveAndKickingTheme.grey.withOpacity(0.2),
            offset: const Offset(1.1, 1.1),
            blurRadius: 10.0,
          ),
        ],
        //color: AliveAndKickingTheme.background,
      ),
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            child: Row(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(left: 5, top: 5,),
                  child: CircleImage(
                    imageRadius: 25,
                    imageProvider:
                        AssetImage('assets/profile_pics/person_cesare.jpeg'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 3,),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Cesare',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            color: Provider.of<ProfileManager>(context,
                                        listen: false)
                                    .darkMode
                                ? Colors.white30
                                : Colors.black.withOpacity(0.8),
                            size: 18,
                          ),
                          const SizedBox(width: 2,),
                          Text(
                            '${date.day}/${date.month}/${date.year}',
                            style: GoogleFonts.openSans(
                              letterSpacing: 1,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          /*const SizedBox(
            child: Divider(
              color: Colors.black12,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            height: 10,
          ),*/
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1,),
            child: Text(widget.post.comment),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Image.asset(widget.imagePath!),
          ),
          const SizedBox(height: 5,),
          /*const SizedBox(
            child: Divider(
              color: Colors.black12,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            height: 10,
          ),*/
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              getSpecialIcon(
                val: '0',
                color: Colors.grey,
                iconData: Icons.comment_outlined,
                doFunc: () {
                  // TODO: Add comment page
                },
              ),
              getSpecialIcon(
                val: '0',
                color: Colors.grey,
                iconData: Icons.repeat,
                doFunc: () {
                  // TODO
                },
              ),
              getSpecialIcon(
                val: isLiked ? '1' : '0',
                color: isLiked ? Colors.red : Colors.grey,
                iconData:
                    isLiked ? Icons.favorite : Icons.favorite_outline,
                doFunc: () {
                  setState(() {
                    isLiked = !isLiked;
                  });
                },
              ),
              getSpecialIcon(
                val: '0',
                color: Colors.grey,
                iconData: Icons.share,
                doFunc: () {
                  // TODO
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getSpecialIcon({
    required String val,
    required Color color,
    required IconData iconData,
    required void Function() doFunc,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 5),
      child: InkWell(
        onTap: doFunc,
        child: Row(
          children: <Widget>[
            Icon(
              iconData,
              color: color,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(val),
            ),
          ],
        ),
      ),
    );
  }
}
