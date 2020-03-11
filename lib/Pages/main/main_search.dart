import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otakudesu_app/Pages/components/Cards/TrendingCard.dart';
import 'package:otakudesu_app/Pages/components/searchbar.dart';

class MainSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainSearchState();
  }
}

class _MainSearchState extends State<MainSearch> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2 + 15;
    final double itemWidth = size.width / 2;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
        // color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SearchBar(),
              Container(
                margin: EdgeInsets.only(left: 8, bottom: 15),
                alignment: Alignment.center,
                child: Text(
                  "Found 15 Results",
                  style: GoogleFonts.montserrat(color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ),
              GridView.count(
                childAspectRatio: (itemWidth / itemHeight),
                shrinkWrap: true,
                physics: ScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(
                  10,
                  (index) => Container(
                    // margin: EdgeInsets.only(right: 10, left: 12, bottom: 0),
                    padding: EdgeInsets.only(
                      bottom: 5,
                      right: 10,
                      left: 10,
                    ),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TrendCard(
                          url:
                              'https://cdn.myanimelist.net/images/anime/1694/104929.jpg',
                          ratio: 80,
                          radius: 10,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
            ],
          ),
        ),
      ),
    );
  }
}
