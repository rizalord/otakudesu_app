import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TrendCard extends StatelessWidget {
  final String url;
  final double ratio;
  final double radius;
  TrendCard({this.url, this.ratio = 60.0, this.radius = 20});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.width * 0.35) + ratio,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(this.radius),
          topRight: Radius.circular(this.radius),
          bottomLeft: Radius.circular(this.radius),
          bottomRight: Radius.circular(this.radius),
        ),
        boxShadow: [
          BoxShadow(
              offset: Offset(0.0, 3),
              color: Color.fromRGBO(255, 255, 255, 0.5),
              blurRadius: 5,
              spreadRadius: 0),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
            // color: Colors.orange,
            image: DecorationImage(
              image: CachedNetworkImageProvider(url),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
