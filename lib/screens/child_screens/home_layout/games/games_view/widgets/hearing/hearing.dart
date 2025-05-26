import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/widgets/app_text.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Hearing extends StatefulWidget {
  const Hearing({super.key});

  @override
  State<Hearing> createState() => _HearingState();
}

class _HearingState extends State<Hearing> {
  final List<YoutubePlayerController> _controller = [];
  @override
  void initState() {
    for (int i = 0; i < 5; i++) {
      _controller.add(
        YoutubePlayerController(
          initialVideoId:
              'https://www.youtube.com/watch?v=VyFuDaiLdfc&list=RDVyFuDaiLdfc&start_radio=1',
          flags: const YoutubePlayerFlags(autoPlay: false),
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      child: PageView.builder(
        itemCount: _controller.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              AppText(
                text: 'اسمع الفيديو واختر الاجابه الصحيحه',
                size: 20.sp,
                fontWeight: FontWeight.bold,
                top: 40.h,
                bottom: 24.h,
              ),
              YoutubePlayer(controller: _controller[index]),
              AppText(
                text: 'ما الرقم الموجود في الفيديو',
                size: 20.sp,
                top: 24.h,
                bottom: 30.h,
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: AppText(
                          text: '${index + 1}',
                          size: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
