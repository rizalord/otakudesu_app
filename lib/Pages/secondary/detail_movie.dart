import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otakudesu_app/Pages/secondary/detail_movie_components/list_comment.dart';
import 'package:otakudesu_app/Pages/secondary/detail_movie_components/list_episode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detail_movie_components/header.dart';
import 'detail_movie_components/sinopsis.dart';

class DetailMovie extends StatefulWidget {
  final int data;
  DetailMovie({this.data});

  @override
  State<StatefulWidget> createState() {
    return _DetailMovieState();
  }
}

class _DetailMovieState extends State<DetailMovie> {
  int initIndex = 0;
  int id;
  DatabaseReference _db = FirebaseDatabase.instance.reference();
  bool favorited;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    //
    id = widget.data;
    super.initState();
  }

  Future getInfoMovie(int id) async {
    SharedPreferences localDb = await SharedPreferences.getInstance();
    List<String> data = localDb.getStringList('favoritesId');
    setState(() {
      favorited = data.indexOf(id.toString()) < 0 ? false : true;
    });
    return _db.child('videos').orderByChild('id').equalTo(id).once();
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

  sendComment(String text) async {
    SharedPreferences localDb = await SharedPreferences.getInstance();
    String newKey =
        _db.child('videos').child(id.toString()).child('comments').push().key;
    await _db
        .child('videos')
        .child(id.toString())
        .child('comments')
        .child(newKey)
        .set({
      'commentId': newKey,
      'text': text,
      'name': localDb.getString('name'),
      'uid': localDb.getString('userId'),
      'created_at': DateTime.now().millisecondsSinceEpoch,
      'likes': 0,
      'image': localDb.getString('photo')
    });

    await _db
        .child('users')
        .child(localDb.getString('userId'))
        .child('comments')
        .push()
        .set({
      'commentId': newKey,
      'text': text,
      'name': localDb.getString('name'),
      'uid': localDb.getString('userId'),
      'created_at': DateTime.now().millisecondsSinceEpoch,
      'likes': 0,
      'image': localDb.getString('photo'),
      'videoId': id
    });

    return newKey;
  }

  void doBookmark() async {
    SharedPreferences localDb = await SharedPreferences.getInstance();
    List<String> data = localDb.getStringList('favoritesId');
    if (data.indexOf(id.toString()) < 0) {
      // jika tidak ada
      data.insert(0, id.toString());
    } else {
      // jika ada
      data.removeAt(data.indexOf(id.toString()));
    }
    localDb.setStringList('favoritesId', data);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Color(0xFF0A0A19),
            backgroundColor: Color(0xFF0A0A19)),
        home: FutureBuilder(
          future: getInfoMovie(id),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? snapshot.data.value != null
                    ? DetailMovieApp(
                        initIndex: initIndex,
                        changeTab: this.changeTab,
                        data: snapshot.data.value is List
                            ? snapshot.data.value
                                .where((e) => e != null)
                                .toList()[0]
                            : snapshot.data.value[id.toString()],
                        commentMethod: this.sendComment,
                        doBookmark: this.doBookmark,
                        favorited: favorited)
                    : Center(
                        child: Container(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      )
                : Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
          },
        ));
  }
}

class DetailMovieApp extends StatelessWidget {
  DetailMovieApp(
      {Key key,
      @required this.initIndex,
      @required this.changeTab,
      @required this.data,
      @required this.commentMethod,
      this.doBookmark,
      this.favorited}) {
    tabPages = [
      ListEpisode(
        episodes: this.data['episodes'],
        idMovie: this.data['id'],
      ),
      ListComment(
          withInput: true,
          commentsId: this.data['id'],
          commentMethod: this.commentMethod)
    ];
  }

  final dynamic data;
  final int initIndex;
  final Function changeTab;
  final Function commentMethod;
  final Function doBookmark;
  final bool favorited;
  List<Widget> tabPages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              DetailMovieHeader(
                  image: data['image'],
                  score: data['score'],
                  rank: data['rank'],
                  season: data['season'],
                  title: data['title'],
                  genre: data['genres'],
                  episodes: data['episodes'],
                  doBookmark: doBookmark,
                  favorited: favorited),
              DetailMovieSinopsis(sinopsis: data['sinopsis']),
              DefaultTabController(
                initialIndex: initIndex,
                length: 2,
                child: TabBar(
                  onTap: changeTab,
                  labelColor: Color(0xFF87F5F5),
                  unselectedLabelColor: Colors.white.withOpacity(0.9),
                  indicatorColor: Color(0xFF87F5F5),
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
