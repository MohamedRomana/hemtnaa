import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/core/widgets/app_router.dart';
import 'package:hemtnaa/screens/child_screens/home_layout/games/games_view/games_view.dart';
import 'package:hemtnaa/screens/child_screens/home_layout/games/games_view/widgets/puzzle_games/widgets/puzzle_easy.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/login_first.dart';
import '../../../../gen/assets.gen.dart';

class Games extends StatefulWidget {
  const Games({super.key});

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor:
              CacheHelper.getUserToken() == ""
                  ? Colors.white
                  : AppColors.primary,
          body:
              CacheHelper.getUserToken() == ""
                  ? const LoginFirst()
                  : SingleChildScrollView(
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
                          separatorBuilder:
                              (context, index) => SizedBox(height: 16.h),
                          itemBuilder:
                              (context, index) => AnimatedBuilder(
                                animation: _controller,
                                builder:
                                    (context, child) => Container(
                                      width: 343.w,
                                      height: 230.h,
                                      padding: EdgeInsets.all(16.r),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: const [
                                            Colors.black,
                                            AppColors.primary,
                                            Colors.black,
                                          ],
                                          begin: Alignment(
                                            -1 + 2 * _controller.value,
                                            -1,
                                          ),
                                          end: Alignment(
                                            1 - 2 * _controller.value,
                                            1,
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primary
                                                .withOpacity(0.4),
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
                                            start: -60.w,
                                            top: 30.h,
                                            child: Transform.rotate(
                                              angle: 0.2,
                                              child: Image.asset(
                                                AppCubit.get(
                                                  context,
                                                ).games[index].image,
                                                height: 150.w,
                                                width: 150.w,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          PositionedDirectional(
                                            start: 100.w,
                                            top: 10.h,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppText(
                                                  text:
                                                      AppCubit.get(
                                                        context,
                                                      ).games[index].title,
                                                  size:
                                                      index == 5
                                                          ? 20.sp
                                                          : 26.sp,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  bottom: 10.h,
                                                ),
                                                SizedBox(
                                                  width: 180.w,
                                                  child: AppText(
                                                    text:
                                                        AppCubit.get(context)
                                                            .games[index]
                                                            .description,
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
                                            child: ShaderMask(
                                              shaderCallback: (bounds) {
                                                return LinearGradient(
                                                  colors: [
                                                    Colors.white.withAlpha(200),
                                                    Colors.white,
                                                    Colors.white.withAlpha(200),
                                                  ],
                                                  begin: Alignment.centerRight,
                                                  end: Alignment.centerLeft,
                                                  stops: [
                                                    0.0,
                                                    _controller.value,
                                                    1.0,
                                                  ],
                                                ).createShader(
                                                  Rect.fromLTWH(
                                                    0,
                                                    0,
                                                    bounds.width,
                                                    bounds.height,
                                                  ),
                                                );
                                              },
                                              blendMode: BlendMode.srcATop,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  // backgroundColor: Colors.white
                                                  //     .withAlpha(150),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8.r,
                                                        ),
                                                  ),
                                                  fixedSize: Size(115.w, 30.h),
                                                  side: const BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  AppRouter.navigateTo(
                                                    context,
                                                    GamesView(index: index),
                                                  );
                                                },
                                                child: AppText(
                                                  text:
                                                      AppCubit.get(
                                                        context,
                                                      ).games[index].button,
                                                  size:
                                                      index == 4
                                                          ? 12.sp
                                                          : index == 5
                                                          ? 11.sp
                                                          : 14.sp,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              ),
                        ),
                        AnimatedBuilder(
                          animation: _controller,
                          builder:
                              (context, child) => Container(
                                height: 300.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: const [
                                      AppColors.primary,
                                      Color.fromARGB(255, 215, 223, 255),
                                    ],
                                    begin: Alignment(
                                      -1 + 2 * _controller.value,
                                      -1,
                                    ),
                                    end: Alignment(
                                      1 - 2 * _controller.value,
                                      1,
                                    ),
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
                                    FutureBuilder<int>(
                                      future: CacheScore.getStoredScore(),

                                      builder: (context, asyncSnapshot) {
                                        int storedScore =
                                            asyncSnapshot.data ?? 0;
                                        double percent = (storedScore / 100)
                                            .clamp(0.0, 1.0);
                                        return CircularPercentIndicator(
                                          radius: 70.0,
                                          lineWidth: 10.0,
                                          percent: percent,
                                          center: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                Assets.img.score.path,
                                                height: 50.w,
                                                width: 50.w,
                                                fit: BoxFit.fill,
                                              ),
                                              SizedBox(height: 8.h),
                                              AppText(
                                                text: "$storedScore%",
                                                fontWeight: FontWeight.bold,
                                                size: 16.sp,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                          progressColor: const Color(
                                            0xff24B600,
                                          ),
                                          backgroundColor: Colors.grey[300]!,
                                          circularStrokeCap:
                                              CircularStrokeCap.round,
                                          animation: true,
                                          animationDuration: 1000,
                                        );
                                      },
                                    ),
                                  ],
                                ),
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
