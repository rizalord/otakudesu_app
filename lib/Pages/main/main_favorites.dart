import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otakudesu_app/Pages/components/Cards/TrendingCard.dart';
import 'package:otakudesu_app/Pages/secondary/detail_movie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class MainFavorites extends StatefulWidget {
  @override
  _MainFavoritesState createState() => _MainFavoritesState();
}

class _MainFavoritesState extends State<MainFavorites> {
  bool show = false;
  List<dynamic> dataFavorites = [];

  @override
  void initState() {
    getFavorites();
    super.initState();
  }

  void getFavorites() async {
    SharedPreferences localDb = await SharedPreferences.getInstance();
    List<String> data = localDb.getStringList('favoritesId');
    int inc = 0;
    data.reversed.forEach((element) async {
      await FirebaseDatabase.instance
          .reference()
          .child('videos')
          .orderByChild('id')
          .equalTo(int.parse(element))
          .limitToLast(1)
          .once()
          .then((DataSnapshot snapshot) {
        dataFavorites.insert(
            0, snapshot.value.where((e) => e != null).toList()[0]);
        inc += 1;
      }).whenComplete(() {
        if (inc == data.length) {
          setState(() {
            show = true;
          });
        }
      });
    });
  }

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
                children: show == true
                    ? dataFavorites
                        .map(
                          (index) => TouchableOpacity(
                            key: PageStorageKey(index),
                            activeOpacity: 0.7,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailMovie(data: index['id']),
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(top: 20),
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
                                    url: index['image'],
                                    ratio: 5,
                                    radius: 3,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Container(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Text(
                                              index['title'],
                                              style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontSize: 13,
                                              ),
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Container(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Image.network(
                                                  'https://cdn.myanimelist.net/img/sp/icon/apple-touch-icon-256.png',
                                                  height: 12,
                                                  width: 12,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 5, right: 5),
                                                  child: Text(
                                                    'Score: ' +
                                                        index['score']
                                                            .toString(),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '#' +
                                                      index['rank'].toString(),
                                                  style: GoogleFonts.montserrat(
                                                    color: Color(0xFF5AA1A6),
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList()
                    : <Widget>[Container()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
