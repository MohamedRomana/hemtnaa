import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../gen/assets.gen.dart';
import '../../generated/locale_keys.g.dart';
import '../../screens/child_screens/home_layout/home_layout.dart';
import '../constants/colors.dart';
import '../service/cubit/app_cubit.dart';
import 'app_router.dart';
import 'app_text.dart';

class CustomBottomNav extends StatelessWidget {
  final Widget? body;
  const CustomBottomNav({super.key, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      floatingActionButton: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          AppCubit.get(context).changebottomNavIndex(0);
          AppRouter.navigateAndFinish(context, const HomeLayout());
        },
        child: Container(
          height: 65.w,
          width: 65.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
          ),
          child: Center(
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
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        notchMargin: 13.r,
        clipBehavior: Clip.antiAlias,
        color: AppColors.primary,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                AppCubit.get(context).changebottomNavIndex(1);
                AppRouter.navigateAndFinish(context, const HomeLayout());
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    Assets.svg.games,
                    height: 24.w,
                    width: 24.w,
                    color:
                        AppCubit.get(context).bottomNavIndex == 1
                            ? AppColors.borderColor
                            : Colors.white,
                  ),
                  AppText(
                    top: 3.h,
                    text: LocaleKeys.games.tr(),
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
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                AppCubit.get(context).changebottomNavIndex(2);
                AppRouter.navigateAndFinish(context, const HomeLayout());
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    Assets.svg.chats,
                    height: 24.w,
                    width: 24.w,
                    color:
                        AppCubit.get(context).bottomNavIndex == 2
                            ? AppColors.borderColor
                            : Colors.white,
                  ),
                  AppText(
                    top: 3.h,
                    text: LocaleKeys.chats.tr(),
                    size: 12.sp,
                    color:
                        AppCubit.get(context).bottomNavIndex == 2
                            ? AppColors.borderColor
                            : Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            const SizedBox(),
            const SizedBox(),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                AppCubit.get(context).changebottomNavIndex(3);
                AppRouter.navigateAndFinish(context, const HomeLayout());
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
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                AppCubit.get(context).changebottomNavIndex(4);
                AppRouter.navigateAndFinish(context, const HomeLayout());
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
          ],
        ),
      ),
    );
  }
}
