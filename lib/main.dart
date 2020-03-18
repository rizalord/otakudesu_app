import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otakudesu_app/Pages/main/main_favorites.dart';
import 'package:otakudesu_app/Pages/main/main_home.dart';
import 'package:otakudesu_app/Pages/main/main_profile.dart';
import 'package:otakudesu_app/Pages/main/main_search.dart';

import 'Pages/auth/SplashScreenWithAuth.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Otakudesu',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFF0A0A19),
        ),
        home: SplashScreen());
  }
}

class GeneralApp extends StatefulWidget {
  @override
  _GeneralAppState createState() => _GeneralAppState();
}

class _GeneralAppState extends State<GeneralApp> {
  int selectedIndex = 0;
  List<Widget> _widgetOptions = [];

  @override
  void initState() {
    _widgetOptions = <Widget>[
      MainHome(onTabBar: onTapBar),
      MainSearch(),
      MainFavorites(),
      MainProfile(),
    ];
    super.initState();
  }

  void onTapBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // body: _widgetOptions.elementAt(selectedIndex),
      // body: TabBarView(

      //   children: widget._widgetOptions,
      // ),
      body: IndexedStack(
        index: selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                blurRadius: 20.0,
                spreadRadius: 5.0,
                offset: Offset(0, -1)),
          ],
        ),
        child: BottomNavigationBar(
          onTap: this.onTapBar,
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromRGBO(10, 10, 25, 1),
          selectedItemColor: Color.fromRGBO(135, 245, 245, 1),
          unselectedItemColor: Color.fromRGBO(102, 102, 102, 1),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              title: Text('Favorites'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
