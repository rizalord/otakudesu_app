import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../watch_movie.dart';

class DetailMovieHeader extends StatelessWidget {
  final String image, title;
  final int rank, season;
  final double score;
  final List<dynamic> genre;
  final Function doBookmark;
  final bool favorited;
  final List<dynamic> episodes;
  String lastGenre;

  DetailMovieHeader(
      {this.image,
      this.title,
      this.rank,
      this.season,
      this.score,
      this.genre,
      this.doBookmark,
      this.favorited,
      this.episodes}) {
    lastGenre = this.genre.join(' / ');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.width * 1.28,
          child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width * 1.28 + 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: AlignmentDirectional.topCenter,
                  end: Alignment(0, 1),
                  colors: [
                    Color(0xFF0A0A19).withOpacity(0.4),
                    Colors.transparent,
                    Color(0xFF0A0A19).withOpacity(1),
                  ]),
            ),
          ),
        ),
        Positioned(
          top: 15,
          left: 0,
          child: Container(
            width: 50,
            height: 50,
            child: TouchableOpacity(
              activeOpacity: 0.3,
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Icon(
                Icons.chevron_left,
                color: Color.fromRGBO(240, 240, 240, 1),
                size: 35,
              ),
            ),
          ),
        ),
        Positioned(
          top: 15,
          right: 0,
          child: IconButton(
            onPressed: doBookmark,
            icon: Icon(
              favorited == true ? Icons.star : Icons.star_border,
              color: Color(0xFF87F5F5),
            ),
            iconSize: 35,
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            // color: Colors.white.withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.network(
                        'https://cdn.myanimelist.net/img/sp/icon/apple-touch-icon-256.png',
                        height: 22,
                        width: 22,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                          'Score: ${this.score}',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(
                        '#${this.rank}',
                        style: GoogleFonts.montserrat(
                          color: Color(0xFF5AA1A6),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 28),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Season ${this.season} - ${this.lastGenre}',
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 13),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment(0, 0),
                        colors: [Color(0xFF03FBEE), Color(0xFF4C95ED)]),
                  ),
                  width: 95,
                  padding:
                      EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 30,
                      ),
                      TouchableOpacity(
                        activeOpacity: 0.8,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VideoPlayerScreen(url: episodes[0]['url']),
                            ),
                          );
                        },
                        child: Text(
                          'Watch',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
