import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatefulWidget {
  final Function onTabBar;
  HomeHeader({this.onTabBar});

  @override
  State<StatefulWidget> createState() {
    return _HomeHeaderState();
  }
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15, top: 15),
            child: CachedNetworkImage(
              imageUrl:
                'https://otakudesu.org/wp-content/uploads/2019/08/otakudesu.png',
              width: 150,
              height: 60,
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 15, top: 15),
            child: IconButton(
              icon: Icon(Icons.search),
              color: Colors.white,
              onPressed: () {
                widget.onTabBar(1);
              },
            ),
          ),
        ],
      ),
    );
  }
}
