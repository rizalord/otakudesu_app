import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otakudesu_app/Pages/secondary/watch_movie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class ListEpisode extends StatefulWidget {
  final List<dynamic> episodes;
  final bool onProfile;
  final int idMovie;
  ListEpisode({this.episodes, this.onProfile = false, this.idMovie = null});

  @override
  _ListEpisodeState createState() => _ListEpisodeState();
}

class _ListEpisodeState extends State<ListEpisode> {
  List episodeProfile = [];

  addToHistory(Map<dynamic, dynamic> episode) async {
    episode['taked_at'] = DateTime.now().millisecondsSinceEpoch;
    SharedPreferences local = await SharedPreferences.getInstance();
    String userId = local.getString('userId');

    String key = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(userId)
        .child('episodes')
        .push()
        .key;

    await FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(userId)
        .child('episodes')
        .child(key)
        .set(episode);

    viewCounter();
  }

  viewCounter() {
    if (widget.idMovie != null) {
      FirebaseDatabase.instance
          .reference()
          .child('videos')
          .child(widget.idMovie.toString())
          .child('views')
          .once()
          .then((DataSnapshot snapshot) {
        int views = snapshot.value + 1;
        FirebaseDatabase.instance
            .reference()
            .child('videos')
            .child(widget.idMovie.toString())
            .child('views')
            .set(views);
      });
    }
  }

  @override
  void initState() {
    getVideoHistory();
    super.initState();
  }

  getVideoHistory() async {
    SharedPreferences db = await SharedPreferences.getInstance();
    String userId = db.getString('userId');
    FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(userId)
        .child('episodes')
        .orderByChild('taked_at')
        .limitToLast(10)
        .once()
        .then((DataSnapshot snapshot) {
      List list = snapshot.value.entries.map((e) => e.value).toList();
      list.sort((a, b) => b['taked_at'].compareTo(a['taked_at']));

      setState(() {
        episodeProfile = list != null ? list : [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.episodes == null && widget.onProfile == false
        ? Container()
        : Container(
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: !widget.onProfile
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.episodes.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 6),
                    itemBuilder: (context, index) => TouchableOpacity(
                      activeOpacity: 0.7,
                      onTap: () {
                        addToHistory(widget.episodes[index]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPlayerScreen(
                                url: widget.episodes[index]['url']),
                          ),
                        );
                      },
                      child: EpisodeCard(
                        title: widget.episodes[index]['title'],
                        time: widget.episodes[index]['time_duration'],
                        thumbnail: widget.episodes[index]['thumbnail'],
                        episode: widget.episodes[index]['episode'],
                      ),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: episodeProfile.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 6),
                    itemBuilder: (context, index) => TouchableOpacity(
                      activeOpacity: 0.7,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPlayerScreen(
                                url: episodeProfile[index]['url']),
                          ),
                        );
                      },
                      child: EpisodeCard(
                        title: episodeProfile[index]['title'],
                        time: episodeProfile[index]['time_duration'],
                        thumbnail: episodeProfile[index]['thumbnail'],
                        episode: episodeProfile[index]['episode'],
                      ),
                    ),
                  ));
  }
}

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({
    Key key,
    @required this.thumbnail,
    @required this.title,
    @required this.time,
    @required this.episode,
  }) : super(key: key);

  final String thumbnail, title, time;
  final int episode;

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.pink,
      margin: EdgeInsets.only(bottom: 6, left: 15, top: 6),
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 0.25,
        child: Row(
          children: <Widget>[
            Container(
              // color: Colors.black,
              width: MediaQuery.of(context).size.width * 0.40,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      // color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(.45),
                        width: .5,
                      ),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(thumbnail),
                          fit: BoxFit.cover),
                    ),
                    foregroundDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black.withOpacity(0.15),
                        backgroundBlendMode: BlendMode.darken),
                  ),
                  Container(
                    child: Center(
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 12, right: 10, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${episode}. ${title}",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 15.5,
                      ),
                    ),
                    Text(
                      time.toString(),
                      style: GoogleFonts.roboto(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 14,
                          height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Episode {
  String thumbnail, title;
  int time;

  Episode({this.thumbnail, this.title, this.time});
}
