import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/core/widgets/app_router.dart';
import '../../../../../../../../core/constants/colors.dart';
import '../../../../../../../../core/widgets/app_text.dart';
import '../../../../../../../../gen/assets.gen.dart';
import '../../../../../../../../gen/fonts.gen.dart';
import '../../../../../home_layout.dart';

class MemoryHard extends StatefulWidget {
  const MemoryHard({super.key});

  @override
  State<MemoryHard> createState() => _MemoryHardState();
}

class _MemoryHardState extends State<MemoryHard> {
  late ConfettiController _confettiController;
  int points = 0;
  List<String> images = [
    Assets.img.lion.path,
    Assets.img.apple.path,
    Assets.img.logoBrain.path,
    Assets.img.logoMystery.path,
    Assets.img.logoPuzzle.path,
    Assets.img.logoShapes.path,
    Assets.img.puzzle.path,
    Assets.img.shapes.path,
    Assets.img.brain.path,
    Assets.img.mystery.path,
    Assets.img.man.path,
    Assets.img.doctor.path,
  ];

  late List<String> cards;
  List<bool> revealed = List<bool>.filled(24, false);
  List<GlobalKey<FlipCardState>> cardKeys = List.generate(
    24,
    (_) => GlobalKey<FlipCardState>(),
  );

  int? firstIndex;
  int? secondIndex;

  @override
  void initState() {
    super.initState();
    cards = [...images, ...images];
    cards.shuffle(Random());
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }

  void onCardTapped(int index) {
    if (revealed[index] || secondIndex != null) return;

    cardKeys[index].currentState?.toggleCard();

    if (firstIndex == null) {
      firstIndex = index;
    } else {
      secondIndex = index;
      Future.delayed(const Duration(milliseconds: 800), () {
        checkMatch();
      });
    }
  }

  void checkMatch() {
    if (cards[firstIndex!] == cards[secondIndex!]) {
      setState(() {
        revealed[firstIndex!] = true;
        revealed[secondIndex!] = true;
      });

      if (revealed.every((e) => e)) {
        setState(() {
          points = 20;
        });

        _confettiController.play();

        Future.delayed(const Duration(milliseconds: 500), () {
          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  backgroundColor: Colors.white,
                  title: AppText(
                    text: "مبروك!",
                    size: 16.sp,
                    color: AppColors.primary,
                    family: FontFamily.lexendBold,
                  ),
                  content: AppText(
                    text: "لقد أنهيت اللعبة بنجاح 🎉",
                    size: 14.sp,
                    color: AppColors.primary,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        AppCubit.get(context).changebottomNavIndex(1);
                        AppRouter.navigateTo(context, const HomeLayout());
                      },
                      child: AppText(
                        text: "تجربة لعبة اخرى",
                        size: 14.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
          );
        });
      }

      firstIndex = null;
      secondIndex = null;
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        cardKeys[firstIndex!].currentState!.toggleCard();
        cardKeys[secondIndex!].currentState!.toggleCard();
        setState(() {
          revealed[firstIndex!] = false;
          revealed[secondIndex!] = false;
        });
        firstIndex = null;
        secondIndex = null;
      });
    }
  }

  void resetGame() {
    setState(() {
      cards = [...images, ...images];
      cards.shuffle(Random());
      revealed = List<bool>.filled(24, false);
      cardKeys = List.generate(24, (_) => GlobalKey<FlipCardState>());
      firstIndex = null;
      secondIndex = null;
      points = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xffAAD8FC), Color(0xffFCAADA)],
              ),
            ),
          ),
          Center(
            child: Container(
              height: 700.h,
              width: double.infinity,
              margin: EdgeInsetsDirectional.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  Container(
                    height: 80.h,
                    padding: EdgeInsets.all(8.r),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          AppText(
                            text: 'لعبة الذاكره',
                            size: 20.sp,
                            bottom: 8.h,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          AppText(
                            text: 'اضغط على الكروت لتكشف الازواج المتشابهه',
                            size: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                    itemCount: 24,
                    itemBuilder: (context, index) {
                      return FlipCard(
                        key: cardKeys[index],
                        flipOnTouch: !revealed[index],
                        direction: FlipDirection.HORIZONTAL,
                        front: GestureDetector(
                          onTap: () => onCardTapped(index),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.black,
                                  Colors.blue,
                                  Colors.black,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.help_outline,
                              color: Colors.red,
                              size: 25,
                            ),
                          ),
                        ),
                        back: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage(cards[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  AppText(text: "النقاط : $points", size: 20.sp),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 3,
              emissionFrequency: 0.05,
              numberOfParticles: 300,
              maxBlastForce: 20,
              minBlastForce: 5,
              shouldLoop: false,
              colors: const [
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.purple,
                Colors.orange,
                Colors.pink,
                Colors.teal,
                Colors.yellow,
                Colors.cyan,
                Colors.amber,
                Colors.brown,
                Colors.indigo,
                Colors.lime,
                Colors.deepOrange,
                Colors.deepPurple,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
