import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:otakudesu_app/Pages/secondary/detail_movie.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class RecommendCard extends StatelessWidget {
  final String image;
  final int id;

  RecommendCard({this.image, this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width * 0.60,
      margin: EdgeInsets.only(top: 10, bottom: 0),
      // color: Colors.white,
      child: TouchableOpacity(
        activeOpacity: 0.8,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailMovie(data: id),
          ),
        ),
        child: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              foregroundDecoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(image), fit: BoxFit.fill),
              ),
            ),
            Positioned(
                child: Container(
                    color: Colors.transparent,
                    child: Icon(Icons.play_circle_outline,
                        color: Colors.white, size: 65)))
          ],
        ),
      ),
    );
  }
}
