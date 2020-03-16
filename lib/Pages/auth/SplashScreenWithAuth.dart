import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:otakudesu_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key, this.widgetOptions}) : super(key: key);

  final List<Widget> widgetOptions;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showSignIn = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () async {
      SharedPreferences db = await SharedPreferences.getInstance();
      bool isLogged = db.getBool('isLogin') == true ? true : false;
      if (!isLogged) {
        setState(() {
          showSignIn = true;
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GeneralApp(),
          ),
        );
      }
    });
    super.initState();
  }

  void _handleSignIn() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    bool newUser = authResult.additionalUserInfo.isNewUser;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    String email = user.providerData[0].email;
    String uId = user.providerData[0].uid;
    String photo = user.providerData[0].photoUrl;
    String name = user.displayName;

    if (user != null) {

      if(newUser){
        FirebaseDatabase.instance.reference().child('users').child(uId).set({
          "uid" : uId,
        });
      }

      SharedPreferences db = await SharedPreferences.getInstance();
      await db.setString('userId', uId);
      await db.setString('email', email);
      await db.setString('photo', photo);
      await db.setString('name', name);
      await db.setBool('isLogin', true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GeneralApp(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(105, 215, 215, 1),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/logo_app.png',
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                  // CachedNetworkImage(
                  //   imageUrl:
                  //       'https://otakudesu.org/wp-content/uploads/2019/08/otakudesu.png',
                  // width: MediaQuery.of(context).size.width * 0.7,
                  // ),
                ),
                showSignIn
                    ? TouchableOpacity(
                        activeOpacity: 0.8,
                        onTap: _handleSignIn,
                        child: Container(
                          margin: EdgeInsets.only(top: 25),
                          width: MediaQuery.of(context).size.width * 0.72,
                          height: MediaQuery.of(context).size.width * 0.13,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'Google',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(85, 195, 195, 1),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.13,
                                  height:
                                      MediaQuery.of(context).size.width * 0.13,
                                  // color: Colors.pink,
                                  child: Icon(
                                    MdiIcons.google,
                                    color: Color.fromRGBO(85, 195, 195, 1),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            Positioned(
              bottom: 10,
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 3,
                  color: Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
