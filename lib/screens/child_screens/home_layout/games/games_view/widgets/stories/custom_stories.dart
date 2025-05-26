import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomStories extends StatefulWidget {
  const CustomStories({super.key});

  @override
  State<CustomStories> createState() => _CustomStoriesState();
}

class _CustomStoriesState extends State<CustomStories> {
  final List<YoutubePlayerController> _controller = [];
  @override
  void initState() {
    super.initState();
    final stories = AppCubit.get(context).stories;
    for (int i = 0; i < stories.length; i++) {
      final videoUrl = stories[i].video;
      final videoId = YoutubePlayer.convertUrlToId(videoUrl);

      if (videoId != null) {
        _controller.add(
          YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
              hideControls: false,
            ),
          ),
        );
      } else {
        debugPrint('Invalid YouTube URL: $videoUrl');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xffAAD8FC), Color(0xffFCAADA)],
            ),
          ),
          child: GridView.builder(
            padding: EdgeInsets.only(
              right: 16.w,
              left: 16.w,
              bottom: 24.h,
              top: 40.h,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.0,
            ),
            itemCount: _controller.length,
            itemBuilder: (context, index) {
              return InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  showDialog(
                    context: context,
                    useSafeArea: false,
                    builder: (context) {
                      return StoryVideo(controller: _controller, index: index);
                    },
                  );
                },
                child: Container(
                  height: 100.w,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                      image: NetworkImage(
                        AppCubit.get(context).stories[index].thumbnail,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class StoryVideo extends StatelessWidget {
  final int index;
  const StoryVideo({
    super.key,
    required List<YoutubePlayerController> controller,
    required this.index,
  }) : _controller = controller;

  final List<YoutubePlayerController> _controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(0),
      content: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: YoutubePlayer(
          controller: _controller[index],
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
          progressColors: const ProgressBarColors(
            playedColor: Colors.red,
            handleColor: Colors.red,
          ),),
      ),
    );
  }
}
