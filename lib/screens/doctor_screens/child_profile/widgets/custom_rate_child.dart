import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';

class CustomRateChild extends StatelessWidget {
  const CustomRateChild({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        double value = 1.0;
        showDialog(
          context: context,
          builder:
              (context) => Dialog(
                backgroundColor: Colors.transparent,
                child: Container(
                  height: 180.h,
                  width: 285.w,
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: 'تقييم',
                        color: Colors.grey,
                        size: 16.sp,
                        family: FontFamily.lexendBold,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(1000.r),
                            child: Image.asset(
                              Assets.img.man.path,
                              height: 40.w,
                              width: 40.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          AppText(
                            start: 16.r,
                            text: 'احمد محمد',
                            size: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      Center(
                        child: RatingBar.builder(
                          initialRating: 1,
                          allowHalfRating: false,
                          minRating: 1,
                          itemCount: 5,
                          itemSize: 30.sp,
                          direction: Axis.horizontal,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
                          itemBuilder:
                              (context, _) =>
                                  const Icon(Icons.star, color: Colors.amber),
                          onRatingUpdate: (rating) {
                            value = rating;
                            debugPrint(value.toString());
                          },
                        ),
                      ),
                      SizedBox(height: 25.h),
                      Row(
                        children: [
                          const Spacer(),
                          Container(
                            height: 22.h,
                            width: 68.w,
                            padding: EdgeInsets.all(3.r),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Center(
                              child: AppText(
                                text: 'ارسال',
                                size: 12.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Container(
                            height: 22.h,
                            width: 68.w,
                            padding: EdgeInsets.all(3.r),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(
                                width: 1,
                                color: AppColors.primary,
                              ),
                            ),
                            child: Center(
                              child: AppText(
                                text: 'الغاء',
                                size: 12.sp,
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
        );
      },
      child: Container(
        height: 29.h,
        width: 65.w,
        padding: EdgeInsets.all(3.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(width: 1, color: AppColors.primary),
        ),
        child: Center(
          child: AppText(
            text: 'تقييم',
            size: 12.sp,
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
