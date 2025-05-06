import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/fonts.gen.dart';

class CustomAboutChild extends StatelessWidget {
  const CustomAboutChild({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      margin: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.r,
            spreadRadius: 1.r,
            offset: Offset(0, 5.r),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              AppText(
                text: 'اسم الطفل',
                family: FontFamily.lexendBold,
                size: 16.sp,
              ),
              const Spacer(),
              AppText(
                text: 'اسم الطفل',
                family: FontFamily.lexendBold,
                size: 16.sp,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          const Divider(color: Colors.grey),
          SizedBox(height: 8.h),

          Row(
            children: [
              AppText(
                text: 'مشكلة الطفل',
                family: FontFamily.lexendBold,
                size: 16.sp,
              ),
              const Spacer(),
              AppText(
                text: 'توحد',
                family: FontFamily.lexendBold,
                size: 16.sp,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          const Divider(color: Colors.grey),
          SizedBox(height: 8.h),

          Row(
            children: [
              AppText(text: 'السن', family: FontFamily.lexendBold, size: 16.sp),
              const Spacer(),
              AppText(
                text: '5 سنوات',
                family: FontFamily.lexendBold,
                size: 16.sp,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          const Divider(color: Colors.grey),
          SizedBox(height: 8.h),

          Row(
            children: [
              AppText(
                text: 'البريد الالكتروني',
                family: FontFamily.lexendBold,
                size: 16.sp,
              ),
              const Spacer(),
              AppText(
                text: 'mohamed@.com',
                family: FontFamily.lexendBold,
                size: 16.sp,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 8.h),

          const Divider(color: Colors.grey),
          SizedBox(height: 8.h),

          Row(
            children: [
              AppText(
                text: 'الهاتف',
                family: FontFamily.lexendBold,
                size: 16.sp,
              ),
              const Spacer(),
              AppText(
                text: '+2010123456789',
                family: FontFamily.lexendBold,
                size: 16.sp,
                color: Colors.lightBlueAccent,
              ),
            ],
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
