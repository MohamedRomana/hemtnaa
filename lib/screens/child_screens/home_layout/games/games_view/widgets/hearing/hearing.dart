import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../../../../../core/constants/colors.dart';
import '../../../../../../../core/service/models/hearing_model.dart';

class Hearing extends StatefulWidget {
  const Hearing({super.key});

  @override
  State<Hearing> createState() => _HearingState();
}

class _HearingState extends State<Hearing> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _controller;
  late List<VideoPlayerController> _videoControllers;

  int _currentPage = 0;
  int _score = 0;
  bool _answered = false;
  int? _selectedIndex;

  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _fadeAnimations;

  final List<HearingModel> _hearing = [
    // HearingModel(
    //   videoUrl: Assets.video.a0,
    //   questions: ['0', '1', '2', '3'],
    //   answers: '0',
    // ),

    // HearingModel(
    //   videoUrl: Assets.video.ananas,
    //   questions: ['اناناس', 'تفاح', 'موز', 'خوخ'],
    //   answers: 'اناناس',
    // ),

    // HearingModel(
    //   videoUrl: Assets.video.bus,
    //   questions: ['سياره', 'تاكسي', 'قطار', 'اتوبيس'],
    //   answers: 'اتوبيس',
    // ),

    // HearingModel(
    //   videoUrl: Assets.video.horse,
    //   questions: ['اسد', 'نمر', 'فيل', 'حصان'],
    //   answers: 'حصان',
    // ),

    // HearingModel(
    //   videoUrl: Assets.video.iceCream,
    //   questions: ['ايس كريم', 'خيار', 'ارز', 'طماطم'],
    //   answers: 'ايس كريم',
    // ),

    // HearingModel(
    //   videoUrl: Assets.video.red,
    //   questions: ['اخضر', 'ازرق', 'ابيض', 'احمر'],
    //   answers: 'احمر',
    // ),
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _videoControllers =
        _hearing.map((item) {
          final controller = VideoPlayerController.asset(item.videoUrl)
            ..setLooping(true);
          controller.initialize().then((_) {
            controller.play();
            controller.setLooping(true);
            setState(() {});
          });
          return controller;
        }).toList();

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

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    for (final vc in _videoControllers) {
      vc.dispose();
    }
    super.dispose();
  }

  Color _optionColor(int index) {
    if (!_answered) return AppColors.primary;
    final correctAnswer = _hearing[_currentPage].answers;
    final selectedAnswer = _hearing[_currentPage].questions[index];
    if (selectedAnswer == correctAnswer) {
      return Colors.green;
    } else if (index == _selectedIndex) {
      return Colors.red;
    } else {
      return AppColors.primary;
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("انتهيت!"),
            content: Text("درجتك: $_score من ${_hearing.length * 10}"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("حسناً"),
              ),
            ],
          ),
    );
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
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: _hearing.length,
        itemBuilder: (context, index) {
          final item = _hearing[index];
          final videoController = _videoControllers[index];

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'استمع إلى الفيديو ثم اختر الإجابة الصحيحة',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                if (videoController.value.isInitialized)
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: videoController.value.aspectRatio,
                        child: VideoPlayer(videoController),
                      ),
                    ],
                  )
                else
                  const CircularProgressIndicator(),

                const SizedBox(height: 20),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: item.questions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder:
                      (context, qIndex) => FadeTransition(
                        opacity: _fadeAnimations[qIndex],
                        child: SlideTransition(
                          position: _slideAnimations[qIndex],
                          child: InkWell(
                            onTap:
                                _answered
                                    ? null
                                    : () {
                                      setState(() {
                                        _selectedIndex = qIndex;
                                        _answered = true;

                                        final correct = item.answers;
                                        final selected = item.questions[qIndex];
                                        if (selected == correct) {
                                          _score += 10;
                                        }
                                      });

                                      Future.delayed(
                                        const Duration(seconds: 1),
                                        () {
                                          if (_currentPage ==
                                              _hearing.length - 1) {
                                            _showResultDialog();
                                          } else {
                                            setState(() {
                                              _answered = false;
                                              _selectedIndex = null;
                                              _currentPage++;
                                            });

                                            _pageController.nextPage(
                                              duration: const Duration(
                                                milliseconds: 500,
                                              ),
                                              curve: Curves.easeInOut,
                                            );
                                          }
                                        },
                                      );
                                    },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 80,
                              ),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: _optionColor(qIndex),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  item.questions[qIndex],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
