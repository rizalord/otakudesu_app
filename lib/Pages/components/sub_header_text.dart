import 'package:flutter/material.dart';

class SubHeaderText extends StatelessWidget {
  final String headerTitle;
  final String rightText;
  final double leftTextSize;
  SubHeaderText({this.headerTitle, this.rightText = '' , this.leftTextSize = 18});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, top: 15, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            headerTitle,
            style: TextStyle(
                fontSize: this.leftTextSize,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),
          Text(
            rightText,
            style: TextStyle(
              fontSize: 15,
              color: Color.fromRGBO(89, 143, 150, 1),
            ),
          ),
        ],
      ),
    );
  }
}
