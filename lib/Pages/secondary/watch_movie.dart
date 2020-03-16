import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url ;
  VideoPlayerScreen({this.url});

  @override
  State<StatefulWidget> createState() {
    return _VideoPlayerScreenState();
  }
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  var videoPlayerController = VideoPlayerController.network(
      'https://firebasestorage.googleapis.com/v0/b/otakudesu-4500b.appspot.com/o/60.mkv?alt=media&token=ceb964ee-30c2-4191-af2a-48c9bc3317ec');
  ChewieController chewieController;
  var playerWidget;

  

  @override
  void initState() {
    BackButtonInterceptor.add(myInterceptor);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    this.videoPlayerController = VideoPlayerController.network(widget.url);
    this.chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        // aspectRatio: 3 / 2,
        autoPlay: true,
        looping: false,
        fullScreenByDefault: true,
        allowFullScreen: true,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown
        ],
        
        );

    this.playerWidget = Chewie(
      controller: chewieController,
    );
    super.initState();
  }

  bool myInterceptor(bool stopDefaultButtonEvent){
    if(chewieController.isFullScreen){
      chewieController.exitFullScreen();
    }else{
      Navigator.pop(context);  
    }
    return true;
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    BackButtonInterceptor.remove(myInterceptor);
    chewieController.dispose();
    videoPlayerController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF0A0A19),
      ),
      home: WillPopScope(
        onWillPop: ()async{ 
          print('pop spcoped');
          return false;
        },
        child: Scaffold(
          backgroundColor: Color(0xFF0A0A19),
          body: Center(
            child: Chewie(
              controller: chewieController,
            ),
          ),
        ),
      ),
    );
  }
}
