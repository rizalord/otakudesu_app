import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailMovieHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.width * 1.28,
          child: CachedNetworkImage(
            imageUrl:
                'https://cdn.myanimelist.net/images/anime/1813/105367l.jpg',
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
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.chevron_left,
              color: Color.fromRGBO(240, 240, 240, 1),
            ),
            iconSize: 35,
          ),
        ),
        Positioned(
          top: 15,
          right: 0,
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.star,
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
                          'Score: 8.33',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(
                        '#201',
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
                      'Haikyuu',
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
                    'Season Keempat - Sport/Comedy',
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
                      Text(
                        'Watch',
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 15),
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
