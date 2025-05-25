import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;
  final int index;
  final void Function(BuildContext, int) showDialogAgain;

  const FullScreenVideoPlayer({
    super.key,
    required this.controller,
    required this.index,
    required this.showDialogAgain,
  });

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  bool isMuted = false;
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    widget.controller.play();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: VideoProgressIndicator(controller, allowScrubbing: false),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.replay_10,
                    color: Colors.white,
                    size: 36,
                  ),
                  onPressed: () {
                    final newPosition =
                        controller.value.position + const Duration(seconds: 10);
                    controller.seekTo(
                      newPosition > Duration.zero ? newPosition : Duration.zero,
                    );
                  },
                ),

                const SizedBox(width: 20),

                IconButton(
                  icon: Icon(
                    controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      controller.value.isPlaying
                          ? controller.pause()
                          : controller.play();
                    });
                  },
                ),

                const SizedBox(width: 20),

                IconButton(
                  icon: const Icon(
                    Icons.forward_10,
                    color: Colors.white,
                    size: 36,
                  ),
                  onPressed: () {
                    final maxDuration = controller.value.duration;
                    final newPosition =
                        controller.value.position - const Duration(seconds: 10);
                    controller.seekTo(
                      newPosition < maxDuration ? newPosition : maxDuration,
                    );
                  },
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 20,
            left: 20,
            child: IconButton(
              icon: const Icon(
                Icons.fullscreen_exit,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 300), () {
                  widget.showDialogAgain(context, widget.index);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
