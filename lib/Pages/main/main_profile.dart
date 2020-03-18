import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:otakudesu_app/Pages/auth/SplashScreenWithAuth.dart';
import 'package:otakudesu_app/Pages/secondary/detail_movie_components/list_comment.dart';
import 'package:otakudesu_app/Pages/secondary/detail_movie_components/list_episode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class MainProfile extends StatefulWidget {
  @override
  _MainProfileState createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  void doLogout() async {
    print('logout');
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SplashScreen()));

    
  }

  @override
  void initState() {
    super.initState();
  }

  final List<Widget> listTab = [
    ListEpisode(onProfile: true),
    ListComment(withInput: false),
  ];
  var activeIndex = 0;
  String _imageProfile = '', _name = '';

  void changeActiveTab(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  getProfileName() async {
    SharedPreferences db = await SharedPreferences.getInstance();
    _name = db.getString('name');
    return _name;
  }

  getProfilePhoto() async {
    SharedPreferences db = await SharedPreferences.getInstance();
    return db.getString('photo');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
    ));
    return Container(
        color: Color(0xFF232535),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 2,
                    height: (MediaQuery.of(context).size.width * 0.5),
                    color: Color(0xFF232535),
                  ),
                ),
                Positioned(
                  top: -(MediaQuery.of(context).size.width * 0.30),
                  left: -(MediaQuery.of(context).size.width * 0.30),
                  child: Transform.rotate(
                    angle: -22 / 7 / 30.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 2,
                      height: (MediaQuery.of(context).size.width * 0.63),
                      color: Color.fromRGBO(105, 215, 215, 1),
                    ),
                  ),
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.width * 0.22),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: (MediaQuery.of(context).size.width * 0.25),
                    alignment: Alignment.center,
                    child: FutureBuilder(
                      future: getProfilePhoto(),
                      builder: (context, snapshot) {
                        String url = '';
                        if (snapshot.hasData) {
                          url = snapshot.data;
                        }

                        return Container(
                          width: (MediaQuery.of(context).size.width * 0.25),
                          height: (MediaQuery.of(context).size.width * 0.25),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(
                              (MediaQuery.of(context).size.width * 0.22),
                            ),
                            border: Border.all(width: 2, color: Colors.white),
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(url),
                                fit: BoxFit.fill),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 0,
                  child: Container(
                    width: 60,
                    height: 60,
                    child: TouchableOpacity(
                      onTap: doLogout,
                      child: Center(
                        child: IconButton(
                          icon: Icon(MdiIcons.exitToApp),
                          iconSize: 30,
                          onPressed: doLogout,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                margin: EdgeInsets.only(bottom: 10),
                alignment: Alignment.center,
                child: FutureBuilder(
                  future: getProfileName(),
                  builder: (context, snapshot) {
                    String _name = '';
                    if (snapshot.hasData) {
                      _name = snapshot.data;
                    }
                    return Text(
                      _name,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    );
                  },
                )),
            DefaultTabController(
              length: 2,
              initialIndex: activeIndex,
              child: TabBar(
                onTap: changeActiveTab,
                indicatorColor: Color.fromRGBO(105, 215, 215, 1),
                tabs: <Widget>[
                  Tab(
                    text: 'History',
                  ),
                  Tab(
                    text: 'Comment',
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Color(0xFF1D202D),
                constraints: BoxConstraints.expand(),
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(top: 0),
                    child: listTab.elementAt(activeIndex),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
