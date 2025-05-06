import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';
import '../../../../gen/fonts.gen.dart';

class CustomAboutDoctor extends StatelessWidget {
  const CustomAboutDoctor({super.key});

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
                text: 'اسم الدكتور',
                family: FontFamily.lexendBold,
                size: 16.sp,
              ),
              const Spacer(),
              AppText(
                text: 'د/محمد احمد',
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
                text: 'تخصص الدكتور',
                family: FontFamily.lexendBold,
                size: 16.sp,
              ),
              const Spacer(),
              AppText(
                text: 'طب الاطفال',
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
                text: 'المدينه',
                family: FontFamily.lexendBold,
                size: 16.sp,
              ),
              const Spacer(),
              AppText(
                text: 'الدقهليه',
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
          const Divider(color: Colors.grey),
          SizedBox(height: 8.h),

          Row(
            children: [
              AppText(
                text: 'خدمة 24 ساعه / 7 ايام',
                family: FontFamily.lexendBold,
                size: 16.sp,
              ),
              const Spacer(),
              AppText(
                text: 'نعم',
                family: FontFamily.lexendBold,
                size: 16.sp,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
