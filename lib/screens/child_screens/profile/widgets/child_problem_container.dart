import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';

class ChildProblemContainer extends StatelessWidget {
  const ChildProblemContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
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
          SizedBox(
            width: 200.w,
            child: AppText(
              text: 'مشكلة الطفل',
              size: 18.sp,
              fontWeight: FontWeight.bold,
              bottom: 14.h,
              color: AppColors.primary,
            ),
          ),
          const Divider(color: Color(0xffE0E0E0)),
          SizedBox(height: 24.h),

          SizedBox(
            width: 300.w,
            child: AppText(
              text:
                  'يمكنك اضافة مشكلة الطفل من خلال الضغط على الزر الموجود في الاسفل لإضافة مشكلة جديدة',
              lines: 2,
              size: 14.sp,
              fontWeight: FontWeight.w400,
              bottom: 14.h,
            ),
          ),
        ],
      ),
    );
  }
}
