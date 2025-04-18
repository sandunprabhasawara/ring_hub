import 'package:flutter/material.dart';
import 'package:musicapp/models/audio_model.dart';
import 'package:musicapp/screens/audio_screen.dart';

class ListTileWidget extends StatefulWidget {
  const ListTileWidget({
    required this.title,
    required this.author,
    required this.files,
    required this.objectId,
    required this.id,
    super.key,
  });
  final String title;
  final String author;
  final List<Audio> files;
  final String objectId;
  final int id;

  @override
  State<ListTileWidget> createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          _createRoute(AudioScreen(
            playlist: widget.files,
            id: widget.id,
            objectId: widget.objectId,
          )),
        );
      },
      child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          elevation: 4,
          child: ListTile(
            minTileHeight: 50,
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                          0.25), // Black shadow with slight opacity
                      spreadRadius: 2, // Spread of the shadow
                      blurRadius: 4, // Blur effect for a softer shadow
                      offset:
                          const Offset(2, 2), // Horizontal and vertical offset
                    ),
                  ],
                  borderRadius: BorderRadius.circular(5)),
              child: ShaderMask(
                  shaderCallback: (rect) =>
                      const LinearGradient(colors: [Colors.pink, Colors.blue])
                          .createShader(rect),
                  child: Icon(Icons.music_note_outlined)),
            ),
            title: Text(
              widget.title,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              widget.author,
              style: const TextStyle(
                color: Colors.white60,
              ),
            ),
            trailing: const Icon(
              Icons.more_vert,
              color: Colors.white60,
            ),
          )),
    );
  }
}

Route _createRoute(Widget child) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
