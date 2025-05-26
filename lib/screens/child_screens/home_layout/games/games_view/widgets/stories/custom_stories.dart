import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/core/widgets/app_text.dart';
import 'package:video_player/video_player.dart';

import 'widgets/full_screen_video.dart';

class CustomStories extends StatefulWidget {
  const CustomStories({super.key});

  @override
  State<CustomStories> createState() => _CustomStoriesState();
}

class _CustomStoriesState extends State<CustomStories> {
  final List<VideoPlayerController> _controllers = [];
  @override
  void initState() {
    for (var story in AppCubit.get(context).stories) {
      final controller = VideoPlayerController.asset(story.video)
        ..initialize().then((_) {
          setState(() {});
        });
      _controllers.add(controller);
    }

    super.initState();
  }

  void _showVideoDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(0),
          backgroundColor: Colors.black,
          child: StatefulBuilder(
            builder: (context, setState) {
              ValueNotifier<bool> showControllers = ValueNotifier<bool>(true);

              return ValueListenableBuilder<bool>(
                valueListenable: showControllers,
                builder: (context, value, _) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AspectRatio(
                        aspectRatio: _controllers[index].value.aspectRatio,
                        child: GestureDetector(
                          onTap: () {
                            showControllers.value = !showControllers.value;
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              VideoPlayer(_controllers[index]),
                              if (value) ...{
                                PositionedDirectional(
                                  top: 10.h,
                                  start: 10.w,
                                  child: TextButton(
                                    onPressed: () {
                                      _controllers[index].pause();
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 30.sp,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.replay_10,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _controllers[index].seekTo(
                                              _controllers[index]
                                                      .value
                                                      .position +
                                                  const Duration(seconds: 10),
                                            );
                                          });
                                        },
                                      ),
                                      const SizedBox(width: 20),

                                      IconButton(
                                        icon: Icon(
                                          _controllers[index].value.isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _controllers[index].value.isPlaying
                                                ? _controllers[index].pause()
                                                : _controllers[index].play();
                                          });
                                        },
                                      ),

                                      const SizedBox(width: 20),

                                      IconButton(
                                        icon: const Icon(
                                          Icons.forward_10,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _controllers[index].seekTo(
                                              _controllers[index]
                                                      .value
                                                      .position -
                                                  const Duration(seconds: 10),
                                            );
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 5.h,
                                  left: 5.w,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.fullscreen,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) => FullScreenVideoPlayer(
                                                controller: _controllers[index],
                                                index: index,
                                                showDialogAgain:
                                                    _showVideoDialog,
                                              ),
                                        ),
                                      );
                                      _showVideoDialog(context, index);
                                    },
                                  ),
                                ),
                              },
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: VideoProgressIndicator(
                                  _controllers[index],
                                  allowScrubbing: false,
                                  colors: const VideoProgressColors(
                                    playedColor: Colors.red,
                                    backgroundColor: Colors.grey,
                                    bufferedColor: Colors.white54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsetsDirectional.only(top: 60.h),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xffAAD8FC), Color(0xffFCAADA)],
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  itemCount: _controllers.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0.5,
                    mainAxisSpacing: 10.h,
                    childAspectRatio: 0.95,
                  ),
                  itemBuilder: (context, index) {
                    final controller = _controllers[index];
                    return Column(
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            _showVideoDialog(context, index);
                          },
                          child: Container(
                            height: 135.h,
                            width: 160.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child:
                                controller.value.isInitialized
                                    ? Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            20.r,
                                          ),
                                          child: AspectRatio(
                                            aspectRatio:
                                                controller.value.aspectRatio,
                                            child: VideoPlayer(controller),
                                          ),
                                        ),
                                        Container(
                                          height: 135.h,
                                          width: 160.w,
                                          decoration: BoxDecoration(
                                            color: Colors.black.withAlpha(150),
                                            borderRadius: BorderRadius.circular(
                                              20.r,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                    : Container(),
                          ),
                        ),
                        SizedBox(
                          width: 150.w,
                          child: AppText(
                            textAlign: TextAlign.center,
                            text: AppCubit.get(context).stories[index].name,
                            size: 16.sp,
                            fontWeight: FontWeight.bold,
                            top: 8.h,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
