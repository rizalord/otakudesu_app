import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function callBack;
  final TextEditingController controller;
  SearchBar({this.callBack , this.controller});
  
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  Function doSearch;
  var textController = TextEditingController();

  @override
  void initState() {
    doSearch = widget.callBack;
    textController = widget.controller;
    super.initState();
  }

  

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
                onEditingComplete: widget.callBack,
                controller: widget.controller,
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
