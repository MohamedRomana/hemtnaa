import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/cache/cache_helper.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/app_router.dart';
import '../../../core/widgets/app_text.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';
import '../../auth/views/login/login.dart';

class TypesView extends StatelessWidget {
  const TypesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              text: LocaleKeys.continue_as.tr(),
              size: 32.sp,
              color: AppColors.primary,
            ),
            AppText(
              text: LocaleKeys.you_are_now_registering_as.tr(),
              size: 16.sp,
              color: AppColors.primary,
              bottom: 16.h,
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                CacheHelper.setUserType('child');
                AppRouter.navigateAndFinish(context, const LogIn());
              },
              child: Container(
                height: 165.h,
                width: 136.w,
                padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    AppText(
                      bottom: 8.h,
                      text: LocaleKeys.continue_as.tr(),
                      size: 12.sp,
                      color: Colors.grey,
                    ),
                    Container(
                      height: 77.w,
                      width: 77.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(Assets.img.student.path),
                    ),
                    AppText(
                      top: 12.h,
                      text: LocaleKeys.child.tr(),
                      size: 16.sp,
                      color: const Color(0xff5E5E5E),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                CacheHelper.setUserType('senior');
                AppRouter.navigateAndFinish(context, const LogIn());
              },
              child: Container(
                height: 165.h,
                width: 136.w,
                padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 12.h),
                margin: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    AppText(
                      bottom: 8.h,
                      text: LocaleKeys.continue_as.tr(),
                      size: 12.sp,
                      color: Colors.grey,
                    ),
                    Container(
                      height: 77.w,
                      width: 77.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(Assets.img.senior.path),
                    ),
                    AppText(
                      top: 12.h,
                      text: LocaleKeys.senior.tr(),
                      size: 16.sp,
                      color: const Color(0xff5E5E5E),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                CacheHelper.setUserType('doctor');
                AppRouter.navigateAndFinish(context, const LogIn());
              },
              child: Container(
                height: 165.h,
                width: 136.w,
                padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    AppText(
                      bottom: 8.h,
                      text: LocaleKeys.continue_as.tr(),
                      size: 12.sp,
                      color: Colors.grey,
                    ),
                    Container(
                      height: 77.w,
                      width: 77.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(Assets.img.doctor.path),
                    ),
                    AppText(
                      top: 12.h,
                      text: LocaleKeys.doctor.tr(),
                      size: 16.sp,
                      color: const Color(0xff5E5E5E),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
