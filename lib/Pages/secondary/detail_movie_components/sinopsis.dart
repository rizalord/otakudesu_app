import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailMovieSinopsis extends StatelessWidget {

  final String sinopsis;
  DetailMovieSinopsis({this.sinopsis});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 108,
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 2),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.4),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Text(
              'Sinopsis',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            height: 76,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Text(
                sinopsis,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
