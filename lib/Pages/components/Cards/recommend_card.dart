import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RecommendCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width * 0.60,
      margin: EdgeInsets.only(top: 10, bottom: 0),
      // color: Colors.white,
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            foregroundDecoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      'https://firebasestorage.googleapis.com/v0/b/otakudesu-4500b.appspot.com/o/hoshiumi.png?alt=media&token=83758e28-189f-4003-a825-a44f5f3ae9bb'),
                  fit: BoxFit.fill),
            ),
          ),
          Positioned(
              child: Container(
                  color: Colors.transparent,
                  child: Icon(Icons.play_circle_outline,
                      color: Colors.white, size: 65)))
        ],
      ),
    );
  }
}
