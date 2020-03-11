import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
    ));
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              width: MediaQuery.of(context).size.width * 2,
              height: (MediaQuery.of(context).size.width * 0.80),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          Positioned(
            top: -(MediaQuery.of(context).size.width * 0.30),
            left: -(MediaQuery.of(context).size.width * 0.30),
            child: Transform.rotate(
              angle: -22 / 7 / 15.0,
              child: Container(
                width: MediaQuery.of(context).size.width * 2,
                height: (MediaQuery.of(context).size.width * 0.60),
                color: Color.fromRGBO(105, 215, 215, 1),
              ),
            ),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.width * 0.30),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Colors.pink.withOpacity(0.5),
            ),
          )
        ],
      ),
    );
  }
}
