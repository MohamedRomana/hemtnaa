import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/widgets/app_router.dart';
import '../../../../../../../core/constants/colors.dart';
import '../../../../../../../core/widgets/app_text.dart';
import 'widgets/memory_easy.dart';
import 'widgets/memory_hard.dart';
import 'widgets/memory_medium.dart';

class MemoryGame extends StatelessWidget {
  const MemoryGame({super.key});

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 300.w,
            width: 300.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              children: [
                Container(
                  height: 60.h,
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
                          text: 'اختر المستوى',
                          size: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        AppText(
                          text: 'ابدأ المغامره حسب مستواك',
                          size: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    AppRouter.navigateTo(context, const MemoryEasy());
                  },
                  child: Container(
                    height: 45.h,
                    width: 95.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Center(
                      child: AppText(
                        text: 'سهل',
                        size: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    AppRouter.navigateTo(context, const MemoryMedium());
                  },
                  child: Container(
                    height: 45.h,
                    width: 95.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(200),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Center(
                      child: AppText(
                        text: 'متوسط',
                        size: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    AppRouter.navigateTo(context, const MemoryHard());
                  },
                  child: Container(
                    height: 45.h,
                    width: 95.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(100),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Center(
                      child: AppText(
                        text: 'صعب',
                        size: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
