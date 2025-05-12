import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/core/widgets/app_router.dart';
import 'package:hemtnaa/core/widgets/app_text.dart';
import 'package:hemtnaa/screens/child_screens/home_layout/home_layout.dart';

import '../../../../../../../core/constants/colors.dart';
import '../../../../../../../gen/fonts.gen.dart';

class FocusGames extends StatefulWidget {
  const FocusGames({super.key});

  @override
  State<FocusGames> createState() => _FocusGamesState();
}

class _FocusGamesState extends State<FocusGames> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int currentPage = 0;
  bool isAnswerCorrect = false;

  late AnimationController _questionController;
  late Animation<Offset> _questionOffset;
  late AnimationController _answersController;

  @override
  void initState() {
    super.initState();

    _questionController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _questionOffset = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _questionController, curve: Curves.easeOut),
    );

    _answersController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _startAnimations();
  }

  void _startAnimations() {
    _questionController.forward(from: 0);
    _answersController.forward(from: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _questionController.dispose();
    _answersController.dispose();
    super.dispose();
  }

  void onAnswerSelected(int selectedId, int correctId) {
    if (selectedId == correctId) {
      setState(() {
        isAnswerCorrect = true;
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        if (currentPage < AppCubit.get(context).focusList.length - 1) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
          setState(() {
            currentPage++;
            isAnswerCorrect = false;
          });
          _startAnimations();
        } else {
          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  title: AppText(
                    text: "مبروك!",
                    size: 16.sp,
                    color: AppColors.primary,
                    family: FontFamily.lexendBold,
                  ),
                  content: AppText(
                    text: "لقد أكملت جميع الأسئلة بنجاح 🎉",
                    size: 14.sp,
                    color: AppColors.primary,
                    family: FontFamily.lexendBold,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        AppCubit.get(context).changebottomNavIndex(1);
                        AppRouter.navigateAndFinish(
                          context,
                          const HomeLayout(),
                        );
                      },
                      child: AppText(
                        text: "تجربة لعبة اخرى",
                        size: 12.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return PageView.builder(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: AppCubit.get(context).focusList.length,
          itemBuilder: (context, index) {
            final model = AppCubit.get(context).focusList[index];

            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xffAAD8FC), Color(0xffFCAADA)],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      margin: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        children: [
                          AppText(
                            text: 'لعبة التركيز',
                            size: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            top: 16.h,
                          ),
                          AppText(
                            text: 'اختر الشكل الذي يشبه الشكل المطلوب',
                            size: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                            top: 16.h,
                            bottom: 24.h,
                          ),
                          SlideTransition(
                            position: _questionOffset,
                            child: FadeTransition(
                              opacity: _questionController,
                              child: model.question,
                            ),
                          ),
                          SizedBox(height: 24.h),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12.h,
                                  crossAxisSpacing: 12.w,
                                ),
                            itemCount: model.answers.length,
                            itemBuilder: (context, i) {
                              final answer = model.answers[i];
                              return ScaleTransition(
                                scale: CurvedAnimation(
                                  parent: _answersController,
                                  curve: Interval(
                                    0.1 * i,
                                    1.0,
                                    curve: Curves.easeOutBack,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    onAnswerSelected(
                                      answer.id,
                                      model.correctAnswerId,
                                    );
                                  },
                                  child: answer.widget,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
