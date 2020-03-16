import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_formatter/time_formatter.dart';

class ListComment extends StatefulWidget {
  final bool withInput;
  int commentsId;
  ListComment({this.withInput = true, this.commentsId, this.commentMethod});
  final Function commentMethod;

  @override
  _ListCommentState createState() => _ListCommentState();
}

class _ListCommentState extends State<ListComment> {
  final DatabaseReference _db = FirebaseDatabase.instance.reference();
  final textController = TextEditingController();
  int commentsId;
  bool withInput;
  Function commentMethod;
  List<dynamic> comments = [];

  @override
  void initState() {
    commentsId = widget.commentsId;
    withInput = widget.withInput;
    commentMethod = widget.commentMethod;
    getComments(commentsId, withInput);
    super.initState();
  }

  void renderComment(String text, String key) async {
    SharedPreferences localDb = await SharedPreferences.getInstance();

    setState(() {
      comments.insert(0, {
        'commentId': key,
        'text': text,
        'name': localDb.getString('name'),
        'uid': localDb.getString('userId'),
        'created_at': DateTime.now().millisecondsSinceEpoch,
        'likes': 0,
        'image': localDb.getString('photo')
      });
    });
  }

  getComments(int id, bool withInput) async {
    if (withInput) {
      _db
          .child('videos')
          .child(id.toString())
          .child('comments')
          .orderByChild('likes')
          .once()
          .then((DataSnapshot snapshot) {
        setState(() {
          comments = snapshot.value != null
              ? snapshot.value.entries
                  .map((e) => e.value)
                  .toList()
                  .reversed
                  .toList()
              : [];
        });
      });
    } else {
      SharedPreferences local = await SharedPreferences.getInstance();

      _db
          .child('users')
          .child(local.getString('userId'))
          .child('comments')
          .orderByChild('created_at')
          .limitToLast(10)
          .once()
          .then((DataSnapshot snapshot) {
        List list = snapshot.value.entries.map((e) => e.value).toList();
        list.sort((a, b) => b['created_at'].compareTo(a['created_at']));

        setState(() {
          comments = list != null ? list : [];
        });
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return commentsId == null && withInput == true
        ? Container()
        : Container(
            child: Column(
              children: <Widget>[
                Container(
                  color: Color.fromRGBO(30, 30, 30, 1),
                  padding: EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: Form(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: withInput == false ? 0 : 10,
                        right: 5,
                      ),
                      padding: EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: widget.withInput
                          ? Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: TextFormField(
                                    controller: textController,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    cursorColor: Colors.white.withOpacity(0.6),
                                    decoration: InputDecoration(
                                      focusColor: Colors.white,
                                      fillColor: Colors.white,
                                      // labelStyle: TextStyle(color: Colors.white),
                                      // labelText: 'Type a comment',
                                      // disabledBorder: UnderlineInputBorder(
                                      //   borderSide: BorderSide(
                                      //       color: Colors.white.withOpacity(0.6), width: 1),
                                      // ),
                                      // border: UnderlineInputBorder(
                                      //   borderSide: BorderSide(
                                      //       color: Colors.white.withOpacity(0.6), width: 1),
                                      // ),
                                      // enabledBorder: UnderlineInputBorder(
                                      //   borderSide: BorderSide(
                                      //       color: Colors.white.withOpacity(0.6), width: 1),
                                      // ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                      ),
                                      hintText: 'Type a comment',
                                      hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.5)),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    if (textController.text.isNotEmpty) {
                                      String key = await widget
                                          .commentMethod(textController.text);
                                      renderComment(textController.text, key);
                                      textController.clear();
                                    }
                                  },
                                ),
                              ],
                            )
                          : Container(),
                    ),
                  ),
                ),
                Container(
                  child: ListView.builder(
                    itemCount: comments.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 0),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CommentCard(
                          image: comments[index]['image'],
                          name: comments[index]['name'],
                          time: comments[index]['created_at'],
                          text: comments[index]['text'],
                          like: comments[index]['likes'],
                          withInput: widget.withInput);
                    },
                  ),
                )
              ],
            ),
          );
  }
}

class CommentCard extends StatelessWidget {
  final String image, name, text;
  final int time, like;
  final bool withInput;
  CommentCard(
      {this.image, this.name, this.text, this.time, this.like, this.withInput});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 0),
      borderOnForeground: false,
      elevation: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        // height: 150,
        padding: EdgeInsets.only(left: 15, top: 10, bottom: 5),
        decoration: BoxDecoration(
          color: Color.fromRGBO(20, 20, 20, 1),
          border: Border(
            bottom: BorderSide(color: Colors.white.withOpacity(.15), width: 1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 45,
              height: 45,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                color: Colors.white.withOpacity(0.4),
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: CachedNetworkImageProvider(image),
                ),
                border: Border.all(
                  width: 1,
                  color: Colors.black.withOpacity(.3),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 30 - 55,
              // height: 150,
              // color: Colors.white,
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Text(
                          name,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          ' - ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          formatTime(time),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Text(
                      text,
                      style: GoogleFonts.poppins(
                        color: Colors.white.withOpacity(.9),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 30 - 55,
                    height: withInput ? 30 : 10,
                    margin: EdgeInsets.only(top: 5),
                    // color: Colors.white,
                    child: withInput
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                              Text(
                                like.toString(),
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          )
                        : Container(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
