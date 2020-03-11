import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otakudesu_app/Pages/secondary/watch_movie.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class ListEpisode extends StatelessWidget {
  final List<Episode> dummyData = [
    Episode(
        thumbnail:
            'https://news.otakukart.com/wp-content/uploads/2020/01/Haikyuu-Season-4-episode-1.jpg',
        time: 23,
        title: '1. Pengenalan'),
    Episode(
        thumbnail:
            'https://deku.zonawibu.cc/wp-content/uploads/2020/01/00000250.jpg',
        time: 23,
        title: '2. Kehilangan'),
    Episode(
        thumbnail:
            'https://haikyuutothetop3.files.wordpress.com/2020/01/1369348.jpg',
        time: 23,
        title: '3. Sudut Pandang'),
    Episode(
        thumbnail:
            'https://deku.zonawibu.cc/wp-content/uploads/2020/02/00000260.jpg',
        time: 23,
        title: '4. Santai Saja'),
    Episode(
        thumbnail:
            'https://www.oujanime.com/wp-content/uploads/2020/02/Haikyuu-S4-05.jpg',
        time: 23,
        title: '5. Lapar'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: dummyData.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 6),
        itemBuilder: (context, index) => TouchableOpacity(
          activeOpacity: 0.7,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoPlayerScreen(),
            ),
          ),
          child: EpisodeCard(
            title: dummyData[index].title,
            time: dummyData[index].time,
            thumbnail: dummyData[index].thumbnail,
          ),
        ),
      ),
    );
  }
}

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({
    Key key,
    @required this.thumbnail,
    @required this.title,
    @required this.time,
  }) : super(key: key);

  final String thumbnail, title;
  final int time;

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
                      title,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 15.5,
                      ),
                    ),
                    Text(
                      time.toString() + 'm',
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
