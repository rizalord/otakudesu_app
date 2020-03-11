import 'package:flutter/material.dart';
import 'package:otakudesu_app/Pages/components/Cards/recommend_card.dart';
import 'package:otakudesu_app/Pages/components/home_header.dart';
import 'package:otakudesu_app/Pages/components/list_latest.dart';
import 'package:otakudesu_app/Pages/components/list_of_trending.dart';
import 'package:otakudesu_app/Pages/components/sub_header_text.dart';

class MainHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainHomeState();
  }
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              HomeHeader(),
              SubHeaderText(
                headerTitle: 'Trending',
                rightText: 'More',
              ),
              ListOfTrending(),
              SubHeaderText(
                headerTitle: 'Latest Update',
                leftTextSize: 15,
              ),
              ListLatest(),
              SubHeaderText(
                headerTitle: 'Recommended',
                leftTextSize: 15,
              ),
              RecommendCard()
            ],
          ),
        ),
      ),
    );
  }
}
