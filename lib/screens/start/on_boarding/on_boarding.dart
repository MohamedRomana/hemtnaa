// ignore_for_file: deprecated_member_use
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/cache/cache_helper.dart';
import '../../../core/constants/colors.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_text.dart';
import '../../../gen/assets.gen.dart';
import 'widgets/on_boarding_buttons.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  double currPage = 0.0;
  PageController pageController = PageController(initialPage: 0);
  List pagesList = [
    {"image1": Assets.img.onboarding.path},
    {"image1": Assets.img.onboarding.path},
    {"image1": Assets.img.onboarding.path},
  ];

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).intro();
    pageController = PageController(initialPage: 0)..addListener(() {
      setState(() {
        currPage = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          body:
          // state is GetIntroLoading
          //     ? const Center(
          //       child: CircularProgressIndicator(color: AppColors.primary),
          //     )
          //     :
          Stack(
            children: [
              PageView.builder(
                controller: pageController,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        height: 434.h,
                        width: double.infinity,
                        color: AppColors.primary,
                      ),
                      PositionedDirectional(
                        start: CacheHelper.getLang() == "ar" ? 0.w : null,
                        end: CacheHelper.getLang() == "en" ? 0.w : null,
                        top: 150.h,
                        child: Image.asset(
                          pagesList[index]['image1'],
                          height: 313.h,
                          width: 300.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      PositionedDirectional(
                        bottom: 160.h,
                        start: 37.w,
                        end: 37.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppText(
                              textAlign: TextAlign.center,
                              top: 48.h,
                              bottom: 20.h,
                              text: ' إلى كل طفل يواجه صعوبة في النطق',
                              lines: 2,
                              size: 30.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            AppText(
                              textAlign: TextAlign.center,
                              text:
                                  '*"إلى كل طفل يواجه صعوبة في النطق، أنت بطل يخطو خطوة جديدة كل يوم   لأولياء الأمور والمعلمين: صعوبات النطق لا تعني نهاية ا',
                              lines: 4,
                              size: 14.sp,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      PositionedDirectional(
                        start: -30.w,
                        top: -30.h,
                        child: Container(
                          height: 116.w,
                          width: 116.w,
                          decoration: const BoxDecoration(
                            color: AppColors.secondray,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      CustomOnBoardingButtons(
                        pagesList: pagesList,
                        currPage: currPage,
                        pageController: pageController,
                      ),
                    ],
                  );
                },
              ),
              PositionedDirectional(
                end: 100.w,
                start: 100.w,
                bottom: 100.h,
                child: DotsIndicator(
                  dotsCount: pagesList.length,
                  position: currPage,
                  decorator: DotsDecorator(
                    activeColor: AppColors.primary,
                    color: const Color(0xff878787).withOpacity(0.3),
                    size: Size.square(12.r),
                    activeSize: Size(20.w, 12.h),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
