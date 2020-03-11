import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otakudesu_app/Pages/secondary/detail_movie.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otakudesu_app/Pages/components/Cards/TrendingCard.dart';

class ListOfTrending extends StatelessWidget {
  final List<CardTrend> dummyData = [
    CardTrend(
      title: 'My Hero Academia',
      url:
          'https://vignette.wikia.nocookie.net/bokunoheroacademia/images/e/e9/Heroes_Rising_Promotional_Poster_2.png/revision/latest?cb=20190927203442',
    ),
    CardTrend(
      title: 'Haikyuu',
      url: 'https://cdn.myanimelist.net/images/anime/1694/104929.jpg',
    ),
    CardTrend(
      title: 'SAO Alicization',
      url:
          'https://www.kaorinusantara.or.id/wp-content/uploads/2019/07/Alicization-681x964.jpg',
    ),
    CardTrend(
      title: 'FGO Babylonia',
      url:
          'https://images-na.ssl-images-amazon.com/images/I/91c3zQ53miL._AC_SY741_.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: (MediaQuery.of(context).size.width * 0.70),
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: dummyData.length,
          itemBuilder: (context, index) => TouchableOpacity(
                activeOpacity: 0.7,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailMovie(),
                  ),
                ),
                child: CardWithText(
                  url: dummyData[index].url,
                  title: dummyData[index].title,
                ),
              )

          // itemBuilder: (context, index) => Container(
          //   margin: EdgeInsets.only(right: 10, left: 12, bottom: 0),
          //   width: MediaQuery.of(context).size.width * 0.35,
          //   padding: EdgeInsets.only(bottom: 5),
          //   color: Colors.pink,
          //   child: TouchableOpacity(
          //     activeOpacity: 0.7,
          //     onTap: () => Navigator.push(
          //       context,
          //       CupertinoPageRoute(
          //         builder: (context) => DetailMovie(),
          //       ),
          //     ),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       mainAxisSize: MainAxisSize.max,
          //       children: <Widget>[
          //         TrendCard(url: dummyData[index].url),
          //         Container(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             mainAxisSize: MainAxisSize.max,
          //             children: <Widget>[
          //               Container(
          //                 child: Text(
          //                   dummyData[index].title,
          //                   style: GoogleFonts.montserrat(
          //                     color: Colors.white,
          //                     fontSize: 13,
          //                   ),
          //                   textAlign: TextAlign.left,
          //                   overflow: TextOverflow.ellipsis,
          //                 ),
          //               ),
          //               SizedBox(
          //                 height: 7,
          //               ),
          //               Row(
          //                 children: <Widget>[
          //                   Image.network(
          //                     'https://cdn.myanimelist.net/img/sp/icon/apple-touch-icon-256.png',
          //                     height: 12,
          //                     width: 12,
          //                   ),
          //                   Container(
          //                     margin: EdgeInsets.only(left: 5, right: 5),
          //                     child: Text(
          //                       'Score: 8.33',
          //                       style: GoogleFonts.montserrat(
          //                         color: Colors.white,
          //                         fontSize: 10,
          //                       ),
          //                     ),
          //                   ),
          //                   Text(
          //                     '#201',
          //                     style: GoogleFonts.montserrat(
          //                       color: Color(0xFF5AA1A6),
          //                       fontSize: 10,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          ),
    );
  }
}

class CardWithText extends StatelessWidget {
  final String url, title;

  const CardWithText({this.url, this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(right: 10, left: 12, bottom: 0),
      color: Colors.transparent,
      child: Container(
        height: 20,
        width: MediaQuery.of(context).size.width * 0.35,
        child: Column(
          children: <Widget>[
            TrendCard(url: url),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    child: Text(
                      title,
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
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl:
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
            )
          ],
        ),
      ),
    );
  }
}

class CardTrend {
  String title;
  String url;

  CardTrend({this.title, this.url});
}
