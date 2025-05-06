import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/widgets/app_button.dart';
import 'package:hemtnaa/core/widgets/app_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../puzzel/puzzel.dart';

class Games extends StatelessWidget {
  const Games({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: EdgeInsetsDirectional.only(
          start: 16.w,
          end: 16.w,
          top: 60.h,
          bottom: 24.h,
        ),
        itemCount: 20,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder:
            (context, index) => Container(
              width: 343.w,
              padding: EdgeInsets.all(16.r),
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
              child: Row(
                children: [
                  Image.asset(
                    Assets.img.pazzel.path,
                    height: 48.w,
                    width: 48.w,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200.w,
                        child: AppText(
                          text: 'بازل',
                          size: 18.sp,
                          color: AppColors.primary,
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 70.w,
                            child: AppText(
                              text: 'سهل',
                              size: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 100.w),
                          SizedBox(
                            height: 20.h,
                            width: 52.w,
                            child: AppButton(
                              onPressed: () {
                                AppRouter.navigateTo(context, const PuzzleScreen());
                              },
                              radius: 4.r,
                              child: AppText(
                                text: 'لعب',
                                size: 11.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
