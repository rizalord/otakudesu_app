import 'package:flutter/material.dart';
import 'package:otakudesu_app/Pages/components/Cards/TrendingCard.dart';

class ListLatest extends StatelessWidget {
  final List<String> latests = [
    'https://i.pinimg.com/236x/81/74/a5/8174a5711895ad18c02be9f67350e85e--shiro-anime-manga-anime.jpg',
    'https://cdn.myanimelist.net/images/anime/11/79410.jpg',
    'https://www.kaorinusantara.or.id/wp-content/uploads/2019/12/heavens-feel.jpg',
    'https://cdn.myanimelist.net/images/anime/1153/99850.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      height: 150,
      // color: Colors.white,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: latests
              .map((data) => Container(
                    margin: EdgeInsets.only(right: 6, left: 12, bottom: 0),
                    width: MediaQuery.of(context).size.width * 0.30,
                    padding: EdgeInsets.only(bottom: 5),
                    child: TrendCard(url : data , radius: 10,),
                  ))
              .toList()),
    );
  }
}
