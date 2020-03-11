import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otakudesu_app/Pages/components/Cards/TrendingCard.dart';

class MainFavorites extends StatefulWidget {


  @override
  _MainFavoritesState createState() => _MainFavoritesState();
}

class _MainFavoritesState extends State<MainFavorites> {


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2 + 15;
    final double itemWidth = size.width / 2;

    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.15,
              // color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                'My Favorites',
                style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
              ),
              // margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withOpacity(0.5),
                    width: 1,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                childAspectRatio: (itemWidth / itemHeight),
                shrinkWrap: true,
                physics: ScrollPhysics(),
                crossAxisCount: 3,
                children: List.generate(
                  10,
                  (index) => Container(
                    margin: EdgeInsets.only(top : 20),
                    padding: EdgeInsets.only(
                      bottom: 0,
                      right: 10,
                      left: 10,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TrendCard(
                          url:
                              'https://cdn.myanimelist.net/images/anime/1694/104929.jpg',
                          ratio: 5,
                          radius: 3,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Haikyuu',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.network(
                                    'https://cdn.myanimelist.net/img/sp/icon/apple-touch-icon-256.png',
                                    height: 12,
                                    width: 12,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5, right: 5),
                                    child: Text(
                                      'Score: 8.33',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 10,
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
