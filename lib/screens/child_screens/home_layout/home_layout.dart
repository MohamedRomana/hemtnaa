import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hemtnaa/core/service/cubit/app_cubit.dart';
import 'package:hemtnaa/core/widgets/app_text.dart';
import 'package:hemtnaa/generated/locale_keys.g.dart';
import '../../../core/constants/colors.dart';
import '../../../gen/assets.gen.dart';

class HomeLayout extends StatefulWidget {
  final bool? isGame;
  const HomeLayout({super.key, this.isGame});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation2;
  late Animation<double> _animation3;
  late Animation<double> _animation4;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _animation = Tween<double>(
      begin: 40.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _animation2 = Tween<double>(
      begin: 40.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _animation3 = Tween<double>(
      begin: -40.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _animation4 = Tween<double>(
      begin: -40.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(const Duration(milliseconds: 50), () {
      _controller.forward();
    });
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
        return WillPopScope(
          onWillPop: () async {
            bool? shouldPop = await showDialog<bool>(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: Text(
                      LocaleKeys.doYouWantToLeaveThisApp.tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: Text(
                      LocaleKeys.areYouSure.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => SystemNavigator.pop(),
                        child: Text(LocaleKeys.yes.tr()),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(LocaleKeys.no.tr()),
                      ),
                    ],
                  ),
            );
            return shouldPop ?? false;
          },
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            resizeToAvoidBottomInset: false,
            extendBody: true,
            floatingActionButton: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                AppCubit.get(context).changebottomNavIndex(2);
              },
              child: Container(
                height: 65.w,
                width: 65.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      AppCubit.get(context).bottomNavIndex == 0
                          ? Colors.black.withAlpha(100)
                          : AppColors.primary,
                ),
                child: Center(
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _animation.value),
                        child: child,
                      );
                    },
                    child: SvgPicture.asset(
                      Assets.svg.home,
                      height: 25.w,
                      width: 25.w,
                      color: Colors.white,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              elevation: 5,
              notchMargin: 13.r,
              clipBehavior: Clip.antiAlias,
              color:
                  AppCubit.get(context).bottomNavIndex == 0
                      ? Colors.black.withAlpha(100)
                      : AppColors.primary,
              shape: const CircularNotchedRectangle(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(_animation2.value, 0),
                        child: child,
                      );
                    },
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        AppCubit.get(context).changebottomNavIndex(0);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            Assets.svg.games,
                            height: 24.w,
                            width: 24.w,
                            color:
                                AppCubit.get(context).bottomNavIndex == 0
                                    ? AppColors.borderColor
                                    : Colors.white,
                          ),
                          AppText(
                            top: 3.h,
                            text: LocaleKeys.games.tr(),
                            size: 12.sp,
                            color:
                                AppCubit.get(context).bottomNavIndex == 0
                                    ? AppColors.borderColor
                                    : Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(_animation3.value, 0),
                        child: child,
                      );
                    },
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        AppCubit.get(context).changebottomNavIndex(1);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            Assets.svg.chats,
                            height: 24.w,
                            width: 24.w,
                            color:
                                AppCubit.get(context).bottomNavIndex == 1
                                    ? AppColors.borderColor
                                    : Colors.white,
                          ),
                          AppText(
                            top: 3.h,
                            text: LocaleKeys.chats.tr(),
                            size: 12.sp,
                            color:
                                AppCubit.get(context).bottomNavIndex == 1
                                    ? AppColors.borderColor
                                    : Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(),
                  const SizedBox(),
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(_animation4.value, 0),
                        child: child,
                      );
                    },
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        AppCubit.get(context).changebottomNavIndex(3);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            Assets.svg.activities,
                            height: 24.w,
                            width: 24.w,
                            color:
                                AppCubit.get(context).bottomNavIndex == 3
                                    ? AppColors.borderColor
                                    : Colors.white,
                          ),
                          AppText(
                            top: 3.h,
                            text: LocaleKeys.activities.tr(),
                            size: 12.sp,
                            color:
                                AppCubit.get(context).bottomNavIndex == 3
                                    ? AppColors.borderColor
                                    : Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(_animation.value, 0),
                        child: child,
                      );
                    },
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        AppCubit.get(context).changebottomNavIndex(4);
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.emergency,
                            color:
                                AppCubit.get(context).bottomNavIndex == 4
                                    ? AppColors.borderColor
                                    : Colors.white,
                          ),
                          AppText(
                            top: 3.h,
                            text: 'دكتور',
                            size: 12.sp,
                            color:
                                AppCubit.get(context).bottomNavIndex == 4
                                    ? AppColors.borderColor
                                    : Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body:
                AppCubit.get(context).bottomNavScreens[AppCubit.get(
                  context,
                ).bottomNavIndex],
          ),
        );
      },
    );
  }
}
