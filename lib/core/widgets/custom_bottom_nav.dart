import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hemtnaa/screens/child_screens/home_layout/home_layout.dart';
import '../../gen/assets.gen.dart';
import '../../generated/locale_keys.g.dart';
import '../service/cubit/app_cubit.dart';
import 'app_router.dart';
import 'app_text.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 32.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffF6F6F8),
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(24.r),
          topStart: Radius.circular(24.r),
        ),
        border: Border.all(color: const Color(0xffE3E3E3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              AppCubit.get(context).changebottomNavIndex(0);
              AppRouter.navigateAndFinish(context, const HomeLayout());
            },
            child: Column(
              children: [
                SvgPicture.asset(
                  Assets.svg.home,
                  height: 24.w,
                  width: 24.w,
                  color: const Color(0xffB8B8B8),
                ),
                AppText(
                  top: 3.h,
                  text: LocaleKeys.home.tr(),
                  size: 12.sp,
                  color: const Color(0xffB8B8B8),
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
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
                  color: const Color(0xffB8B8B8),
                ),
                AppText(
                  top: 3.h,
                  text: LocaleKeys.games.tr(),
                  size: 12.sp,
                  color: const Color(0xffB8B8B8),
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
                  color: const Color(0xffB8B8B8),
                ),
                AppText(
                  top: 3.h,
                  text: LocaleKeys.chats.tr(),
                  size: 12.sp,
                  color: const Color(0xffB8B8B8),
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
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
                  color: const Color(0xffB8B8B8),
                ),
                AppText(
                  top: 3.h,
                  text: LocaleKeys.activities.tr(),
                  size: 12.sp,
                  color: const Color(0xffB8B8B8),
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
