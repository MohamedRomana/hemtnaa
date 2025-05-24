import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/constants/colors.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../doctor_view/doctor_view.dart';
import 'videos_shimmer_loading.dart';
import 'videos_view.dart';

class VideosListView extends StatefulWidget {
  const VideosListView({super.key});

  @override
  State<VideosListView> createState() => _VideosListViewState();
}

class _VideosListViewState extends State<VideosListView> {
  List<VideoPlayerController> controllers = [];
  Map<int, int> visibleItemCounts = {};
  final List<String> videoPaths = [Assets.video.ramadan, Assets.video.haha];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      String videoPath = videoPaths[i % videoPaths.length];

      controllers.add(
        VideoPlayerController.asset(videoPath)
          ..initialize().then((_) {
            setState(() {});
          }),
      );

      visibleItemCounts[i] = 3;
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _showVideoDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(10),
          backgroundColor: Colors.black,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AspectRatio(
                    aspectRatio: controllers[index].value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        VideoPlayer(controllers[index]),

                        PositionedDirectional(
                          top: 10.h,
                          start: 10.w,
                          child: TextButton(
                            onPressed: () {
                              controllers[index].pause();
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
                                    controllers[index].seekTo(
                                      controllers[index].value.position +
                                          const Duration(seconds: 10),
                                    );
                                  });
                                },
                              ),
                              const SizedBox(width: 20),

                              IconButton(
                                icon: Icon(
                                  controllers[index].value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  setState(() {
                                    controllers[index].value.isPlaying
                                        ? controllers[index].pause()
                                        : controllers[index].play();
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
                                    controllers[index].seekTo(
                                      controllers[index].value.position -
                                          const Duration(seconds: 10),
                                    );
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  VideoProgressIndicator(
                    controllers[index],
                    allowScrubbing: false,
                    colors: const VideoProgressColors(
                      playedColor: Colors.red,
                      backgroundColor: Colors.grey,
                      bufferedColor: Colors.white54,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsetsDirectional.only(
        start: 24.w,
        end: 24.w,
        top: 16.h,
        bottom: 120.h,
      ),
      itemCount: 10,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder:
          (context, index) => Container(
            width: 343.w,
            padding: EdgeInsetsDirectional.only(
              start: 12.w,
              top: 12.h,
              bottom: 12.h,
            ),
            decoration: BoxDecoration(
              color:
                  index.isEven
                      ? const Color(0xffFFF5DF)
                      : const Color(0xffDFEBFF),
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  spreadRadius: 1.r,
                  blurRadius: 5.r,
                  offset: Offset(0, 5.r),
                ),
              ],
            ),
            child: Column(
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    AppRouter.navigateTo(
                      context,
                      const DoctorView(),
                    );
                  },
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(1000.r),
                        child: Image.asset(
                          Assets.img.doctor2.path,
                          height: 44.w,
                          width: 44.w,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200.w,
                            child: AppText(
                              start: 8.w,
                              text: 'د/عمرو',
                              size: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            width: 200.w,
                            child: AppText(
                              start: 8.w,
                              text: 'منذ ساعتين',
                              size: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 300.w,
                  child: AppText(
                    top: 20.h,
                    textAlign: TextAlign.start,
                    text:
                        'تحدث مع الطفل بوضوح وصبر - شاركه ألعاب وأنشطة تعزز الكلمات والحروف.',
                    lines: 2,
                    fontWeight: FontWeight.w600,
                    size: 12.sp,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 90.h,
                  child:
                      controllers[index].value.isInitialized
                          ? ListView.separated(
                            padding: EdgeInsetsDirectional.only(
                              top: 16.h,
                              end: 16.w,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: visibleItemCounts[index]!.clamp(0, 10),
                            separatorBuilder:
                                (context, index) => SizedBox(width: 8.w),
                            itemBuilder:
                                (context, index) => GestureDetector(
                                  onTap: () => _showVideoDialog(context, index),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: SizedBox(
                                      width: 90.w,
                                      height: 90.w,
                                      child: VideoPlayer(controllers[index]),
                                    ),
                                  ),
                                ),
                          )
                          : const VideosShimmerLoading(),
                ),
                if (visibleItemCounts[index]! < 10)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        int remainingItems =
                            10 - (visibleItemCounts[index] ?? 0);
                        visibleItemCounts[index] =
                            (visibleItemCounts[index] ?? 0) + remainingItems;
                      });
                    },
                    child: Text(
                      "عرض المزيد",
                      style: TextStyle(color: Colors.blue, fontSize: 16.sp),
                    ),
                  ),

                SizedBox(height: 16.h),
                VideosViews(index: index),
              ],
            ),
          ),
    );
  }
}
