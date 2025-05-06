import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/widgets/app_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../profile_edit/profile_edit.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            spreadRadius: 1.r,
            blurRadius: 5.r,
            offset: Offset(0, 5.r),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: Image.asset(
              Assets.img.doctor2.path,
              height: 105.w,
              width: 105.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: 200.w,
            child: AppText(
              text: 'احمد علي عبد الحميد',
              size: 24.sp,
              color: const Color(0xff434343),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 200.w,
            child: AppText(
              text: 'طفل',
              bottom: 24.h,
              size: 14.sp,
              color: const Color(0xff434343),
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 44.h,
            child: AppButton(
              onPressed: () {
                AppRouter.navigateTo(context, const ProfileEdit());
              },
              width: 312.w,
              radius: 8.r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.edit, color: Colors.white),
                  AppText(
                    start: 5.w,
                    text: 'تعديل الحساب',
                    color: Colors.white,
                    size: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 22.h),
          Divider(color: const Color(0xffE0E0E0), thickness: 1.5.h),
          SizedBox(height: 22.h),
          Row(
            children: [
              AppText(
                text: 'المعلومات الشخصية',
                color: AppColors.orange,
                size: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              AppText(
                start: 24.w,
                text: 'احمد علي عبد الحميد',
                color: const Color(0xff5E5E5E),
                size: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
