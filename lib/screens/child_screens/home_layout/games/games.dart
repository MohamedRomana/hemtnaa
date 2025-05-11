import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/core/widgets/app_router.dart';
import 'package:hemtnaa/screens/child_screens/home_layout/games/games_view/games_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';

class Games extends StatelessWidget {
  const Games({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.primary,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                ListView.separated(
                  padding: EdgeInsetsDirectional.only(
                    start: 36.w,
                    end: 36.w,
                    top: 320.h,
                    bottom: 124.h,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: AppCubit.get(context).games.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder:
                      (context, index) => Container(
                        width: 343.w,
                        height: 230.h,
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.black,
                              AppColors.primary,
                              Colors.black,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.4),
                              spreadRadius: 1.r,
                              blurRadius: 5.r,
                              offset: Offset(0, 5.r),
                            ),
                          ],
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            PositionedDirectional(
                              start: -70.w,
                              top: 30.h,
                              child: Transform.rotate(
                                angle: 0.2,
                                child: Image.asset(
                                  AppCubit.get(context).games[index].image,
                                  height: 160.w,
                                  width: 160.w,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            PositionedDirectional(
                              start: 100.w,
                              top: 10.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    text:
                                        AppCubit.get(
                                          context,
                                        ).games[index].title,
                                    size: 26.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    bottom: 10.h,
                                  ),
                                  SizedBox(
                                    width: 180.w,
                                    child: AppText(
                                      text:
                                          AppCubit.get(
                                            context,
                                          ).games[index].description,
                                      size: 12.sp,
                                      lines: 5,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PositionedDirectional(
                              end: 16.w,
                              bottom: -10.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white.withAlpha(150),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  fixedSize: Size(115.w, 30.h),
                                  side: const BorderSide(color: Colors.white),
                                ),
                                onPressed: () {
                                  AppRouter.navigateTo(
                                    context,
                                    GamesView(index: index),
                                  );
                                },
                                child: AppText(
                                  text:
                                      AppCubit.get(context).games[index].button,
                                  size: 14.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                ),
                Container(
                  height: 300.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.primary,
                        Color.fromARGB(255, 215, 223, 255),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(1050.r),
                      bottomRight: Radius.circular(1050.r),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        text: 'الهدف',
                        size: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        bottom: 16.h,
                      ),
                      CircularPercentIndicator(
                        radius: 70.0,
                        lineWidth: 10.0,
                        percent: 70 / 100,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Assets.img.score.path,
                              height: 50.w,
                              width: 50.w,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(height: 8.h),
                            AppText(
                              text: "70%",
                              fontWeight: FontWeight.bold,
                              size: 16.sp,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        progressColor: const Color(0xff24B600),
                        backgroundColor: Colors.grey[300]!,
                        circularStrokeCap: CircularStrokeCap.round,
                        animation: true,
                        animationDuration: 1000,
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
  }
}
