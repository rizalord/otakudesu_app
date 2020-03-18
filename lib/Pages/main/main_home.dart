import 'package:async/async.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:otakudesu_app/Pages/components/Cards/recommend_card.dart';
import 'package:otakudesu_app/Pages/components/home_header.dart';
import 'package:otakudesu_app/Pages/components/list_latest.dart';
import 'package:otakudesu_app/Pages/components/list_of_trending.dart';
import 'package:otakudesu_app/Pages/components/sub_header_text.dart';

class MainHome extends StatefulWidget {
  final Function onTabBar;

  MainHome({this.onTabBar});

  @override
  State<StatefulWidget> createState() {
    return _MainHomeState();
  }
}

class _MainHomeState extends State<MainHome> {
  final AsyncMemoizer _memo = AsyncMemoizer();
  DatabaseReference _firebaseDatabase = FirebaseDatabase.instance.reference();
  Future _trendsFuture;

  @override
  void initState() {
    super.initState();
    _trendsFuture = _getTrendsData();
  }

  Future _getTrendsData() async {
    return this._memo.runOnce(() async => await _firebaseDatabase
        .child('videos')
        .orderByChild('views')
        .limitToLast(6)
        .once());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              HomeHeader(onTabBar: widget.onTabBar),
              SubHeaderText(
                headerTitle: 'Trending',
                // rightText: 'More',
              ),
              FutureBuilder(
                future: _trendsFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListOfTrending(
                        data: snapshot.data.value.reversed
                            .where((i) => i != null)
                            .toList());
                  } else {
                    return Container();
                  }
                },
              ),
              SubHeaderText(
                headerTitle: 'Latest Update',
                leftTextSize: 15,
              ),
              FutureBuilder(
                future: FirebaseDatabase.instance
                    .reference()
                    .child('videos')
                    .orderByChild('updated_at')
                    .limitToLast(6)
                    .once(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<dynamic> data =
                        snapshot.data.value.map((e) => e).toList();
                    data.sort(
                        (a, b) => b['updated_at'].compareTo(a['updated_at']));
                    return ListLatest(data: data);
                  } else {
                    return Container();
                  }
                },
              ),
              SubHeaderText(
                headerTitle: 'Recommended',
                leftTextSize: 15,
              ),
              FutureBuilder(
                future: FirebaseDatabase.instance
                    .reference()
                    .child('recommend_video')
                    .once(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return RecommendCard(
                        id: snapshot.data.value['id'],
                        image: snapshot.data.value['url']);
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
