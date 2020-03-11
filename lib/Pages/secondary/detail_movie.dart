import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otakudesu_app/Pages/secondary/detail_movie_components/list_comment.dart';
import 'package:otakudesu_app/Pages/secondary/detail_movie_components/list_episode.dart';
import 'detail_movie_components/header.dart';
import 'detail_movie_components/sinopsis.dart';

class DetailMovie extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DetailMovieState();
  }
}

class _DetailMovieState extends State<DetailMovie> {
  int initIndex = 0;
  List<Widget> tabPages = [
    ListEpisode(),
    ListComment(),
  ];

  _DetailMovieState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void changeTab(int index) {
    setState(() {
      initIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFF0A0A19),
          backgroundColor: Color(0xFF0A0A19)),
      home: DetailMovieApp(
        initIndex: initIndex,
        tabPages: tabPages,
        changeTab: this.changeTab,
      ),
    );
  }
}

class DetailMovieApp extends StatelessWidget {
  const DetailMovieApp({
    Key key,
    @required this.initIndex,
    @required this.tabPages,
    @required this.changeTab,
  }) : super(key: key);

  final int initIndex;
  final List<Widget> tabPages;
  final Function changeTab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DetailMovieHeader(),
              DetailMovieSinopsis(),
              DefaultTabController(
                initialIndex: initIndex,
                length: 2,
                child: TabBar(
                  onTap: changeTab,
                  labelColor: Color(0xFF87F5F5),
                  unselectedLabelColor: Colors.white.withOpacity(0.9),
                  indicatorColor: Colors.black,
                  tabs: <Widget>[
                    Tab(
                      text: 'Episodes',
                    ),
                    Tab(
                      text: 'Comments',
                    ),
                  ],
                ),
              ),
              tabPages.elementAt(initIndex)
            ],
          ),
        ),
      ),
    );
  }
}
