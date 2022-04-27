import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class MyVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const MyVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  late Chewie _playerWidget;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        "https://imdb-video.media-imdb.com/vi3986080537/1434659607842-pgv4ql-1633625495700.mp4?Expires=1642524118&Signature=h49VVZrCEUIFVaBfZtAsFf3zY1cydvEmJXlyigQh52XfT6aYRksGjEbaxa1~TIjImpoCMEXzgpiYaGMqwXr5G6lGoqTOVtMNDrUvj43wPOzgaeUuggxO~iSBkOrRFHntov3TwHRQ5QN4tSywIaF~hMTpnivmBJFM0FXU~~ijLFlykUQcqE--Z9mYe99hiKgNFLbTTd5TmiDY6I4~prcfvJ4MrJWn1wRwou3DPN35tJLSvLNI0a89jfnRjpRiCC~qGkcv28n~9WV6GR90pX~N7qN32wiDxMD8YWaG6AxJe7rqMf0DGOVqGva7WrmzFEEXW8OIbkltgafXnXp1nZCCZQ__&Key-Pair-Id=APKAIFLZBVQZ24NQH3KA")
      ..initialize().then((_) {
        _chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: true,
          looping: true,
          showControls: true
        );
        _playerWidget = Chewie(
          controller: _chewieController,
        );
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    return Scaffold(
      body: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.value.isPlaying) {
            setState(() {
              _controller.pause();
            });
          } else {
            setState(() {
              _controller.play();
            });
          }
        },
        child: _controller.value.isPlaying
            ? const Icon(Icons.pause)
            : const Icon(Icons.play_arrow),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }
}
