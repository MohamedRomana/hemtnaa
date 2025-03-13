import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_text.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool? isBack;
  const CustomAppBar({super.key, required this.title, this.isBack = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffF6F6F8),
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(24.r),
          bottomStart: Radius.circular(24.r),
        ),
        border: Border.all(color: const Color(0xffE3E3E3)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffE3E3E3).withOpacity(0.7),
            blurRadius: 5.r,
            spreadRadius: 1.r,
            offset: Offset(0, 5.r),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 16.h),
        child: Row(
          children: [
            AppText(
              text: title,
              size: 30.sp,
              fontWeight: FontWeight.bold,
              start: 24.w,
            ),
            const Spacer(),
            isBack!
                ? Padding(
                  padding: EdgeInsetsDirectional.only(end: 24.w),
                  child: const Icon(Icons.arrow_forward_ios_rounded),
                )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
