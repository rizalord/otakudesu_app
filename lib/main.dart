import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otakudesu_app/Pages/main/main_favorites.dart';
import 'package:otakudesu_app/Pages/main/main_home.dart';
import 'package:otakudesu_app/Pages/main/main_profile.dart';
import 'package:otakudesu_app/Pages/main/main_search.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
    ]);
    selectedIndex = 0;
    _widgetOptions = <Widget>[
      MainHome(),
      MainSearch(),
      MainFavorites(),
      MainProfile(),
    ];

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

  void onTapBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Otakudesu',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF0A0A19),
      ),
      home: GeneralApp(
        widgetOptions: _widgetOptions,
        selectedIndex: selectedIndex,
        onTabBar: this.onTapBar,
      ),
    );
  }
}

class GeneralApp extends StatefulWidget {


  const GeneralApp({
    Key key,
    @required List<Widget> widgetOptions,
    @required this.selectedIndex,
    @required this.onTabBar,
  })  : _widgetOptions = widgetOptions,
        super(key: key);

  final List<Widget> _widgetOptions;
  final int selectedIndex;
  final Function onTabBar;

  @override
  _GeneralAppState createState() => _GeneralAppState();
}

class _GeneralAppState extends State<GeneralApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: widget._widgetOptions.elementAt(widget.selectedIndex),
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
          onTap: widget.onTabBar,
          currentIndex: widget.selectedIndex,
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
