import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 19, right: 10),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Form(
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  labelStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
