import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otakudesu_app/Pages/components/Cards/TrendingCard.dart';
import 'package:otakudesu_app/Pages/components/searchbar.dart';
import 'package:otakudesu_app/Pages/secondary/detail_movie.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class MainSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainSearchState();
  }
}

class _MainSearchState extends State<MainSearch> {
  bool show = false;
  List data = [];
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2 + 15;
    final double itemWidth = size.width / 2;

    void doSearch() async {
      if (textController.text.trim().length != 0) {
        print(textController.text);
        FirebaseDatabase.instance
            .reference()
            .child('videos')
            .orderByChild('title')
            // .equalTo(textController.text)
            .startAt(textController.text)
            .endAt(textController.text + '\uf8ff')
            .once()
            .then((DataSnapshot snapshot) {
          setState(() {
            show = true;
            data = snapshot.value == null
                ? []
                : snapshot.value.where((e) => e != null).toList();
            print(snapshot.value);
          });
        });
      }
    }

    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
        // color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SearchBar(
                controller: textController,
                callBack: doSearch,
              ),
              show == true ? ResultText(total: data.length) : Container(),
              show == true && data.length != 0
                  ? ListItemSearch(
                      itemWidth: itemWidth, itemHeight: itemHeight, data: data)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class ListItemSearch extends StatelessWidget {
  const ListItemSearch(
      {Key key, @required this.itemWidth, @required this.itemHeight, this.data})
      : super(key: key);

  final List data;
  final double itemWidth;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: (itemWidth / itemHeight),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      crossAxisCount: 2,
      children: data
          .map(
            (index) => TouchableOpacity(
              key: PageStorageKey(index),
              activeOpacity: 0.7,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailMovie(data: index['id']),
                ),
              ),
              child: Container(
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
                      url: index['image'],
                      ratio: 80,
                      radius: 10,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
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
                                  'Score: ' + index['score'].toString(),
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Text(
                                '#' + index['rank'].toString(),
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
          )
          .toList(),
    );
  }
}

class ResultText extends StatelessWidget {
  final int total;
  const ResultText({Key key, this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, bottom: 15),
      alignment: Alignment.center,
      child: Text(
        "Found " + total.toString() + " Results",
        style: GoogleFonts.montserrat(color: Colors.white),
        textAlign: TextAlign.start,
      ),
    );
  }
}
