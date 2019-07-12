import 'package:flutter/material.dart';
import 'package:ung_tpa/models/ung_video_model.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class PlayVideo extends StatefulWidget {
  final UngVideoModel ungVideoModel;
  PlayVideo({Key key, this.ungVideoModel}) : super(key: key);

  @override
  _PlayVideoState createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  // Explicit
  UngVideoModel ungVideoModel;
  ChewieController chewieController;
  VideoPlayerController videoPlayController;
  String urlVideo;

  // Method
  @override
  void initState() {
    super.initState();
    setState(() {
      ungVideoModel = widget.ungVideoModel;
      urlVideo = ungVideoModel.pathVideo;

      videoPlayController = VideoPlayerController.network(urlVideo);
      chewieController = ChewieController(
        videoPlayerController: videoPlayController,
        aspectRatio: 3 / 2,
        autoPlay: true,
        looping: true,
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayController.dispose();
    chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play Video ${ungVideoModel.name}'),
      ),
      body: Center(child: Chewie(controller: chewieController,),),
    );
  }
}
