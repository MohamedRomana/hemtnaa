import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/widgets/app_text.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../../../core/constants/colors.dart';
import '../../../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../../../core/widgets/app_router.dart';

class Hearing extends StatefulWidget {
  const Hearing({super.key});

  @override
  State<Hearing> createState() => _HearingState();
}

class _HearingState extends State<Hearing> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _controller;

  // Animations for options
  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _fadeAnimations;

  // Animations for title, score, and question
  late Animation<double> _titleFade;
  late Animation<Offset> _titleSlide;
  late Animation<double> _scoreCounter;
  late Animation<double> _questionFade;
  late Animation<Offset> _hearinglide;

  int _currentPage = 0;
  int _score = 0;
  bool _answered = false;
  int? _selectedIndex;
  final List<YoutubePlayerController> _controller2 = [];
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    for (int i = 0; i < AppCubit.get(context).hearing.length; i++) {
      final fullUrl = AppCubit.get(context).hearing[i].quistion;
      final videoId = YoutubePlayer.convertUrlToId(fullUrl);

      if (videoId != null) {
        _controller2.add(
          YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(autoPlay: true),
          ),
        );
      } else {
        debugPrint("Invalid YouTube URL: $fullUrl");
      }
    }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Title animation
    _titleFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.2)),
    );
    _titleSlide = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.2)),
    );

    // Score counter animation
    _scoreCounter = Tween<double>(begin: 10, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.1, 0.3)),
    );

    // Question animation
    _questionFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.4)),
    );
    _hearinglide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.4)),
    );

    // Option animations
    _slideAnimations = List.generate(4, (index) {
      final start = 0.4 + index * 0.1;
      final end = start + 0.3;
      return Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      );
    });

    _fadeAnimations = List.generate(4, (index) {
      final start = 0.4 + index * 0.1;
      final end = start + 0.3;
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeIn),
        ),
      );
    });

    _pageController.addListener(() {
      final page = _pageController.page?.round();
      if (page != _currentPage) {
        setState(() {
          _currentPage = page!;
          _controller.forward(from: 0);
        });
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Color? _optionColor(int index) {
    if (!_answered) return AppColors.primary;
    final correctAnswer =
        AppCubit.get(context).hearing[_currentPage].correctAnswer;
    final selectedAnswer =
        AppCubit.get(context).hearing[_currentPage].answers[index];
    if (selectedAnswer == correctAnswer) {
      return Colors.green;
    } else if (index == _selectedIndex) {
      return Colors.red;
    } else {
      return AppColors.primary;
    }
  }

  void _showCorrectAnswerPopup() {
    if (_currentPage == AppCubit.get(context).hearing.length - 1) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("مبروك!"),
            content: const Text("لقد أجبت إجابة صحيحة في السؤال الأخير."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  AppRouter.pop(context);
                },
                child: const Text("حسناً"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemCount: AppCubit.get(context).hearing.length,
          itemBuilder: (context, index) {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.r),
                    width: 300.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withAlpha(150),
                          spreadRadius: 1.r,
                          blurRadius: 5.r,
                          offset: Offset(0, 5.r),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        FadeTransition(
                          opacity: _titleFade,
                          child: SlideTransition(
                            position: _titleSlide,
                            child: AppText(
                              top: 30.h,
                              text: 'لعبة السمعيات',
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffFCAADA),
                            ),
                          ),
                        ),

                        AnimatedBuilder(
                          animation: _scoreCounter,
                          builder: (context, child) {
                            return AppText(
                              top: 30.h,
                              text: 'النقاط : $_score',
                              size: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffAAD8FC),
                            );
                          },
                        ),

                        FadeTransition(
                          opacity: _questionFade,
                          child: SlideTransition(
                            position: _hearinglide,
                            child: Container(
                              height: 200.h,
                              width: 300.w,
                              margin: EdgeInsetsDirectional.only(top: 30.h),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xffAAD8FC),
                                    Color(0xffFCAADA),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: YoutubePlayer(
                                  controller: _controller2[index],
                                  showVideoProgressIndicator: true,
                                  progressIndicatorColor: Colors.red,

                                  progressColors: const ProgressBarColors(
                                    playedColor: Colors.red,
                                    handleColor: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        FadeTransition(
                          opacity: _titleFade,
                          child: SlideTransition(
                            position: _titleSlide,
                            child: AppText(
                              top: 10.h,
                              text:
                                  AppCubit.get(
                                    context,
                                  ).hearing[_currentPage].quistionText,
                              size: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffAAD8FC),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          itemCount: 4,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder:
                              (context, index) => SizedBox(height: 10.w),
                          itemBuilder:
                              (context, index) => FadeTransition(
                                opacity: _fadeAnimations[index],
                                child: SlideTransition(
                                  position: _slideAnimations[index],
                                  child: InkWell(
                                    onTap:
                                        _answered
                                            ? null
                                            : () {
                                              setState(() {
                                                _selectedIndex = index;
                                                _answered = true;

                                                final correctAnswer =
                                                    AppCubit.get(context)
                                                        .hearing[_currentPage]
                                                        .correctAnswer;
                                                final selectedAnswer =
                                                    AppCubit.get(context)
                                                        .hearing[_currentPage]
                                                        .answers[index];

                                                if (selectedAnswer ==
                                                    correctAnswer) {
                                                  _score += 10;
                                                }
                                              });

                                              if (_answered &&
                                                  _currentPage ==
                                                      AppCubit.get(
                                                            context,
                                                          ).hearing.length -
                                                          1) {
                                                _showCorrectAnswerPopup();
                                              }

                                              Future.delayed(
                                                const Duration(seconds: 1),
                                                () {
                                                  if (_currentPage <
                                                      AppCubit.get(
                                                            context,
                                                          ).hearing.length -
                                                          1) {
                                                    setState(() {
                                                      _currentPage++;
                                                      _selectedIndex = null;
                                                      _answered = false;
                                                    });

                                                    _pageController
                                                        .animateToPage(
                                                          _currentPage,
                                                          duration:
                                                              const Duration(
                                                                milliseconds:
                                                                    300,
                                                              ),
                                                          curve:
                                                              Curves.easeInOut,
                                                        );
                                                  }
                                                },
                                              );
                                            },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 80.w,
                                      ),
                                      height: 45.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        color: _optionColor(index),
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      child: Center(
                                        child: AppText(
                                          text:
                                              AppCubit.get(context)
                                                  .hearing[_currentPage]
                                                  .answers[index],
                                          size: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
